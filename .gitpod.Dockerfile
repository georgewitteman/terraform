FROM gitpod/workspace-full:latest

# Partially copied from https://github.com/gitpod-io/template-terraform-aws
USER root
RUN install-packages dnsutils gnupg software-properties-common curl
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
  apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
  install-packages terraform

USER gitpod
