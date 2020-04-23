#!/usr/bin/env bash

php -r "readfile('https://getcomposer.org/installer');" | php
php ${MATECAT_HOME}/composer.phar install

pushd ./support_scripts/grunt

    type_msg=$( type grunt >/dev/null )

    if ! type grunt >/dev/null; then
        rm -rf ./node_modules
        echo "Installing grunt"
        npm install -g grunt-cli
    fi

    npm install
    grunt development

popd

pushd ./nodejs
    if [[ -z "node_modules" ]]; then
        # NodeJs install sse-channel events
        sed -ri -e "s/localhost/amq/" server.js
    fi
    npm install
popd
