# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# File to upload
$fileToUpload = "C:\Users\SahDude27\Desktop\hello.txt"

try {
    # Read the file content
    $fileContent = Get-Content -Path $fileToUpload -Raw

    # Create the boundary for the multipart form data
    $boundary = [System.Guid]::NewGuid().ToString()

    # Construct the multipart form data body
    $bodyLines = @"
--$boundary
Content-Disposition: form-data; name="file"; filename="file.txt"
Content-Type: text/plain

$fileContent
--$boundary--
"@

    # Convert the body to a byte array
    $bodyBytes = [System.Text.Encoding]::ASCII.GetBytes($bodyLines)

    # Construct the web request
    $webRequest = [System.Net.HttpWebRequest]::Create($webhookUrl)
    $webRequest.Method = "POST"
    $webRequest.ContentType = "multipart/form-data; boundary=$boundary"
    $webRequest.ContentLength = $bodyBytes.Length

    # Write the body to the request stream
    $requestStream = $webRequest.GetRequestStream()
    $requestStream.Write($bodyBytes, 0, $bodyBytes.Length)
    $requestStream.Close()

    # Get the response
    $response = $webRequest.GetResponse()
    $responseStream = $response.GetResponseStream()
    $responseReader = New-Object System.IO.StreamReader($responseStream)
    $responseContent = $responseReader.ReadToEnd()

    # Debugging output
    Write-Output "Response content: $responseContent"

    # Clean up
    $responseReader.Close()
    $responseStream.Close()
    $response.Close()
} catch {
    # Catch and display any errors
    Write-Output "Error sending multipart content: $_"
}
