FROM ubuntu:14.04

# Install related packages and set clang 3.6 as the compiler.
RUN apt-get update && \
    apt-get install -y build-essential wget clang-3.6 curl libedit-dev python2.7 python2.7-dev libicu52 rsync libxml2 git && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Swift keys
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

ENV SWIFT_BRANCH development
ARG SWIFT_VERSION
ENV SWIFT_PLATFORM ubuntu14.04

# FIXME: Should change this to get URL from build script.

RUN SWIFT_ARCHIVE_NAME=$SWIFT_VERSION-$SWIFT_PLATFORM && \
    SWIFT_URL=https://swift.org/builds/$SWIFT_BRANCH/$(echo "$SWIFT_PLATFORM" | tr -d .)/$SWIFT_VERSION/$SWIFT_ARCHIVE_NAME.tar.gz && \
    wget $SWIFT_URL && \
    wget $SWIFT_URL.sig && \
    gpg --verify $SWIFT_ARCHIVE_NAME.tar.gz.sig && \
    tar -xvzf $SWIFT_ARCHIVE_NAME.tar.gz --directory / --strip-components=1 && \
    rm -rf $SWIFT_ARCHIVE_NAME* /tmp/* /var/tmp/*

# Set Swift Path
ENV PATH /usr/bin:$PATH

# Print Installed Swift Version
RUN swift --version
