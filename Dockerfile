FROM ubuntu

RUN apt-get update && \
    apt-get install -y curl ssh git vim perl python default-jdk gnupg iputils-ping dnsutils

WORKDIR /opt

# Eclipse IDE for JavaEE
RUN curl http://mirrors.syringanetworks.net/eclipse/technology/epp/downloads/release/2019-06/R/eclipse-jee-2019-06-R-linux-gtk-x86_64.tar.gz --output eclipse-jee-2019-06-R-linux-gtk-x86_64.tar && \
    tar -xf eclipse-jee-2019-06-R-linux-gtk-x86_64.tar && \
    rm eclipse-jee-2019-06-R-linux-gtk-x86_64.tar && \
    echo "alias eclipse='/opt/eclipse/eclipse'" >> /root/.bash_aliases

# Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    echo "alias chrome='/opt/google/chrome/chrome --no-sandbox'" >> /root/.bash_aliases


# VSCode
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - && \
    echo 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main' | tee /etc/apt/sources.list.d/vscode.list && \
    apt-get update && \
    apt-get install -y code && \
    echo "alias code='code --user-data-dir=/tmp/vscode'" >> /root/.bash_aliases

# SSH Server
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:Password1' | chpasswd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config && \
    echo 'X11Forwarding yes' >> /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "export VISIBLE=now" >> /etc/profile && \
    echo "ALL:ALL" >> /dev/hosts.allow && \
    echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config

ENV NOTVISIBLE "in users profile"

EXPOSE 22

COPY entrypoint.sh /

ENTRYPOINT /entrypoint.sh


