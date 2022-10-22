# syntax=docker/dockerfile:1
FROM ruby:3-alpine
RUN apk update && \
    apk add --no-cache tzdata sqlite build-base
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install
COPY . /app
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
