FROM python:3.9.6

# these two lines are mandatory
WORKDIR /gridai/project
COPY . .

# any RUN commands you'd like to run
# use this to install dependencies
RUN pip install pytorch-lightning && \
    apt install curl -y 

RUN pip install --ignore-requires-python -v -r requirements.txt