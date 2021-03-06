#!/bin/bash
app_name="webserver-htdoc-1.0"
app_path=/root/ccbin/build/htdoc/target/$app_name

tomcat_home=/usr/local/tomcat7

tomcat_webapps=$tomcat_home/webapps/ROOT
tomcat_logger=$tomcat_home/logs
tomcat_work=$tomcat_home/work
startup=$tomcat_home/bin/startup.sh
app_logger=/root/logs
date_name=`date '+%Y%m%d%H%M%S'`

java_id=$(ps -ef |grep java |grep -w 'java'|grep -v 'grep'|awk '{print $2}')

if [[ "$java_id" = "" ]]
then
        echo "java process not exists"
else
        echo "shutdown processing..."
        kill -9 $java_id
        sleep 3
        echo "pid[$java_id]shutdown complete"
        sleep 1
fi
zip -r $date_name.log.zip $app_logger
rm -rf $tomcat_webapps/*
echo "clear tomcat webapps successful!"
sleep 1
rm -rf $tomcat_logger/*
echo "clear tomcat logger successful!"
sleep 1
rm -rf $tomcat_work/*
echo "clear tomcat cache successful!"
sleep 1
rm -rf $app_logger/*
echo "clear app logger successful!"
sleep 1
cp -r $app_path/* $tomcat_webapps
$startup
echo "start tomcat ..."
sleep 5
tail -1000f $tomcat_logger/catalina.out
