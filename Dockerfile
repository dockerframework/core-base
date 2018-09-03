ARG UBUNTU_VERSION=16.04
FROM ubuntu:${UBUNTU_VERSION}

# ================================================================================================
#  Inspiration: Docker Framework (https://github.com/zeroc0d3/docker-framework)
#               Dwi Fahni Denni <zeroc0d3.0912@gmail.com>
# ================================================================================================
#  Core Contributors:
#   - Mahmoud Zalt @mahmoudz
#   - Bo-Yi Wu @appleboy
#   - Philippe Trépanier @philtrep
#   - Mike Erickson @mikeerickson
#   - Dwi Fahni Denni @zeroc0d3
#   - Thor Erik @thorerik
#   - Winfried van Loon @winfried-van-loon
#   - TJ Miller @sixlive
#   - Yu-Lung Shao (Allen) @bestlong
#   - Milan Urukalo @urukalo
#   - Vince Chu @vwchu
#   - Huadong Zuo @zuohuadong
# ================================================================================================

MAINTAINER "Laradock Team <mahmoud@zalt.me>"

ENV S6_OVERLAY=v1.21.4.0 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=1 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    TERM=xterm

RUN apt-get update -y

#-----------------------------------------------------------------------------
# Install Core Packages
#-----------------------------------------------------------------------------
RUN apt-get install -y util-linux \
            bsdutils \
            bash \
            bash-completion \
            initscripts \
            locales

RUN locale-gen en_US.UTF-8

#-----------------------------------------------------------------------------
# Update & Install Base Dependency
#-----------------------------------------------------------------------------
RUN apt-get install -y iproute \
            htop \
            curl \
            wget \
            tar \
            sudo \
            nano \
            zip \
            unzip \
            screen \
            lsof \
            tcpdump \
            iptraf

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY}/s6-overlay-amd64.tar.gz /tmp/
RUN tar zxvf /tmp/s6-overlay-amd64.tar.gz -C /
RUN rm -f /tmp/s6-overlay-amd64.tar.gz

#-----------------------------------------------------------------------------
# Clean Up All Cache
#-----------------------------------------------------------------------------
RUN apt-get clean all

#-----------------------------------------------------------------------------
# Finalize (reconfigure)
#-----------------------------------------------------------------------------
COPY rootfs/ /

#-----------------------------------------------------------------------------
# Expose Port
#-----------------------------------------------------------------------------
EXPOSE 22
