if [ ! -d "$ARIANE_PROJECT_PATH/ariane.community.core.idm" ]; then
	echo "ARIANE_PROJECT_PATH ($ARIANE_PROJECT_PATH) is not defined correctly !"
	exit 1 
fi

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.core.idm/distrib/installer/resources/sqlscripts/components/idm.sql 

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.core.idm/distrib/installer/resources/sqlscripts/components/idm_security_insert.sql

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.core.portal/distrib/installer/resources/sqlscripts/components/idm_portal_insert.sql

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.core.mapping/distrib/installer/resources/sqlscripts/components/idm_mapping.sql

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.core.mapping/distrib/installer/resources/sqlscripts/components/idm_mapping_insert.sql 

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.core.directory/distrib/installer/resources/sqlscripts/components/idm_directory_insert.sql

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.core.injector/distrib/installer/resources/sqlscripts/components/idm_injector_insert.sql 

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.plugin.rabbitmq/distrib/installer/resources/sqlscripts/plugins/rabbitmq/idm_plugin_rabbitmq_insert.sql

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.plugin.procos/distrib/installer/resources/sqlscripts/plugins/procos/idm_plugin_procos_insert.sql 

mysql -u ariane --password=password -h 127.0.0.1 -P 3316 -D ariane_idm < $ARIANE_PROJECT_PATH/ariane.community.plugin.docker/distrib/installer/resources/sqlscripts/plugins/docker/idm_plugin_docker_insert.sql 

mysql -u ariane --password=password -h 127.0.0.1 -P 3326 -D ariane_directory < ./ariane_directory.sql
