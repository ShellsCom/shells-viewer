FROM opensuse/leap:15.1

RUN zypper update -y && \
    zypper install -y \
           autoconf \
           automake \
           bash \
           bash-completion \
           ca-certificates \
           ccache \
           chrony \
           cppi \
           gcc \
           gdb \
           gettext \
           gettext-devel \
           git \
           glib2-devel \
           glibc-devel \
           glibc-locale \
           gtk-vnc2-devel \
           gtk3-devel \
           icoutils \
           libgovirt-devel \
           librest-devel \
           libtool \
           libvirt-devel \
           libvirt-glib-devel \
           libxml2 \
           libxml2-devel \
           lsof \
           make \
           net-tools \
           ninja \
           patch \
           perl \
           perl-App-cpanminus \
           pkgconfig \
           python3 \
           python3-pip \
           python3-setuptools \
           python3-wheel \
           rpm-build \
           screen \
           spice-gtk-devel \
           strace \
           sudo \
           vim \
           xz && \
    zypper clean --all && \
    mkdir -p /usr/libexec/ccache-wrappers && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/$(basename /usr/bin/gcc)

RUN pip3 install \
         meson==0.54.0

ENV LANG "en_US.UTF-8"

ENV MAKE "/usr/bin/make"
ENV NINJA "/usr/bin/ninja"
ENV PYTHON "/usr/bin/python3"

ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
