# test locally for syntax error by running
# `docker build -t gridray:latest -f gridray.dockerfile .`

FROM python:3.8

# mandatory for Grid.ai
WORKDIR /gridai/project
COPY . .
# mandatory for Grid.  
# RUN pip install --ignore-requires-python -v -r requirements.txt