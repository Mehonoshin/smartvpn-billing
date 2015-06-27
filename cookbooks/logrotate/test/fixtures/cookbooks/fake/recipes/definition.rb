logrotate_app 'tomcat-myapp' do
  path      '/var/log/tomcat/myapp.log'
  frequency 'daily'
  rotate    30
  create    '644 root adm'
end

logrotate_app 'tomcat-myapp-multi-path' do
  path      %w(/var/log/tomcat/myapp.log /opt/local/tomcat/catalina.out)
  frequency 'daily'
  create    '644 root adm'
  rotate    7
end

logrotate_app 'tomcat-myapp-no-enable' do
  path      '/var/log/tomcat/myapp.log'
  frequency 'daily'
  rotate    30
  enable    false
end

logrotate_app 'tomcat-myapp-alt-cookbook' do
  cookbook  'fake'
  path      '/var/log/tomcat/myapp.log'
  frequency 'daily'
  rotate    30
end

logrotate_app 'tomcat-myapp-custom-options' do
  path        '/var/log/tomcat/myapp.log'
  options     %w(missingok delaycompress)
  frequency   'daily'
  rotate      30
  create      '644 root adm'
  firstaction 'echo "hi"'
end
