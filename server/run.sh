#!/bin/bash

rm -f tmp/pids/server.pid 
bundle install

rails db:create
rails db:migrate
rails db:fixtures:load

if [ ! -z "$TEACHER_EMAIL" ] && [ ! -z "$TEACHER_PASSWORD" ] && [ ! -z "$TEACHER_NAME" ] && [ ! -z "$TEACHER_LAST_NAME" ]
then
    rails teachers:create[$TEACHER_EMAIL,$TEACHER_PASSWORD,$TEACHER_NAME,$TEACHER_LAST_NAME] admin=true
fi

if [ ! -z "$PORT" ]
then
    rails s -b '0.0.0.0' -p $PORT
else
    rails s -b '0.0.0.0'
fi