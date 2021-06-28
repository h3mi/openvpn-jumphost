FROM alpine:3.14.0
#RUN apk add --no-cache openssh-server openssh-client openvpn oath-toolkit-oathtool zenity libcanberra-gtk3 ca-certificates alsa-lib hicolor-icon-theme mesa-dri-intel mesa-gl
COPY scripts/docker-entrypoint.sh /usr/local/bin
COPY scripts/init-vpn /usr/local/bin
#COPY scripts/ssh_force_command.txt /tmp/
RUN apk update && apk upgrade
RUN apk add --no-cache bash openvpn oath-toolkit-oathtool ca-certificates dropbear dropbear-ssh \
    && chmod +x /usr/local/bin/init-vpn \
    && passwd -u -d root 
#    && rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key \
#    && mkdir -p /root/.ssh \
#    && chmod 700 /root/.ssh \
#    && touch /root/.ssh/authorized_keys \
#    && chmod 600 /root/.ssh/authorized_keys \
#    && cat /tmp/ssh_force_command.txt >> /etc/ssh/sshd_config \
#    && rm /tmp/ssh_force_command.txt

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
