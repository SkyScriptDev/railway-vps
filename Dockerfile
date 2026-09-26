FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-server \
        sudo \
        vim \
        net-tools \
        curl \
        wget \
        git \
        tzdata \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd

COPY entrypoint.sh /entrypoint.sh

# تبدیل CRLF ویندوز به LF لینوکس + اجرای فایل
RUN sed -i 's/\r$//' /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
