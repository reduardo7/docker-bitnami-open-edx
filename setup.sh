apt-get update
apt-get install -y mysql-server curl
chmod a+x bitnami-edx-20160414-5-linux-x64-installer.run
echo "y\ny\n\nEduardo Cuomo\neduardo.cuomo@patagonian.it\necuomo\n123456\n123456\nn\n\ny\n" | ./bitnami-edx-20160414-5-linux-x64-installer.run
echo "http://172.17.0.3:8085"
