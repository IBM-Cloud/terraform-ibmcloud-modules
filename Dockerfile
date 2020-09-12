FROM ubuntu:18.04
LABEL "maintainer"="chuesgen@ibm.com"
ARG WDIR=/terraform-ibmcloud-modules
ENV HOME /root

ENV DEBIAN_FRONTEND noninteractive
ENV TZ America/Central
RUN set -ex && \
    apt-get update && \
    apt-get install -y \
    tzdata \
    git \
    mercurial \
    build-essential \
    libssl-dev \
    libbz2-dev \
    zlib1g-dev \
    libffi-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    wget \
    jq \
    vim \
    unzip \
    iputils-ping \
    dnsutils \
    qemu-utils \
    qemu \
    qemu-system-x86 \
    cloud-image-utils \
    sudo && \
    # container vulnerability scan
    apt-get upgrade -y \
    e2fsprogs \
    libgcrypt20 \
    libgnutls30

    # golang 1.13, the default golang is too old
RUN set -ex && \
    wget https://dl.google.com/go/go1.13.9.linux-amd64.tar.gz && \
    tar xzf go1.13.9.linux-amd64.tar.gz && \
    rm go1.13.9.linux-amd64.tar.gz && \
    mv go /usr/local/go-1.13

ENV GOROOT=/usr/local/go-1.13
ENV PATH=$GOROOT/bin:${HOME}/go/bin:$PATH

# terraform 0.12.25
RUN set -ex && \
    wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip && \
    unzip terraform_0.12.25_linux_amd64.zip && \
    chmod +x terraform && \
    rm terraform_0.12.25_linux_amd64.zip && \
    mv terraform /usr/local/bin && \

    # ibm provider
    wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.7.1/linux_amd64.zip && \
    unzip linux_amd64.zip && \
    chmod +x terraform-provider-ibm_* && \
    mv terraform-provider-ibm_* /usr/local/bin && \
    rm linux_amd64.zip && \

    # terratest
    go get github.com/gruntwork-io/terratest/modules/terraform && \

    # go testsum
    go get gotest.tools/gotestsum

RUN apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR ${WDIR}
