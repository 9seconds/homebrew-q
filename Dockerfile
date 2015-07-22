# This is a docker file to test if Brew works.

FROM sjackman/linuxbrew
MAINTAINER 9seconds <nineseconds@yandex.ru>

# Make sure everything is up to date.
RUN brew update && brew upgrade

# Hack for setuptools (dependency of... cmake?!)
# RUN brew install python

# CMake will be installed anyway so it is better to cache it (it takes a while)
# And Rust compiles infinity minutes.
# RUN brew install cmake rust

# Install rust to prevent long compilation time
ENV DEBIAN_FRONTEND noninteractive
RUN sudo apt-get install -y software-properties-common && \
    sudo apt-add-repository ppa:hansjorg/rust && \
    sudo apt-get update && \
    sudo apt-get install -y --force-yes rust-stable cargo-nightly

# Add repository as a tap and inject current directory.
RUN brew tap 9seconds/homebrew-q && \
    rm -rf /home/linuxbrew/.linuxbrew/Library/Taps/9seconds/homebrew-q
    ADD . /home/linuxbrew/.linuxbrew/Library/Taps/9seconds/homebrew-q

# Do all possible installations.
RUN brew install -vd --HEAD 9seconds/q/q
