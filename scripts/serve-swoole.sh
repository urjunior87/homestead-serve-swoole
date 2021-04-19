#!/usr/bin/env bash
# Author: Joonion Tee 

#Split ":"
arrConfig=(${2//:/ })


block="
map \$http_upgrade \$connection_upgrade {
    default upgrade;
    ''      close;
}
server {
    listen 80;
    server_name ${1};
    root ${arrConfig[0]};
    index index.php;

    location = /index.php {
        # Ensure that there is no such file named \"not_exists\"
        # in your \"public\" directory.
        try_files /not_exists @swoole;
    }
    # any php files must not be accessed
    #location ~* \\.php\$ {
    #    return 404;
    #}
    location / {
        try_files \$uri \$uri/ @swoole;
    }

    location @swoole {
        set \$suffix "";

        if (\$uri = /index.php) {
            set \$suffix ?\$query_string;
        }

        proxy_http_version 1.1;
        proxy_set_header Host \$http_host;
        proxy_set_header Scheme \$scheme;
        proxy_set_header SERVER_PORT \$server_port;
        proxy_set_header REMOTE_ADDR \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;

        # IF https
        # proxy_set_header HTTPS \"on\";

        proxy_pass http://127.0.0.1:${arrConfig[1]}\$suffix;
    }
}
"


echo "$block" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
