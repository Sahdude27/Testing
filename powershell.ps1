# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/your_webhook_id/your_webhook_token"

# JSON payload to send to the webhook
$jsonPayload = @{
    content = "Hello"
} | ConvertTo-Json

# Send the payload to the webhook URL
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $jsonPayload
