FROM python:3.12-slim

RUN apt-get update && \
    apt-get install -y pipx

RUN PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin PIPX_MAN_DIR=/usr/local/share/man pipx install --include-deps ansible

COPY ansible-requirements.yml /ansible-requirements.yml
RUN ansible-galaxy install -r /ansible-requirements.yml && \
    rm -f /ansible-requirements.yml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]