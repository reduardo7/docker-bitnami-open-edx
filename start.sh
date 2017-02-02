/opt/bitnami/ctlscript.sh restart

sleep_forever() {
  echo "Running..."
  sleep 60
  sleep_forever
}

sleep_forever