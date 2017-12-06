#!/usr/bin/env python
import pika
import time

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True) #durable=True to keep queue persistent


def callback(ch, method, properties, body):
  #process each dot '.' in 1 second i.e. emulate a loong task
  print(" [x] Received %r" % body)
  time.sleep(body.count(b'.'))
  print(" [x] Done")

  #send an ack to acknowledge rabbitmq server that the task/message is done i.e. it can be deleted/no re-queue for it
  ch.basic_ack(delivery_tag=method.delivery_tag)


channel.basic_qos(prefetch_count=1) #a worker only get new task only after it finishes its current one
channel.basic_consume(callback, queue='task_queue')

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
