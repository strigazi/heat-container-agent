FROM registry.fedoraproject.org/fedora:25

# Fill out the labels
LABEL name="heat-container-agent" \
      maintainer="Spyros Trigazis <strigazi@gmail.com>" \
      license="UNKNOWN" \
      summary="Heat Container Agent system image" \
      version="1.0" \
      help="No help" \
      architecture="x86_64" \
      atomic.type="system" \
      distribution-scope="public"

RUN dnf -y --setopt=tsflags=nodocs install \
    findutils os-collect-config os-apply-config \
    os-refresh-config dib-utils python-pip python-docker-py \
    python-yaml python-zaqarclient && \
    dnf clean all

# pip installing dpath as python-dpath is an older version of dpath
# install docker-compose
RUN pip install --no-cache dpath docker-compose

ADD ./scripts/55-heat-config \
  /opt/stack/os-config-refresh/configure.d/

ADD ./scripts/50-heat-config-docker-compose \
  /opt/stack/os-config-refresh/configure.d/

ADD ./scripts/hooks/* \
  /var/lib/heat-config/hooks/

ADD ./scripts/heat-config-notify \
  /usr/bin/heat-config-notify

ADD ./scripts/configure_container_agent.sh /tmp/
RUN chmod 700 /tmp/configure_container_agent.sh
RUN /tmp/configure_container_agent.sh

# "Init script"
RUN mkdir -p /exports/hostfs/usr/bin
COPY init.sh /exports/hostfs/usr/bin
COPY manifest.json service.template config.json.template /exports/

# Execution
CMD ["/usr/bin/os-collect-config"]
