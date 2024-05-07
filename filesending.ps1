# Define the Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# Path to the text file you want to send
$filePath = "C:\Users\SahDude27\Desktop\Hello.txt"

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
