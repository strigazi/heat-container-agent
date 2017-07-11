system-buildah generate-files \
--description='Heat Container Agent system image' \
heat-container-agent

system-buildah generate-dockerfile \
--from-base registry.fedoraproject.org/fedora:25 \
--summary "Heat Container Agent system image" \
--version 1.0 \
--maintainer '"Spyros Trigazis <strigazi@gmail.com>"' \
--scope public \
--output /home/fedora/heat-container-agent \
heat-container-agent
