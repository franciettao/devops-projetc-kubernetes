# grafana_configuration.sh
#!/bin/bash

# Set Grafana admin user and password
ADMIN_USER="admin"
ADMIN_PASS="password"

# Set Grafana data source
DATA_SOURCE="http://localhost:3000"

# Install Grafana
sudo apt-get update
sudo apt-get install -y adduser libfontconfig1
sudo docker run -d --name=grafana -p 3000:3000 grafana/grafana

# Wait for Grafana to start
until $(curl --output /dev/null --silent --head --fail $DATA_SOURCE); do
    printf '.'
    sleep 5
done

# Create admin user
echo -e "admin:$ADMIN_PASS\n$ADMIN_PASS" | sudo docker exec -i grafana /bin/bash -c "/usr/sbin/useradd -r -g nogroup grafana && echo 'admin:$ADMIN_PASS' | chpasswd"

# Configure data source
cat <<EOF | sudo docker exec -i grafana /bin/bash -c '/usr/bin/grafana-cli plugins install alertlist-datasource' && \
sudo docker exec -i grafana /bin/bash -c '/usr/bin/grafana-cli plugins enable alertlist-datasource' && \
sudo docker exec -i grafana /bin/bash -c "/usr/bin/grafana-cli datasources create --name=Alertlist --type=alertlist-datasource --access=proxy --url=http://localhost:9001 --database=mydb --secure-json-data='{\"apiKey\":\"myapikey\"}'"

# Print success message
echo "Grafana installed and configured with admin user $ADMIN_USER and data source $DATA_SOURCE"