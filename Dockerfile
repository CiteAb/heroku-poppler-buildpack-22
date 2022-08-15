FROM heroku/heroku:20

ARG version=22.08.0

RUN apt-get -y update && apt-get -y install build-essential cmake checkinstall libfreetype6-dev libfontconfig1-dev libjpeg-dev libtiff-dev libopenjp2-7-dev libcairo2-dev libboost-system-dev
RUN wget https://poppler.freedesktop.org/poppler-${version}.tar.xz && tar -xvf poppler-${version}.tar.xz
RUN cd poppler-${version} && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=release -DBUILD_GTK_TESTS=OFF -DBUILD_QT5_TESTS=OFF -DBUILD_CPP_TESTS=OFF -DENABLE_QT5=OFF -DENABLE_LIBOPENJPEG=openjpeg2 && make -j2
RUN cd poppler-${version}/build && checkinstall -y --install=no --backup=no --fstrans=yes --pkgname=poppler --pkgversion=${version}
