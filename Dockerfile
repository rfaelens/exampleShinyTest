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

## BUGFIX: Manually update devtools
## Due to issue r-lib/devtools#2129
## Can be removed once devtools CRAN version is updated
RUN R -e 'if( packageVersion("devtools") != "2.2.1") stop("Devtools package version: ", packageVersion("devtools"), "; bugfix in Dockerfile not needed anymore, please remove!")'
RUN R -e 'remotes::install_github("r-lib/devtools")'
