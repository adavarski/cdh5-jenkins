# CDH5 in Docker as Agent for Jenkins Pipeline

___
### What is this?  
Jenkins Pipeline used for CI/CD can use any Docker image for build environment. 

Here we have created a Dockerfile which will contain CDH5 environment blueprint

This is used to create a runtime CDH5 instance for unit testing of  hadoop scripts/code as part of build process in Jenkins.
___
### Who can use this?  
Anyone having Jenkins for CI/CD and are working on Hadoop projects.

_This may not work out if your DEV/PRO environment uses other Hadoop Distributions like MAPR or HORTONWORKS_
___
### How can I use this?  
All you need to do is  

1. Fork this repository  
2. Change the Jenkinsfile to point to your Repository.
3. Make sure the repo is public so that you dont have to save your credentials in Jenkinsfile.
4. Copy your source to scripts dir
5. Copy your sample data to data dir
6. In the Test stage in the Jenkinsfile provide all the hadoop commands that you would like to execute as part of testing
7. Fail the build on test step returning as failure
___
### What is under the hood?  

[**HDFS**](https://tinyurl.com/ydf89lqb) | [**YARN**](https://tinyurl.com/ydf89lqb) | [**MapReduce**](https://tinyurl.com/ydf89lqb) | [**HIVE**](https://hive.apache.org/) | [**SPARK**](https://spark.apache.org/)

___
### Can I extend it?   
Yes offcourse you can extend dockerfile to install additional components as per your requirements!  
_However make sure you change/add the additional configuration files in "conf" folder if you need to install additional components_

___
### What is it made up of?  
We have used the following versions of softwares, Tools and Frameworks while building it  

|Softwares | Version|   
|-----------|---------------|  
|CentOS | latest (7) (Base Image from Docker registry)|  
|Docker CE | 17.09.0-ce|  
|Jenkins | latest (2.91)|  
|CDH version | 5.13|  
___
### What version of Hadoop components installed?

|Component | Package Version|
|----------|----------------|
|Oracle JDK 1.7 | oracle-j2sdk1.7 |
|Apache Hadoop | hadoop-2.6.0+cdh5.13.0+2639|
|Apache Hive | hive-1.1.0+cdh5.13.0+1269|
|Apache Spark | spark-1.6.0+cdh5.13.0+530|
|Zookeeper | zookeeper-3.4.5+cdh5.13.0+118| 
___
### what Ports can i access from my laptop/desktop or workstation?

| Component | Ports exposed |
|-----------|---------------|
| NameNode (HDFS) | 8020, 50070 |
| DataNode (HDFS) | 50010, 50020, 50075 |
| ResourceManager (YARN) | 8030, 8031, 8032, 8033, 8088 |
| NodeManager (YARN) | 8040, 8042 |
| JobHistoryServer | 10020, 19888 |
| Hue | 8888 |
| Spark history server | 18080 |
| Hive Server ports | 9083, 10000 |
| Technical port which can be used for your custom purpose. | 9999 |
