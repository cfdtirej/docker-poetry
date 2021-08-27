FROM python:3.8

RUN apt-get update

RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9

RUN apt-get install -y curl \
                   wget \
                   less \
                   vim \
                   git 

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - && \
    echo 'export PATH="$HOME/.poetry/bin:$PATH"' >> ~/.bashrc 
RUN /bin/bash -c 'source ~/.bashrc'

RUN pip install --upgrade pip && \
    pip install --upgrade setuptools
COPY requirements.txt .
RUN pip install -r requirements.txt

RUN mkdir -p /root/src/backend
WORKDIR /root/src/backend

EXPOSE 8000
