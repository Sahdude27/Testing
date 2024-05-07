# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# JSON payload to send to the webhook
$jsonPayload = @{
    content = "Hello"
} | ConvertTo-Json

# Send the payload to the webhook URL
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $jsonPayload
