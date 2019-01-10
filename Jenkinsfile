// Powered by Infostretch 


pipeline {
     agent { dockerfile true }
	

    stages {
    
   
       stage ('Checkout') {
	        checkout scm
	        }
		
		stage ('Build') {
		steps {
			sh 'cp -R data /'
			sh 'cp -R scripts /'
			sh 'chmod -R 755 /data'
			sh 'chmod -R 755 /scripts'
			sh 'su - hdfs -c "hadoop fs -mkdir -p /data/population/"'
			sh 'su - hdfs -c "hadoop fs -put /data/* /data/population/"'
			sh 'su - hdfs -c "hadoop fs -ls /data/population/"'
			}
		}
	stage( 'Test' ) {
			steps {
			echo 'Test Task....'
				sh 'ls /scripts'
				sh 'hive -f /scripts/population-yb-ddl.hql' 
				sh 'hive -f /scripts/population-yb-select.hql' 
				
			}
	}
	
	stage( 'Publish' ) {
			steps {
				sh 'tar -cvzf dap.$BUILD_NUMBER.tar.gz $WORKSPACE/scripts $WORKSPACE/data'
				archiveArtifacts artifacts: 'dap.$BUILD_NUMBER.tar.gz', fingerprint: true 
			}
	}
	
	stage( 'Deploy' ) {
			steps {				
				echo 'Deploy to DEV CLuster by calling your deployment scripts....'
			}
	}
		
	}
	
	
}
