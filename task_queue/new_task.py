#!/usr/bin/env python
import pika
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()

channel.queue_declare(queue='task_queue', durable=True) #durable=True to keep queue persistent

#enqueue task
message = ' '.join(sys.argv[1:]) or "Hello World!"
channel.basic_publish(
  exchange='',
  routing_key='task_queue',
  body=message,
  properties=pika.BasicProperties(
    delivery_mode=2, #delivery_mode=2 to make message persistent
  )
)
print(" [x] Sent %r" % message)

connection.close()
