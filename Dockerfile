# ---- Build Stage ----
FROM elixir:1.9-alpine as app_builder

# install dependencies
RUN apk add --update git build-base nodejs npm yarn python

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# install Hex + Rebar
RUN mix do local.hex --force, local.rebar --force

# Set environment variables for building the application
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# build assets
#COPY assets assets
#RUN cd assets && npm install && npm run deploy
RUN mix phx.digest

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
# at this point we should copy the rel directory but
# we are not using it so we can omit it
COPY rel rel
RUN mix release


# ---- Application Stage ----
# FROM debian:strech AS app when using this shared libs are missing
# FROM elixir:1.9  AS app problems with db
FROM alpine:3.9 AS app

# install runtime dependencies
RUN apk add --update bash openssl postgresql-client

EXPOSE 4000
ENV MIX_ENV=prod

# prepare app directory
RUN mkdir /app
WORKDIR /app

# copy release to app container
COPY --from=app_builder /app/_build/prod/rel/video .
COPY entrypoint.sh .
RUN chown -R nobody: /app
USER nobody

# run the start-up script which run migrations and then the app
ENV HOME=/app
#ENTRYPOINT ["/scripts/start_commands.sh"]
CMD ["bash", "/app/entrypoint.sh"]
