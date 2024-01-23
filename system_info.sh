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
        });
    </script>
    <button id="refresh-btn">Refresh</button>
    
    <pre>
    CPU Information:
    <span id="cpu-info-placeholder"></span>

    Memory Information:
    <span id="memory-info-placeholder"></span>

    Date and Time:
    <span id="date-info-placeholder"></span>

    Disk Space:
    <span id="disk-info-placeholder"></span>
    </pre>
<script>
    // Fetch system info on every button click (refresh)
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('refresh-btn').addEventListener('click', function () {
            // Trigger a request to the server to run the shell script and update data
            fetch('/refresh_data')
                .then(response => response.json())
                .then(data => {
                    // Update the HTML content with the new data
                    document.getElementById('cpu-info-placeholder').innerText = `\`${CPU_INFO}\``;
                    document.getElementById('memory-info-placeholder').innerText = `\`${MEMORY_INFO}\``;
                    document.getElementById('date-info-placeholder').innerText = `\`${DATE_INFO}\``;
                    document.getElementById('disk-info-placeholder').innerText = `\`${DISK_INFO}\``;
                });
        });
    });
</script>


</body>
</html>
EOF

