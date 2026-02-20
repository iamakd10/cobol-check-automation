zowe config init --global-config
zowe config set profiles.zosmf.properties.host $ZOWE_HOST 
zowe config set profiles.zosmf.properties.port 10443
zowe config set profiles.zosmf.properties.user $ZOWE_USERNAME 
zowe config set profiles.zosmf.properties.password $ZOWE_PASSWORD 
zowe config set profiles.zosmf.properties.rejectUnauthorized false
LOWERCASE_USERNAME=$(echo "$ZOWE_USERNAME" | tr '[:upper:]' '[:lower:]')
if ! zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck" &>/dev/null; then
  echo "Directory does not exist. Creating it..."
  zowe zos-files create uss-directory "/z/$LOWERCASE_USERNAME/cobolcheck"
else
  echo "Directory already exists!"
fi
zowe zos-files upload dir-to-uss "./cobol-check" "/z/$LOWERCASE_USERNAME/cobolcheck" --recursive --binary-files "cobol-check-0.2.9.jar"
echo "Verifying upload..."
zowe zos-files list uss-files "/z/$LOWERCASE_USERNAME/cobolcheck"
