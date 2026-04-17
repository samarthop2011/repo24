FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install SSH + tools
RUN apt update && apt install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    nano \
    net-tools \
    iputils-ping \
    && mkdir /var/run/sshd

# Set root password
RUN echo 'root:sam123' | chpasswd

# Enable root login + password auth
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Start SSH on Railway PORT
CMD bash -c "echo \"Port $PORT\" >> /etc/ssh/sshd_config && /usr/sbin/sshd -D"
