FROM ubuntu:16.04

MAINTAINER Eduardo Daniel Cuomo <reduardo7@gmail.com> <eduardo.cuomo.ar@gmail.com>
LABEL description="Open EDX Fullstack by Bitnami"

ARG MYSQL_ROOT_PASS=root

# Demo course for Open edX
# @TODO: Setup script is not ready for 'y'
ARG EDX_SETUP_DEMO_COURSES='n'

# Installation folder
ARG EDX_SETUP_INSTALL_FOLDER='/opt/bitnami'

# Your real name [User Name]
ARG EDX_SETUP_REAL_NAME='Admin User'

# Email Address
ARG EDX_SETUP_EMAIL=admin@edx.com

# Login [user]
ARG EDX_SETUP_USER=admin

# Password
ARG EDX_SETUP_PASSWORD=123456

# eMail Support
ARG EDX_SETUP_EMAIL_SUPPORT=n

# Hostname that will be used to create internal URLs. If this value is incorrect, 
# you may be unable to access your Open edX installation from other computers.
ARG EDX_SETUP_HOSTNAME=''

RUN echo "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASS}" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASS}" | debconf-set-selections

RUN apt-get update && apt-get install -y mysql-server curl sudo

RUN mkdir /setup-files
WORKDIR /setup-files

ADD https://bitnami.com/redirect/to/129363/bitnami-edx-20160414-5-linux-x64-installer.run /setup-files/bitnami-edx-linux-x64-installer.run
#ADD bitnami-edx-20160414-5-linux-x64-installer.run /setup-files/bitnami-edx-linux-x64-installer.run
RUN chmod a+x bitnami-edx-linux-x64-installer.run

RUN echo "${EDX_SETUP_DEMO_COURSES}\ny\n${EDX_SETUP_INSTALL_FOLDER}\n${EDX_SETUP_REAL_NAME}\n${EDX_SETUP_EMAIL}\n${EDX_SETUP_USER}\n${EDX_SETUP_PASSWORD}\n${EDX_SETUP_PASSWORD}\n${EDX_SETUP_EMAIL_SUPPORT}\n${EDX_SETUP_HOSTNAME}\ny\n" | ./bitnami-edx-linux-x64-installer.run

# Clean
RUN apt-get autoremove -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp /setup-files

EXPOSE 80
EXPOSE 8443

# Command
COPY start.sh /start.sh
WORKDIR /
CMD /start.sh
