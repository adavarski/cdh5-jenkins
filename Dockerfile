# use cloudera quick start as the starting point
FROM centos:latest
## set env variables
## update yum repo and install wget utility
## this is not required if you are using docker-compose
## if you are running docker build within HPE you need to uncomment this line

RUN yum update --assumeyes
RUN yum install --assumeyes wget 

## install cdh repos
RUN wget https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo -O /etc/yum.repos.d/cloudera-cdh5.repo
RUN wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-manager.repo

RUN rpm --import https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera

# installing hadoop components
RUN  yum install --assumeyes \
		oracle-j2sdk1.7 \
		zookeeper-server \
		hadoop-hdfs-namenode \
		hadoop-yarn-resourcemanager \
		hadoop-hdfs-secondarynamenode \
		hadoop-yarn-nodemanager \
		hadoop-hdfs-datanode \
		hadoop-mapreduce \
		hadoop-mapreduce-historyserver \
		hadoop-yarn-proxyserver \
		hadoop-client \
		ntp \
		python2.7 \
		spark-core \
		spark-history-server \
		hive \
		hive-metastore \
		hive-server2 \
		spark-python


## add volumes
RUN mkdir /data /scripts
VOLUME ["/data","/scripts"]
## copy hadoop configurations
COPY conf/*.xml conf/hadoop-env.sh conf/spark-defaults.conf /etc/hadoop/conf/

## start script with execute permissions 
COPY startcdh /usr/bin/startcdh
RUN chmod 755 /usr/bin/startcdh
RUN cat /usr/bin/startcdh > /etc/rc.local
## create all the required directories for hadoop name nodes
RUN mkdir -p \
		/var/lib/hadoop-hdfs/cache/hdfs/dfs/name \
		/var/lib/hadoop-hdfs/cache/hdfs/dfs/namesecondary \
		/var/lib/hadoop-hdfs/cache/hdfs/dfs/data \
		/var/lib/hadoop-mapreduce/cache/mapred/tasks \
		/var/lib/hadoop-yarn/cache/yarn/nm-local-dir \
		/var/log/hadoop-yarn/containers \
		/var/log/hadoop-yarn/apps
		
RUN chown -R hdfs:hadoop \
		/var/lib/hadoop-hdfs/cache/hdfs/dfs/name \
		/var/lib/hadoop-hdfs/cache/hdfs/dfs/namesecondary \
		/var/lib/hadoop-hdfs/cache/hdfs/dfs/data
		
RUN chown -R yarn:hadoop \
		/var/lib/hadoop-yarn/cache/yarn/nm-local-dir \
		/var/log/hadoop-yarn/containers \
		/var/log/hadoop-yarn/apps

RUN chown -R mapred:hadoop \
		/var/lib/hadoop-mapreduce/cache/mapred/tasks 

##expose ports 
EXPOSE 8020 50070 50010 50020 50075 8030 8031 8032 8033 8088 8040 8042 10020 19888 8888 18080 9083 10000 9999

## formatting name node dir
RUN su - hdfs -c "hdfs namenode -format"	

## initializing zoo-keeper
RUN service zookeeper-server init --myid=1

# Run /bin/bash when the container launches
CMD ["/bin/bash"]
