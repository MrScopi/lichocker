ARG OPENJDK_TAG=18.0.2-jdk-buster
FROM openjdk:${OPENJDK_TAG}

ARG SBT_VERSION=1.8.1

# Install SBT
RUN apt-get update && \
    apt-get install sudo apt-transport-https curl gnupg -yqq && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" \
    | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import && \
    chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg && \
    apt-get update && \
    apt-get install sbt && \
    sbt sbtVersion -Dsbt.rootdir=true

# Install pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | bash - && \
    source /root/.bashrc

ENV LANG "en_US.UTF-8"
ENV LC_CTYPE "en_US.UTF-8"
ENV TZ=Etc/GMT

WORKDIR /home/lichess

ADD run.sh .
