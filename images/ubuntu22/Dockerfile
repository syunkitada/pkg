FROM ubuntu:22.04

RUN apt update

# install build tools for basic
RUN apt install -y build-essential devscripts git wget \
    libssl-dev libxml2-dev libxslt-dev libffi-dev liberasurecode-dev

CMD ["bash", "-c", "sleep 3600;"]
