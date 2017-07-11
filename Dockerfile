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

# "Init script"
RUN mkdir -p /exports/hostfs/usr/bin
COPY init.sh /exports/hostfs/usr/bin
COPY manifest.json service.template config.json.template /exports/

# Execution
CMD ["/usr/bin/init.sh"]
