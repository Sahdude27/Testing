# Define the webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# Define the file path
$filePath = "C:\Users\SahDude27\Desktop\Hello.txt"

# Read the file content
$fileContent = Get-Content -Path $filePath -Raw

# Define the JSON payload
$json = @{
    content = "Here's the file you requested:"
    file = $fileContent
}

# Convert the JSON payload to JSON format
$jsonString = $json | ConvertTo-Json

# Send the HTTP POST request to the Discord webhook
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "multipart/form-data" -Body $jsonString
