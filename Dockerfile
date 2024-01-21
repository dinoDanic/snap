ARG ELIXIR_VERSION=1.14.0
ARG OTP_VERSION=25.2
ARG DEBIAN_VERSION=bullseye-20221004-slim
ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:bullseye-20240110"

FROM ${BUILDER_IMAGE} as builder

# ARG database_url
# ENV DATABASE_URL=$database_url
# ARG port
# ENV PORT=$port
# ARG secret_key_base
# ENV SECRET_KEY_BASE=$secret_key_base
# ARG release_level
# ENV RELEASE_LEVEL=$release_level

# set build ENV
ENV MIX_ENV="prod"

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git npm curl nodejs \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/

RUN mix deps.compile

COPY priv priv

COPY lib lib

COPY assets assets

# Install all npm packages
WORKDIR assets
RUN node --version
RUN npm install

WORKDIR ../

# compile assets
RUN mix assets.deploy
#rucno ovo dok ne skuzim kako se to radi
COPY assets/js/cookieconsent-config.js priv/static/assets/.

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

RUN mix release

COPY . .

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales curl nodejs \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*
  RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/_build/${MIX_ENV}/rel/. ./

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

USER nobody

CMD ["mix", "phx.server"]

