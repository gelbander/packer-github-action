FROM hashicorp/packer:1.6.1

LABEL "com.github.actions.name" = "Packer"
LABEL "com.github.actions.description" = "Run packer build"

LABEL "repository" = "https://github.com/gelbander/packer-github-action"
LABEL "homepage" = "https://github.com/gelbander/packer-github-action"
LABEL "maintainer" = "Gustaf Elbander <gelbander@gmail.com>"
LABEL "packer-version" = "1.6.1"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
