FROM alpine:3.12.0
RUN apk add --no-cache openssh-server openssh-client openvpn oath-toolkit-oathtool
COPY scripts/docker-entrypoint.sh /usr/local/bin
COPY scripts/openvpn_autostart /usr/local/bin/
COPY scripts/ssh_force_command.txt /tmp/
RUN chmod +x /usr/local/bin/openvpn_autostart \
    && rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key \
    && mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh \
    && touch /root/.ssh/authorized_keys \
    && chmod 600 /root/.ssh/authorized_keys \
    && passwd -u root \
    && cat /tmp/ssh_force_command.txt >> /etc/ssh/sshd_config \
    && rm /tmp/ssh_force_command.txt

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]

