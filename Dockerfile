FROM ubuntu:20.04

RUN apt update

ENV DEBIAN_FRONTEND "noninteractive"
ENV TZ "America/San Francisco"
ENV BASH_ENV "/root/.bash_env"
COPY .bash_env /root/.bash_env

SHELL ["/bin/bash", "-c"]

RUN apt install -y postgresql
ENV PGUSER postgres
ENV DATABASE_URL postgres://postgres@localhost:5432/postgres

RUN apt install -y curl
RUN mkdir /cache

RUN apt install -y python3.8 python3-distutils
RUN cd "$(dirname $(which python3.8))" \
    && ln -s python3.8 python
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
RUN poetry config virtualenvs.in-project false
RUN poetry config virtualenvs.path /cache

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt install -y nodejs 
RUN curl -o- -L https://yarnpkg.com/install.sh | bash 
RUN yarn config set cache-folder /cache