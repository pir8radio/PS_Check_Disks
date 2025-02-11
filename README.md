# PS_Check_Disks
A powershell script that checks all physical drives to make sure they are healthy and "ok", if not send a webhook to instatus.com.
Great way to monitor windows storage spaces/pools for a drive failure. Has a temp file that saves the last state so when you run this
script using task scheduler it wont keep sending the same webhook, it will only send when the status changes. 

You can edit the payload and webhook url to post to Discord or whatever if you don't use instatus.com status page.
