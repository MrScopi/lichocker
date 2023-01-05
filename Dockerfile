FROM ubuntu:jammy

# Update packages and add new ones
RUN apt-get update && \
    apt-get install sudo apt-transport-https curl gnupg -yqq

# Grab Java and SBT
FROM sbtscala/scala-sbt:eclipse-temurin-19.0.1_10_1.8.2_2.13.10

# Grab pnpm
FROM octoblu/pnpm

# Set final env vars
ENV LANG "en_US.UTF-8"
ENV LC_CTYPE "en_US.UTF-8"
ENV TZ=Etc/GMT

# Copy in startup info
WORKDIR /home/lichess
ADD run.sh .