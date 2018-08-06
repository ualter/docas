## Start cluster
```bash
# v1
$ docker-compose -f docker-compose-v1.yml up -d zookeeper
# v2
$ docker-compose -f docker-compose-v2.yml up -d zookeeper
```
## Add Kakfa broker
```bash
# v1
$ docker-compose -f docker-compose-v1.yml up -d kafka
# v2
$ docker-compose -f docker-compose-v2.yml up -d kafka-1 kafka-2 kafka-3
```
## Communicating with Kafka
```bash
# Check Status
# v1
kafkacat -L -b localhost
# v2
kafkacat -L -b localhost:9093,localhost:9094,localhost:9095

# Sample response
ualter@UjrMacBookAir:~/Developer/docas/kafka$ kafkacat -L -b localhost:9093,localhost:9094
Metadata for all topics (from broker -1: localhost:9093/bootstrap):
 2 brokers:
  broker 1001 at 10.253.163.97:9093
  broker 1002 at 10.253.163.97:9094
 2 topics:
  topic "TopicA" with 3 partitions:
    partition 0, leader 1002, replicas: 1002,1001, isrs: 1002,1001
    partition 1, leader 1001, replicas: 1001,1002, isrs: 1001,1002
    partition 2, leader 1002, replicas: 1002,1001, isrs: 1002,1001
  topic "TopicB" with 1 partitions:
    partition 0, leader 1001, replicas: 1001, isrs: 1001

# Produce Messages to a Topic
$ kafkacat -b localhost:9092 -P -t TopicA

# Consume Message from a Topic
$ kafkacat -b localhost:9092 -C -t TopicA
# Consume Specific Partition
kafkacat -b localhost:9092 -C -t TopicA -p 2
# Consume Specific Partition from a specific Offset 
kafkacat -b localhost:9092 -C -t TopicA -p 1 -o 2

```    

## Add Kakfa broker 2
```bash
# v1
$ docker-compose -f docker-compose-v2.yml up -d kafka-2
$ docker-compose scale kafka=3
```
## Add Kakfa broker (Work In Progress...)  not working yet!
```bash
$ docker-compose scale kafka=3
```

## Other
```bash
$ docker-compose stop
```

## Kafkacat (Tests)
https://github.com/edenhill/kafkacat

Install Linux and MacOs
```bash
apt-get install kafkacat
brew install kafkacat
```
Subscribe to topic1 and topic2
```bash
$ kafkacat -b mybroker -G mygroup topic1 topic2
```

Produce messages to the Topic streams-plaintext-input
```bash
$ kafkacat -b localhost:32770,localhost:32771 -P -t streams-plaintext-input
$ kafkacat -b localhost:9092 -P -t streams-plaintext-input
$ kafkacat -b localhost:9093,localhost:9094 -P -t streams-plaintext-input
```

Consume messages of Topic streams-plaintext-input
```bash
$ kafkacat -b localhost:32770,localhost:32771 -C -t streams-plaintext-input
$ kafkacat -b localhost:9092 -C -t streams-plaintext-input
$ kafkacat -b localhost:9093,localhost:9094 -C -t streams-plaintext-input
```

Read messages from Kafka 'syslog' topic, print to stdout
```bash
$ kafkacat -b mybroker -t syslog
```

Read the last 2000 messages from 'syslog' topic, then exit
```bash
$ kafkacat -C -b mybroker -t syslog -p 0 -o -2000 -e
```

# Bash

### Print Second Line, Second Column
```bash
$ docker ps | awk 'FNR == 2 {print $1}'
```

### Search a Kakfa Container and print the second column of info
```bash
$ docker ps | grep 9092 | awk '{print $2}'
```