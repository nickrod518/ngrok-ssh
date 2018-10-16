FROM ubuntu:18.10

RUN apt-get update

# Install ngrok
RUN apt-get install -y curl unzip
RUN curl -Lk 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip' > ngrok.zip
RUN unzip ngrok.zip -d /bin && rm -f ngrok.zip

# Install sshd
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Set default password for root
RUN echo 'root:password' | chpasswd

# Unblock port 22
EXPOSE 22

# Add start script
RUN mkdir -p /app
ADD start.sh /app/
ENTRYPOINT ["/app/start.sh"]
