FROM ubuntu
MAINTAINER Muradu Iurie "muradu.iurie.1986@gmail.com"

RUN apt update && apt install -y vim iputils-ping openjdk-8-jdk wget ca-certificates zip net-tools tar netcat curl
RUN java -version

WORKDIR /root
RUN wget https://archive.apache.org/dist/kafka/0.10.2.1/kafka_2.12-0.10.2.1.tgz && \
tar -xvzf kafka_2.12-0.10.2.1.tgz && \
rm kafka_2.12-0.10.2.1.tgz && \
mv kafka_2.12-0.10.2.1 kafka

COPY zookeeper /etc/init.d/zookeeper
COPY deploy.sh /root
RUN chown root:root /etc/init.d/zookeeper
RUN update-rc.d zookeeper defaults
RUN echo "\nexport PATH=$PATH:/root/kafka/bin" >> /root/.bashrc
RUN mkdir -p kafka/data/zookeeper

EXPOSE 22 2181 2888 3888

WORKDIR /root/kafka
RUN rm config/zookeeper.properties
COPY zookeeper.properties config/zookeeper.properties
CMD /root/deploy.sh
