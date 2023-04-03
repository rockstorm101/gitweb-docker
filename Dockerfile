FROM nginx:1.22.1-alpine

# Install GitWeb and dependencies
ENV GITS_VERSION=2.38.4-r1
RUN set -ex; \
    apk add --no-cache \
        fcgiwrap \
        fcgiwrap-openrc \
	    git-gitweb=${GITS_VERSION} \
        git-daemon=${GITS_VERSION} \
        openrc \
        perl-cgi \
	;

# Install fcgiwrap start script on Nginx's docker-entrypoint
ENV FCGIWRAP_BIN=50-start-fcgiwrap.sh \
    ENTRYPOINT_DIR=/docker-entrypoint.d
ENV FCGIWRAP_PATH=${ENTRYPOINT_DIR}/${FCGIWRAP_BIN}
COPY ${FCGIWRAP_BIN} ${FCGIWRAP_PATH}
RUN set -eux; chmod 755 "${FCGIWRAP_PATH}"

# Configure Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Configure GitWeb
COPY gitweb.conf /etc/gitweb.conf
