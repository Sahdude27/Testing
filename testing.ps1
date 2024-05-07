# Define the file path and Discord webhook URL
$fileToUpload = "C:\Users\SahDude27\Desktop\Hello.txt"
$discordWebhook = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# Upload function for Discord
function Upload-DiscordFile {
    param (
        [string]$FilePath,
        [string]$WebhookURL
    )

    $hookURL = $WebhookURL
    $fileContent = Get-Content -Path $FilePath -Raw

    $Body = @{
        'content' = 'File upload'
        'file' = @{
            'value' = $fileContent
            'options' = @{
                'filename' = (Split-Path -Leaf $FilePath)
                'contentType' = 'text/plain'
            }
        }
    }

    Invoke-RestMethod -ContentType 'multipart/form-data' -Uri $hookURL -Method Post -Body $Body
}

# Call the upload function with the specified file and Discord webhook URL
Upload-DiscordFile -FilePath $fileToUpload -WebhookURL $discordWebhook
