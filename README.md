# Shell-scripts
# Resource Monitor Script

## Overview
The `resource_monitor.sh` script monitors system resources such as CPU usage, memory usage, and disk usage. It logs the usage data every 5 minutes and sends email alerts if any thresholds are exceeded:

- **CPU Usage:** Sends an alert if CPU usage exceeds 80%.
- **Disk Usage:** Sends an alert if available disk space falls below 20%.

The resource usage data is logged in a file named `resource_usage.log`.

## Features
- Logs CPU, memory, and disk usage every 5 minutes.
- Sends email alerts when resource thresholds are breached.
- Easy to configure for custom thresholds and email notifications.

## Usage
### 1. Clone the Repository:
```bash
git clone <your-repo-url>
```

### 2. Modify the Script:
- Set your email address in the script by modifying the line:
  ```bash
  EMAIL="your_email@example.com"
  ```
- Adjust the CPU and Disk thresholds if needed:
  ```bash
  CPU_THRESHOLD=80
  DISK_THRESHOLD=20
  ```

### 3. Run the Script:
Make the script executable and run it in the background:
```bash
chmod +x resource_monitor.sh
./resource_monitor.sh &
```

### 4. Stop the Script:
To stop the script, find its process ID and terminate it:
```bash
ps aux | grep resource_monitor.sh
kill <process-id>
```

## Log File
The resource usage data is logged in `resource_usage.log`, which contains entries like:
```
Thu Oct 06 11:23:45 IST 2024: CPU: 45.32%, Memory: 63.24%, Disk: 72%
Thu Oct 06 11:28:45 IST 2024: CPU: 56.78%, Memory: 67.89%, Disk: 75%
```

## Email Alerts
You will receive email alerts if:
- CPU usage exceeds 80%.
- Disk usage exceeds 80% (i.e., available space falls below 20%).

Ensure that **Postfix** or any other mail service is configured on your system to send emails.
