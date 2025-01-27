#!/bin/bash

change_php_vars(){
    for FILE in /etc/php/*/fpm/php.ini
    do
        [[ -e $FILE ]] || break
        sed -i "s/memory_limit = .*/memory_limit = 2048M/" "$FILE"
        sed -i "s/max_execution_time = .*/max_execution_time = 300/" "$FILE"
        sed -i "s/upload_max_filesize = .*/upload_max_filesize = 50M/" "$FILE"
        sed -i "s/post_max_size = .*/post_max_size = 50M/" "$FILE"
        sed -i "s/pm.max_children = .*/pm.max_children = 100/" "$FILE"
    done
    for FILE in /etc/php/*/fpm/pool.d/www.conf
    do
        [[ -e $FILE ]] || break
        sed -i "s/pm.max_children = .*/pm.max_children = 100/" "$FILE"
    done
}

echo "Configure PHP  | Change PHP values ..." && change_php_vars
echo "Starting PHP FPM"

/usr/sbin/php-fpm7.4 -R -F
