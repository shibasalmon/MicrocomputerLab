FROM ubuntu

RUN apt update -y && apt upgrade -y
RUN apt install dosemu -y