#!/bin/bash
  # Capture system information
  CPU_INFO=$(lscpu)
  MEMORY_INFO=$(free -h)
  DATE_INFO=$(date)
  DISK_INFO=$(df -h)

  # Create an HTML file with captured information
  cat <<EOF > /usr/share/nginx/html/index.html
  <!DOCTYPE html>
  <html>
  <head>
      <title>System Information</title>
  </head>
  <body>
      <h3>System Information</h3>
      <pre>
      CPU Information:
      $CPU_INFO

      Memory Information:
      $MEMORY_INFO

      Date and Time:
      $DATE_INFO

      Disk Space:
      $DISK_INFO
      </pre>
  </body>
  </html>
  EOF
