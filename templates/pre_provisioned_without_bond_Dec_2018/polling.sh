source ~/stackrc
export OVERCLOUD_ROLES="ControllerDeployedServer ComputeDeployedServer"
export ControllerDeployedServer_hosts="192.168.24.2"
export ComputeDeployedServer_hosts="192.168.24.3"
/usr/share/openstack-tripleo-heat-templates/deployed-server/scripts/get-occ-config.sh
