FROM alpine:3.5

ARG depends="py-pip py-lxml"
ARG make_depends="build-base git libffi-dev linux-headers openssl-dev python-dev"

RUN apk add --no-cache $depends && \
apk add --no-cache $make_depends && \
pip install --no-cache-dir --upgrade pip && \
pip install --no-cache-dir os-collect-config os-apply-config os-refresh-config && \
apk del --no-cache $make_depends
