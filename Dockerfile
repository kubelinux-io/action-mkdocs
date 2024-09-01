FROM python:3-alpine

LABEL org.opencontainers.image.description="Custom container with additional features to generate mkdocs-material sites."
LABEL org.opencontainers.image.source="https://github.com/kubelinux-io/action-mkdocs"

RUN apk add --no-cache \
    bash \
    git \
    git-lfs \
    github-cli \
    github-cli-bash-completion

# Install some Python global packages for the build container.
RUN pip3 install \
    --break-system-packages \
    mkdocs \
    mkdocs-awesome-pages-plugin \
    mkdocs-git-authors-plugin \
    mkdocs-git-revision-date-localized-plugin \
    mkdocs-material \
    mkdocs-material[imaging] \
    mkdocs-redirects \
    mkdocs-rss-plugin \
    mike \
    pymdown-extensions && \
    pip3 cache purge

# Add a non-privileged user to build sites with.
RUN adduser -S mkdocs

# Change to the non-privileged user.
USER mkdocs

# Change the command to use mkdocs by default.
CMD [ "/usr/local/bin/mkdocs" ]