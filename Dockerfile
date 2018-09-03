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

ENV S6OVERLAY_VERSION=v1.21.4.0 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=1 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    TERM=xterm

RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y zip unzip curl build-essential bash-completion nano zsh mc

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY}/s6-overlay-amd64.tar.gz /tmp/
RUN tar zxvf /tmp/s6-overlay-amd64.tar.gz -C /
RUN rm -f /tmp/s6-overlay-amd64.tar.gz

RUN apt-get clean

COPY rootfs /

ENTRYPOINT ["/init"]
CMD ["bash"]