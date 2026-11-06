# Local preview of the MSIG site — same Ruby as the deploy workflow (3.3).
# Usage: docker compose up   →   http://localhost:4000
FROM ruby:3.3

WORKDIR /site

# Install gems in their own layer so they're cached between rebuilds.
COPY Gemfile ./
RUN bundle install

EXPOSE 4000 35729

# Bind to 0.0.0.0 so the host can reach the server; --force_polling because
# file-change events don't cross a Docker bind mount on macOS.
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--force_polling"]
