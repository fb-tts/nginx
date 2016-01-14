
server {

        root /home/www/wwwdev.thingtosell.com/web;
        index index.html index.htm;

        server_name wwwdev.thingtosell.com;

add_header X-Frame-Options "ALLOW-FROM https://apps.facebook.com/";
add_header Frame-Options "ALLOW-FROM https://apps.facebook.com/";

        location /      {
                proxy_pass http://127.0.0.1:3000;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }

    access_log /home/www/shared/log/wwwdev.thingtosell-access.log;
    error_log /home/www/shared/log/wwwdev.thingtosell-error.log;
    error_page 404 /404.html;
}
