# Use the Rocker R images
FROM rocker/tidyverse:latest

WORKDIR /app/exampleShinyTest

## Install phantomjs / shinytest
RUN apt-get update && apt-get install -y lbzip2
RUN R -e 'devtools::install_version("shinytest")'
RUN R -e 'shinytest::installDependencies()'
ENV OPENSSL_CONF /etc/ssl/

## Install package dependencies from DESCRIPTION
COPY DESCRIPTION .
RUN R -e 'devtools::install_deps()'
RUN R -e 'devtools::install_dev_deps()'

## Install full package
COPY . .
RUN R -e 'devtools::install(dependencies=TRUE)'
