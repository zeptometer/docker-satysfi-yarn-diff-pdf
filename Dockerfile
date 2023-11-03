FROM amutake/satysfi:0.0.10
LABEL maintainer="yuito@acupof.coffee"

# Install Node 14
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs

# Install Yarn
RUN apt-get install -y gnupg2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Install diff-pdf
RUN apt-get install -y make automake g++ libpoppler-glib-dev poppler-utils libwxgtk3.0-dev
WORKDIR /tmp
RUN wget https://github.com/vslavik/diff-pdf/archive/v0.4.1.tar.gz
RUN tar xf v0.4.1.tar.gz
RUN cd diff-pdf-0.4.1 \
    && ./bootstrap \
    && ./configure \
    && make \
    && make install
RUN rm -rf /tmp/*
WORKDIR /satysfi
