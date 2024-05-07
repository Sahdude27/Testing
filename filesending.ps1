# Define the Discord webhook URL
$webhookUrl = "YOUR_DISCORD_WEBHOOK_URL_HERE"

# Path to the text file you want to send
$filePath = "C:\path\to\your\text_file.txt"

# Read the content of the text file
$fileContent = Get-Content -Path $filePath -Raw

# Create the payload for the webhook
$payload = @{
    content = $fileContent
}

# Convert the payload to JSON format
$jsonPayload = $payload | ConvertTo-Json

# Send the payload to the Discord webhook
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $jsonPayload
