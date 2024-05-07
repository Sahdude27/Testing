# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# File to upload
$fileToUpload = "C:\Users\SahDude27\Desktop\testingtetsing.txt"

# Read the file content
$fileContent = Get-Content -Path $fileToUpload -Raw

# JSON payload to send to the webhook
$jsonPayload = @{
    payload_json = @{
        content = "Message with an uploaded file"
        file = @{
            value = $fileContent
            filename = "testingtetsing.txt"
            content_type = "text/plain"
        }
    } | ConvertTo-Json -Depth 10
}

# Send the payload to the webhook URL
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "multipart/form-data" -Body $jsonPayload
