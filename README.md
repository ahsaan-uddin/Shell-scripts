# Shell-scripts
# Resource Monitor Script

# System Monitoring Script

This Bash script monitors key system resources, including disk space, memory, and CPU usage, providing real-time data and logging it for future reference. It ensures that system administrators are promptly alerted when resource usage exceeds set thresholds, allowing them to take preventive action before system performance is affected.

### Features:

- **Disk Space Monitoring:**
The script checks the total disk usage. If it exceeds a specified threshold (e.g., 10%), an alert is generated.
- **Memory Usage Monitoring:**
It tracks available memory and sends a warning if memory falls below a certain threshold (e.g., 500 MiB).
- **CPU Usage Monitoring:**
The script monitors CPU load average and alerts if CPU usage is too high.
- **Logging:**
Every 5 minutes, the script logs the system resource usage to a file (`resource_usage.log`) for future reference using crontab
- **Email Alerts:**
If any resource usage crosses the set thresholds, an email alert is sent to the administrator. The email includes warnings for high CPU usage, low memory, or insufficient disk space.

### Technologies Used:

- **Linux & Bash:** The core of the script is written in Bash for Linux environments.
- **SMTP & Postfix:** The email alert functionality is set up using SMTP and Postfix.

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
