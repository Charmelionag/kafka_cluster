FROM ubuntu
MAINTAINER Muradu Iurie "muradu.iurie.1986@gmail.com"

RUN apt update && apt install -y vim iputils-ping openjdk-8-jdk wget ca-certificates zip net-tools tar netcat curl
RUN java -version

# copy kafka binaries
WORKDIR /root
RUN wget https://archive.apache.org/dist/kafka/0.10.2.1/kafka_2.12-0.10.2.1.tgz && \
tar -xvzf kafka_2.12-0.10.2.1.tgz && \
rm kafka_2.12-0.10.2.1.tgz && \
mv kafka_2.12-0.10.2.1 kafka

# set services
COPY zookeeper /etc/init.d/zookeeper
COPY kafka /etc/init.d/kafka
RUN chown root:root /etc/init.d/zookeeper
RUN chown root:root /etc/init.d/kafka
RUN update-rc.d zookeeper defaults
RUN update-rc.d kafka defaults

# deploy starting script
COPY deploy.sh /root


RUN echo "\nexport PATH=$PATH:/root/kafka/bin" >> /root/.bashrc
RUN echo "* hard nofile 100000\n* soft nofile 100000" | tee --append /etc/security/limits.conf

RUN mkdir -p kafka/data/zookeeper && mkdir kafka/data/kafka

EXPOSE 22 2181 2888 3888 9092

WORKDIR /root/kafka
RUN rm config/zookeeper.properties
COPY zookeeper.properties config/zookeeper.properties
RUN rm config/server.properties
COPY server.properties config/server.properties
CMD /root/deploy.sh
