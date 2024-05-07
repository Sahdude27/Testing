# Directory to search for the file
$searchDirectory = "C:\"

# File name to search for
$fileName = "hello.txt"

try {
    # Search for the file in the specified directory
    $fileToUpload = Get-ChildItem -Path $searchDirectory -Filter $fileName -Recurse | Select-Object -First 1

    if ($fileToUpload -eq $null) {
        throw "File '$fileName' not found in directory '$searchDirectory'."
    }

    # Read the file content
    $fileContent = Get-Content -Path $fileToUpload.FullName -Raw

    # Rest of your script remains unchanged...
    $boundary = [System.Guid]::NewGuid().ToString()
    # Construct the multipart form data body...
} catch {
    Write-Output "Error: $_"
}
