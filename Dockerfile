FROM lsiobase/alpine:3.12
LABEL maintainer="Alexandre P."

RUN \
  apk add --no-cache --upgrade --virtual=build-dependencies \
      curl \
      unzip && \

  apk add --no-cache --upgrade \
      tzdata \
      python3 && \

  echo "**** install dockupdate ****" && \
  mkdir -p /app/dockupdate && \
  curl -sL -o /tmp/dockupdater-master.zip \
      https://github.com/dockupdater/dockupdater/archive/master.zip && \
  unzip -d /tmp/ /tmp/dockupdater-master.zip && \

  for data in README.md requirements.txt setup.py entrypoint dockupdater; \
  do cp -Rp "/tmp/dockupdater-master/$data" /app/dockupdate/; \
  done && \

  echo "**** install pip packages ****" && \
  python3 -m ensurepip && \
  rm -rf /usr/lib/python*/ensurepip && \
  cd /app/dockupdate && \
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
