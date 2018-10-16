FROM ubuntu:18.10

# Install ngrok
RUN apt install -y curl unzip
RUN curl -Lk 'https://dl.ngrok.com/ngrok_2.0.15_linux_amd64.zip' > ngrok.zip
RUN unzip ngrok.zip -d /bin && rm -f ngrok.zip
RUN echo 'inspect_addr: 0.0.0.0:4040' > /.ngrok

# Install sshd
RUN apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Add start script
RUN mkdir -p /app
ADD start.sh /app/

EXPOSE 4040

ENTRYPOINT ["/app/start.sh"]
