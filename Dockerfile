FROM ubuntu:16.04

# Install related packages.
RUN apt-get update && \
    apt-get install -y build-essential wget clang curl libedit-dev python2.7 python2.7-dev libicu-dev rsync libxml2 git libcurl3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG SNAPSHOT 
 
COPY $SNAPSHOT /
RUN tar -xvzf $SNAPSHOT --directory / --strip-components=1 && \
    rm -rf swift-DEVELOPMENT-SNAPSHOT*

# Set Swift Path
ENV PATH /usr/bin:$PATH

# Print Installed Swift Version
RUN swift --version
