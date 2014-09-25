server {
    listen 443 ssl;

    ssl                  on;
    ssl_certificate  /etc/ssl/certs/dev.mywebsite.com.crt;
    ssl_certificate_key  /etc/ssl/dev.mywebsite.com.key;

    ssl_session_timeout  5m;
    ssl_protocols             SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers               AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH;
    ssl_prefer_server_ciphers on;

    root /var/demo/dev.mywebsite.com;
    index index.html index.htm index.hh index.php;

    access_log /var/log/nginx/dev.mywebsite.com-access.log;
    error_log  /var/log/nginx/dev.mywebsite.com-error.log error;

    server_name dev.mywebsite.com;

    ## allow for html source of super high volume product pages to be put in "static" directory and served without php
    if ($http_host ~ "^(.*)mywebsite.com"){
        set $rule_0 1;
    }
    if ($uri ~ "^(.*)$"){
        set $rule_0 2$rule_0;
    }
    if ($http_referer !~* ".*mywebsite.com"){
        set $rule_0 3$rule_0;
    }
    if (-f $document_root/static$request_uri){
        set $rule_0 4$rule_0;
    }
    if ($rule_0 = "4321"){
        rewrite ^/.*$ /static/$request_uri last;
    }

    ## Images and static content is treated different
    location ~* ^.+.(js|css|png|jpg|jpeg|gif|ico|woff|ttf|svg|otf)$ {
            access_log        off;
            root /var/demo/dev.mywebsite.com/;
            expires 30d;
            add_header Pragma public;
            add_header Cache-Control "public";
    }

    location / {
        index index.html index.php; ## Allow a static html file to be shown first
        try_files $uri $uri/ @handler;
        expires 30d; ## Assume all files are cachable
    }

    ## These locations would be hidden by .htaccess normally
    location /includes/           { deny all; }
    location /lib/                { deny all; }
    location /var/                { deny all; }
    location /nginx-config/       { deny all; }

    location  /. { ## Disable .htaccess and other hidden files
        return 404;
    }

    location @handler {
        rewrite / /index.php;
    }

    location ~ .php/ { ## Forward paths like /js/index.php/x.js to relevant handler
        rewrite ^(.*.php)/ $1 last;
    }

    location ~ .php$ { ## Execute PHP scripts
        if (!-e $request_filename) { rewrite / /index.php last; } ## Catch 404s that try_files miss

        expires        off; ## Do not cache dynamic content
        fastcgi_pass   fastcgi_server:9000;
        fastcgi_buffer_size 128k;
        fastcgi_buffers 4 256k;
        fastcgi_busy_buffers_size 256k;
        fastcgi_read_timeout 300;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params; ## See /etc/nginx/fastcgi_params
        fastcgi_param GEOIP_REGION $geoip_region;
        fastcgi_param GEOIP_REGION_NAME $geoip_region_name;
        fastcgi_param GEOIP_CITY $geoip_city;
        fastcgi_param GEOIP_AREA_CODE $geoip_area_code;
        fastcgi_param GEOIP_LATITUDE $geoip_latitude;
        fastcgi_param GEOIP_LONGITUDE $geoip_longitude;
        fastcgi_param GEOIP_POSTAL_CODE $geoip_postal_code;
    }

}
