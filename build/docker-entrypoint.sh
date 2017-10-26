#!/bin/bash

# CREATE LARAVEL APP IF NEEDED
if ! [ "$(ls -A /var/www/html/)" ]; then

    cd /var/www/html/
    echo '<?php echo phpinfo(); ?>' > index.html

fi

exec "$@"