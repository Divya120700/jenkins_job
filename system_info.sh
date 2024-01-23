#!/bin/bash
CPU_INFO=$(lscpu)
MEMORY_INFO=$(df -h)
DATE_INFO=$(date)
DISK_INFO=$(df -h)

# Create an HTML file with captured information
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Information</title>
</head>
<body>
    <h1>System Information</h1>
    <pre id="system-info"></pre>
    <script>
        function fetchSystemInfo() {
            fetch('/system_info')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('system-info').innerText = JSON.stringify(data, null, 2);
                });
        }

        fetchSystemInfo();  // Initial fetch

        // Fetch system info on every button click (refresh)
        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('refresh-btn').addEventListener('click', fetchSystemInfo);
            
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
        });
    </script>
    <button id="refresh-btn">Refresh</button>
</body>
</html>
EOF

