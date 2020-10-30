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

# tfenv and terraform
RUN set -ex && \
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
    echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=$HOME/.tfenv/bin:$PATH' >> ~/.bashrc
ENV PATH=${HOME}/.tfenv/bin:$PATH
RUN set -ex && \
    tfenv install 0.12.29 && \
    tfenv install latest:^0.13 && \
    tfenv use 0.12.29 && \
    # ibm provider
    wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.14.0/linux_amd64.zip && \
    unzip linux_amd64.zip && \
    chmod +x terraform-provider-ibm_* && \
    mkdir -p ~/.terraform.d/plugins && \
    mv terraform-provider-ibm_* ~/.terraform.d/plugins && \
    rm linux_amd64.zip && \

    # terratest
    go get github.com/gruntwork-io/terratest/modules/terraform && \

    # go testsum
    go get gotest.tools/gotestsum

# ibmcloud cli client
RUN set -ex && \
    curl -sL https://ibm.biz/idt-installer | bash && \
    ibmcloud plugin install vpc-infrastructure -f && \
    ibmcloud plugin install cloud-object-storage -f && \
    ibmcloud plugin install key-protect && \
    ibmcloud plugin install tke && \
    ibmcloud plugin update --all -f && \
    # docker-compose 1.25.5
    curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

RUN apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR ${WDIR}
