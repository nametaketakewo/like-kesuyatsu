#!/bin/bash

git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
mkdir /usr/local/rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
echo "Defaults !secure_path" >> /etc/sudoers.d/rbenv
echo "Defaults env_keep += \"PATH RBENV_ROOT\"" >> /etc/sudoers.d/rbenv
echo "export RBENV_ROOT=\"/usr/local/rbenv\"" >> /etc/profile.d/rbenv.sh
echo "PATH=\"\${RBENV_ROOT}/bin:\${PATH}\"" >> /etc/profile.d/rbenv.sh
echo "eval \"\$(rbenv init -)\"" >> /etc/profile.d/rbenv.sh
chmod -R 775 /usr/local/rbenv
chown -R vagrant:vagrant /usr/local/rbenv
