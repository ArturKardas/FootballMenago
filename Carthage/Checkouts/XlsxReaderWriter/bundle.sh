
#!/bin/bash
# gem sources --add https://rubygems.org

CURRENTFOLDER=$(pwd)
mkdir -p $CURRENTFOLDER/vendor/ 
gem install bundle --install-dir $(pwd)/vendor/
export BUNDLE=$CURRENTFOLDER/vendor/bin/bundle
alias lbundle="$BUNDLE"

lbundle config set path 'vendor/cache'
lbundle install

echo ""
echo " ------------------------------------------------------"
echo "bundle & gems install at path $BUNDLE"
echo " ------------------------------------------------------"
echo "use lbundle to use this version"
echo ""