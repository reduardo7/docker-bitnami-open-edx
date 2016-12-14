FROM ubuntu:16.04

MAINTAINER Eduardo Daniel Cuomo <reduardo7@gmail.com> <eduardo.cuomo.ar@gmail.com>
LABEL description="Open EDX Fullstack by Bitnami"

ENV MYSQL_ROOT_PASS root

# Demo course for Open edX
ENV EDX_SETUP_DEMO_COURSES 'n'

# Installation folder
ENV EDX_SETUP_INSTALL_FOLDER '/opt/bitnami'

# Your real name [User Name]
ENV EDX_SETUP_REAL_NAME 'Admin User'

# Email Address
ENV EDX_SETUP_EMAIL admin@edx.com

# Login [user]
ENV EDX_SETUP_USER admin

# Password
ENV EDX_SETUP_PASSWORD 123456

# eMail Support
ENV EDX_SETUP_EMAIL_SUPPORT n

# Hostname that will be used to create internal URLs. If this value is incorrect, 
# you may be unable to access your Open edX installation from other computers.
ENV EDX_SETUP_HOSTNAME 127.0.0.1

RUN echo "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASS}" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASS}" | debconf-set-selections

RUN apt-get update && apt-get install -y mysql-server curl sudo

RUN mkdir /setup-files
WORKDIR /setup-files

#ADD https://bitnami.com/redirect/to/129363/bitnami-edx-20160414-5-linux-x64-installer.run /setup-files/bitnami-edx-linux-x64-installer.run
ADD bitnami-edx-20160414-5-linux-x64-installer.run /setup-files/bitnami-edx-linux-x64-installer.run
RUN chmod a+x bitnami-edx-linux-x64-installer.run

RUN ./bitnami-edx-linux-x64-installer.run <<EOF
${EDX_SETUP_DEMO_COURSES}
y
${EDX_SETUP_INSTALL_FOLDER}
${EDX_SETUP_REAL_NAME}
${EDX_SETUP_EMAIL}
${EDX_SETUP_USER}
${EDX_SETUP_PASSWORD}
${EDX_SETUP_PASSWORD}
${EDX_SETUP_EMAIL_SUPPORT}
${EDX_SETUP_HOSTNAME}
y
EOF

# Clean
RUN apt-get autoremove -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp /setup-files

# Command
CMD /opt/bitnami/ctlscript.sh restart
