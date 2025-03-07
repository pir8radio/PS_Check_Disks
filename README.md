# PS_Check_Disks

## Overview

This PowerShell script checks all physical drives to ensure they are healthy and "OK." If a drive's status is not healthy, the script sends a webhook to [InStatus.com](https://instatus.com). It's an excellent way to monitor Windows Storage Spaces/Pools for potential drive failures.

The script uses a temporary file to save the last state, ensuring it only sends a webhook when the status changes. This prevents repeated notifications when running the script via Task Scheduler.

## Features

- Verifies the health of all connected physical drives.
- Sends a webhook to InStatus.com if a drive's status changes.
- Prevents duplicate webhooks by tracking the last-known state.
- Fully customizable webhook payload and URL for integration with other services like Discord.

## Usage Instructions

1. **Download** the PowerShell script.
2. Configure the script to:
   - Specify the desired webhook URL and payload (optional).
3. Run the script manually or schedule it using **Task Scheduler** to automate drive health checks.
4. Receive notifications for any changes in drive health.

## Customization

- Modify the webhook URL and payload to post alerts to other platforms like Discord.
- Adjust the script's configuration to fit your specific monitoring needs.

This script is a simple yet powerful tool for proactive drive monitoring. Happy scripting!
