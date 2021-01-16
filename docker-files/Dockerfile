ARG ARCH=
FROM ${ARCH}python:3-slim-buster as base

RUN apt-get update && apt-get install -y \
  curl              \
  lm-sensors        \
  wireless-tools    \
  iputils-ping && \
  rm -rf /var/lib/apt/lists/*

RUN python -m venv /opt/venv
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"


FROM ${ARCH}base as compile

# Install package
RUN apt-get update && apt-get install -y gcc && rm -rf /var/lib/apt/lists/*

# Force rebuild otherwise it could be cached without rerun
ARG VCS_REF
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
