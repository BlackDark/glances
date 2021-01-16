#
# Glances Dockerfile (based on Ubuntu)
#
# https://github.com/nicolargo/glances
#

ARG ARCH=
FROM ${ARCH}python:3-alpine

# Force rebuild otherwise it could be cached without rerun
ARG VCS_REF
RUN apk add build-base linux-headers
RUN pip install glances[all]

# Define working directory.
WORKDIR /glances

# EXPOSE PORT (XMLRPC / WebUI)
EXPOSE 61209 61208

# Define default command.
CMD python3 -m glances -C /glances/conf/glances.conf $GLANCES_OPT
