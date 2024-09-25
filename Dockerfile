# syntax=docker/dockerfile:1
FROM ruby:3.1.2-alpine AS builder
RUN apk update && \
    apk add --no-cache tzdata sqlite build-base
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install

FROM builder AS dev
COPY . /app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.1.2-alpine AS prod
RUN apk update && \
    apk add --no-cache tzdata sqlite
WORKDIR /app
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
