#!/bin/bash

LOG_FILE="/var/log/google-cloud-ops-agent/myapp.log"
CONFIG_FILE="/etc/google-cloud-ops-agent/config.yaml"
BACKUP_FILE="${CONFIG_FILE}.bak"

# Ensure log file exists and set permissions
sudo touch "$LOG_FILE" && sudo chown csye6225:csye6225 "$LOG_FILE" && sudo chmod 640 "$LOG_FILE"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file does not exist: $CONFIG_FILE"
    exit 1
fi

# Backup the original config file
sudo cp "$CONFIG_FILE" "$BACKUP_FILE" || { echo "Failed to create a backup of the original config file"; exit 1; }
echo "Created a backup of the original config file: $BACKUP_FILE"

# New configuration
read -r -d '' NEW_CONFIG <<'EOF'
logging:
  receivers:
    my-app-receiver:
      type: files
      include_paths:
        - /var/log/google-cloud-ops-agent/myapp.log
      record_log_file_path: true
  processors:
    my-app-processor:
      type: parse_json
      time_key: time
      time_format: "%Y-%m-%dT%H:%M:%S.%L%Z"
    change_severity:
      type: modify_fields
      fields:
        severity:
          copy_from: jsonPayload.severity
  service:
    pipelines:
      default_pipeline:
        receivers: [my-app-receiver]
        processors: [my-app-processor, change_severity]
EOF

# Update the configuration file
echo "$NEW_CONFIG" | sudo tee "$CONFIG_FILE" >/dev/null
echo "Updated the configuration file: $CONFIG_FILE"

# Restart Cloud Ops Agent
if sudo systemctl restart google-cloud-ops-agent; then
    echo "Cloud Ops Agent restarted successfully."
else
    echo "Failed to restart Cloud Ops Agent."
    exit 1
fi