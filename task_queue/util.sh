#!/usr/bin/env bash

: #run task_queue demo

#00 start a worker
python worker.py

#01 send new task
python new_task.py
python new_task.py 'Task 01 .'
python new_task.py 'Task 02 ..'
python new_task.py 'Task 03 ...'
python new_task.py 'Task 04 ....'
