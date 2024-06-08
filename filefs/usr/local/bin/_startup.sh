#!/bin/sh
echo "Preparing Config Folder"
if [ -d "/config/guacamole/" ]; then
  rm /config/guacamole/extensions/guacamole-auth-duo-*.jar
  rm /config/guacamole/extensions/guacamole-auth-header-*.jar
  rm /config/guacamole/extensions/guacamole-auth-jdbc-mysql-*.jar
  rm /config/guacamole/extensions/guacamole-auth-jdbc-postgresql-*.jar
  rm /config/guacamole/extensions/guacamole-auth-jdbc-sqlserver-*.jar
  rm /config/guacamole/extensions/guacamole-auth-json-*.jar
  rm /config/guacamole/extensions/guacamole-auth-ldap-*.jar
  rm /config/guacamole/extensions/guacamole-auth-quickconnect-*.jar
  rm /config/guacamole/extensions/guacamole-auth-sso-openid-*.jar
  rm /config/guacamole/extensions/guacamole-auth-sso-saml-*.jar
  rm /config/guacamole/extensions/guacamole-auth-sso-cas-*.jar
  rm /config/guacamole/extensions/guacamole-auth-totp-*.jar
  rm /config/guacamole/extensions/guacamole-vault-ksm-*.jar
  rm /config/guacamole/extensions/guacamole-history-recording-storage-*.jar
  rm -r /config/guacamole/extensions-available
  rm -r /config/guacamole/lib
  rm -r /config/guacamole/schema
  cp -r /app/guacamole/extensions/*.jar /config/guacamole/extensions
  cp -r /app/guacamole/extensions-available /config/guacamole
  cp -r /app/guacamole/lib /config/guacamole
  cp -r /app/guacamole/schema /config/guacamole
fi
cp -rn /app/guacamole /config
mkdir -p /root/.config/freerdp/known_hosts
chown -R tomcat:tomcat /config/guacamole
chown -R tomcat:tomcat /opt/tomcat # Might help to fix issues with bug on tomcat logs

# enable extensions
for i in $(echo "$EXTENSIONS" | tr "," " "); do
  cp ${GUACAMOLE_HOME}/extensions-available/guacamole-${i}-${GUAC_VER}.jar ${GUACAMOLE_HOME}/extensions
done
