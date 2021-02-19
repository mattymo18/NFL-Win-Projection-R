FROM rocker/verse:latest
MAINTAINER Matt Johnson <Johnson.Matt1818@gmail.com>
RUN R -e "install.packages('caret')"
RUN R -e "install.packages('cluster')"
RUN R -e "install.packages('Rtsne')"
RUN R -e "install.packages('ggfortify')"
RUN R -e "install.packages('nflfastR')"
RUN R -e "install.packages('purrr')"
RUN R -e "install.packages('gganimate')"
RUN R -e "install.packages('gifski')"
RUN R -e "install.packages('png')"
