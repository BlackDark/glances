ARG ARCH=
FROM ${ARCH}python:3-alpine as base

RUN python -m venv /opt/venv
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"


FROM ${ARCH}base as compile
# Force rebuild otherwise it could be cached without rerun
ARG VCS_REF
RUN apk --no-cache add build-base linux-headers
RUN pip install glances[all]


FROM ${ARCH}base
# Must used calibre package to be able to run external module
#ENV DEBIAN_FRONTEND noninteractive

COPY --from=compile /opt/venv /opt/venv
# Define working directory.
WORKDIR /glances

# EXPOSE PORT (XMLRPC / WebUI)
EXPOSE 61209 61208

# Define default command.
CMD python3 -m glances -C /glances/conf/glances.conf $GLANCES_OPT

