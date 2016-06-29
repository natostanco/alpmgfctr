FROM alpine:edge

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
 && apk update \
 && apk upgrade \
 && apk add alpine-sdk crypto++-dev db-dev curl-dev readline-dev fuse-dev \
 && wget http://downloads.sourceforge.net/freeimage/FreeImage3170.zip \
 && unzip FreeImage3170.zip \
 && cd FreeImage \
 && echo '' > Source/LibWebP/./src/dsp/dsp.upsampling_mips_dsp_r2.c \
 && echo '' > Source/LibWebP/./src/dsp/dsp.yuv_mips_dsp_r2.c \
 && make -j 4 \
 && make install \
 && cd .. \
 && git clone https://github.com/matteoserva/MegaFuse \
 && cd MegaFuse \
 && make -j 4 \
 && mv ./MegaFuse /usr/local/bin \
 && apk del alpine-sdk crypto++-dev db-dev curl-dev readline-dev fuse-dev \
 && apk add crypto++ db db-c++ libcurl fuse \
 && cd .. \
 && rm -rf ./MegaFuse \
 && rm -rf FreeImage \
 && rm FreeImage3170.zip \
 && rm /var/cache/apk/*

CMD ["/usr/local/bin/MegaFuse"]
