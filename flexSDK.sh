#! /bin/bash
if [ -f vendor/flex_sdk_4.6/bin/mxmlc ]; then
    echo '"vendor/flex_sdk_4.6/bin/mxmlc" is already installed... skip downloading...'
else
	if [ ! -d vendor ]; then
        echo 'creating directory "vendor"...'
        mkdir vendor
    fi

	if [ ! -f vendor/flex_sdk_4.6.zip ]; then
	    echo 'downloading "flex_sdk_4.6.zip"...'
	    curl -o 'vendor/flex_sdk_4.6.zip' 'http://download.macromedia.com/pub/flex/sdk/flex_sdk_4.6.zip'
    fi

    echo 'extracting...'
    unzip 'vendor/flex_sdk_4.6.zip' -d 'vendor/flex_sdk_4.6'
    #rm 'vendor/flex_sdk_4.6.zip'
    chmod -R 755 './vendor/flex_sdk_4.6'

    echo 'installation complete...'
    exit
fi