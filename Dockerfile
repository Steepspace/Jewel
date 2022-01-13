FROM gcc:11

# basic updates before set up
RUN apt-get update -y && apt-get upgrade -y

# configures python env
RUN apt install python2.7 -y \
    && ln -fs /usr/bin/python2.7 /usr/bin/python

# configures lhapdf
RUN cd /opt \
    && wget https://lhapdf.hepforge.org/downloads?f=old/lhapdf-5.9.1.tar.gz \
    && tar -xvzf 'downloads?f=old%2Flhapdf-5.9.1.tar.gz' \
    && rm 'downloads?f=old%2Flhapdf-5.9.1.tar.gz' \
    && cd /opt/lhapdf-5.9.1 \
    && sed -i 's/-ffree-form /-ffree-form -std=legacy/g' configure.ac \
    && ./configure && make && make install

# configures jewel
RUN cd /opt \
    && wget https://jewel.hepforge.org/downloads/?f=jewel-2.2.0.tar.gz \
    && tar -xvzf 'index.html?f=jewel-2.2.0.tar.gz' \
    && rm 'index.html?f=jewel-2.2.0.tar.gz' \
    && cd /opt/jewel-2.2.0 \
    && sed -i 's/\/home\/lhapdf\/install\/lib\//\/opt\/lhapdf-5.9.1\/lib/g' Makefile \
    && make && mkdir -p /usr/local/share/lhapdf/PDFsets

# configures paths for jewel to run
ENV LD_LIBRARY_PATH="/opt/lhapdf-5.9.1/lib/.libs:${LD_LIBRARY_PATH}"
ENV PATH="/opt/jewel-2.2.0:${PATH}"
ENV LHAPATH=/usr/local/share/lhapdf/PDFsets
