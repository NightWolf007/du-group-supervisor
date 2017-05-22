FROM elixir:1.4.2
MAINTAINER dsinelnikov96@gmail.com

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 17.03.1-ce

RUN apt-get update && \
    apt-get install -y ca-certificates curl tar && \
    apt-get clean

RUN set -ex; \
    curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz"; \
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	dockerd -v; \
	docker -v

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

ENV MIX_ENV=prod
ENV APP_HOME=/app

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY mix.exs $APP_HOME/
COPY mix.lock $APP_HOME/
RUN mix local.hex --force && mix local.rebar --force && \
    mix deps.get && mix deps.compile

COPY . $APP_HOME
RUN mix compile

CMD ["mix", "run", "--no-halt"]
