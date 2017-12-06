#!/usr/bin/env bash

: #ref. https://github.com/rabbitmq/rabbitmq-tutorials/tree/master/java#code

s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s" #get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path

#download dependencies keep remote filename ref. https://stackoverflow.com/a/7451779/248616
#TODO how to register these deps using maven?
cd "$SCRIPT_HOME"
    curl -O http://central.maven.org/maven2/com/rabbitmq/amqp-client/4.0.2/amqp-client-4.0.2.jar
    curl -O http://central.maven.org/maven2/org/slf4j/slf4j-simple/1.7.22/slf4j-simple-1.7.22.jar
    curl -O http://central.maven.org/maven2/org/slf4j/slf4j-api/1.7.21/slf4j-api-1.7.21.jar
cd --

#compile code
cp='amqp-client-4.0.2.jar' && javac -cp "$cp" NewTask.java Worker.java

#run consumer aka. start a worker
cp='.:amqp-client-4.0.2.jar:slf4j-api-1.7.21.jar:slf4j-simple-1.7.22.jar' && java -cp "$cp" Worker

#run sender aka. add new task
cp='.:amqp-client-4.0.2.jar:slf4j-api-1.7.21.jar:slf4j-simple-1.7.22.jar'
java -cp "$cp" NewTask
java -cp "$cp" NewTask 'Task 00'
java -cp "$cp" NewTask 'Task 01 .'
java -cp "$cp" NewTask 'Task 02 ..'
java -cp "$cp" NewTask 'Task 03 ...'
java -cp "$cp" NewTask 'Task 04 ....'
