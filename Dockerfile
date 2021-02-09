FROM lsiobase/alpine:3.12

# Set args & labels
ARG DOCKUPDATER_RELEASE
LABEL maintainer="Alexandre P."

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
      curl && \
  apk add --no-cache --upgrade \
      tzdata \
      python3 && \

  echo "**** install dockupdate ****" && \
  mkdir -p /app/dockupdater && \
  if [ -z ${DOCKUPDATER_RELEASE+x} ]; \
  then \
	    DOCKUPDATER_RELEASE=$(curl -sX GET "https://api.github.com/repos/dockupdater/dockupdater/releases/latest" \
	    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -sL -o \
      /tmp/dockupdater.tar.gz \
      "https://github.com/dockupdater/dockupdater/archive/${DOCKUPDATER_RELEASE}.tar.gz" && \
  mkdir /tmp/dockupdater && \
  tar xf \
	    /tmp/dockupdater.tar.gz -C \
	    /tmp/dockupdater --strip-components=1 && \
  for data in README.md requirements.txt setup.py entrypoint dockupdater; \
  do \
      cp -Rp "/tmp/dockupdater/$data" /app/dockupdater/; \
  done && \

  echo "**** install pip packages ****" && \
  python3 -m ensurepip && \
  rm -rf /usr/lib/python*/ensurepip && \
  pip3 install --upgrade  pip && \
  cd /app/dockupdater && \
  pip3 install --no-cache-dir -r requirements.txt && \
  pip3 install --no-cache-dir . && \

  echo "**** cleanup ****" && \
  apk del --purge \
	    build-dependencies && \
  rm -rf \
	    /root/.cache \
	    /tmp/*

# add local files
COPY root/ /
