# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# File to upload
$fileToUpload = "C:\path\to\your\file.txt"

# Read the file content
$fileContent = Get-Content -Path $fileToUpload -Raw

# Debugging output
Write-Output "File content read successfully."
Write-Output "File content length: $($fileContent.Length) bytes."

# JSON payload to send to the webhook
$jsonPayload = @{
    payload_json = @{
        content = "Message with an uploaded file"
        file = @{
            value = $fileContent
            filename = "file.txt"
            content_type = "text/plain"
        }
    } | ConvertTo-Json -Depth 10
}

# Debugging output
Write-Output "JSON payload constructed successfully."

# Send the payload to the webhook URL
Write-Output "Sending payload to webhook..."
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "multipart/form-data" -Body $jsonPayload

# Debugging output
Write-Output "Payload sent successfully."
