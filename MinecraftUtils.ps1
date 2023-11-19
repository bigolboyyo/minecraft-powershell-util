# Function to start Minecraft server
function Start-Mining {
    param (
        [string]$dir = "",
        [string]$arg = ""
    )

    if (-not $dir) {
        $dir = Read-Host "Enter the directory path where the server.jar is located."
    }

    $jarPath = Join-Path -Path $dir -ChildPath "server.jar"

    if (-not (Test-Path $jarPath)) {
        Write-Host "Error: server.jar not found in the specified directory."
        return
    }

    if ($arg -eq "nogui") {
        $command = "java -Xmx1024M -Xms1024M -jar `"$jarPath`" nogui"
    } else {
        $command = "java -Xmx1024M -Xms1024M -jar `"$jarPath`""
    }

    Invoke-Expression $command
}



# Allows you to set up a new server directory with an existing server.jar file
function Initialize-Server {
    [CmdletBinding()]
    param (
        [string]$Directory 
    )

    $Directory = Read-Host "Enter directory where server.jar is located"

    if (-not $Directory) {
        Write-Host "Please provide a directory path where the server.jar is located."
        return
    }

    if (-not (Test-Path $Directory -PathType Container)) {
        Write-Host "Directory does not exist. Please provide a valid path."
        return 
    }

    $newDirectoryName = Read-Host "Enter a name for the new server instance directory."

    $outputPathOfDirectory = Read-Host "Enter the location path to create the new server directory."

    $newDirectoryPath = Join-Path -Path $outputPathOfDirectory -ChildPath $newDirectoryName

    # Create the new directory
    New-Item -Path $newDirectoryPath -ItemType Directory -Force

    # Copy the server.jar to the new directory
    Copy-Item -Path "$Directory\server.jar" -Destination "$newDirectoryPath\server.jar" -Force

    # Copy utils to new server directory
    Copy-Item -Recurse -Path "$PSScriptRoot\MinecraftUtils.ps1" -Destination $newDirectoryPath -Force

    Write-Host "Server setup completed. New directory: $newDirectoryPath"
}

function Register-Properties {
    Write-Host "Hello World!"
}

# Function to start ngrok tunnel
function Start-Ngrok {
    param (
        [string]$ngrokDirectory = (Read-Host "Enter the directory where your ngrok.exe is located"),
        [int]$port = 25565
    )

    $ngrokPath = Join-Path -Path $ngrokDirectory -ChildPath "ngrok.exe"

    $portInput = Read-Host "Enter a new port number or leave blank for default (25565)"
    if ($portInput -ne "") {
        $port = [int]$portInput
    }

    $ngrokProcess = Start-Process -FilePath $ngrokPath -ArgumentList "tcp $port" -PassThru -WindowStyle Hidden
    Start-Sleep -Seconds 2  # Allow ngrok to initialize
    $ngrokProcess
}



function Get-NgrokInfo {
    try {
        $ngrokStatus = Invoke-RestMethod http://127.0.0.1:4040/api/tunnels
        $ngrokInfo = $ngrokStatus.tunnels 

        # Convert the information to a formatted string
        $ngrokInfoString = $ngrokInfo | ForEach-Object { "URL: $($_.public_url), Local Address: $($_.config.addr)" }

        # Display the information
        Write-Host "Ngrok Information:"
        Write-Host $ngrokInfoString

        # Copy the information to the clipboard
        $ngrokInfoString | Set-Clipboard

        Write-Host "Ngrok information copied to clipboard."
    }
    catch {
        Write-Host "Error retrieving Ngrok information: $_"
    }
}


# Function to stop ngrok
function Stop-Ngrok {
    Stop-Process -Name ngrok -Force -ErrorAction SilentlyContinue
    Write-Host "Ngrok Has Stopped"
}

# Main menu
while ($true) {
    Clear-Host
    Write-Host "=== Minecraft Server Configuration ==="
    Write-Host "1. Start Minecraft Server"
    Write-Host "2. Initialize New Minecraft Server"
    Write-Host "3. Configure Properties File"
    Write-Host "4. Start Ngrok Tunnel"
    Write-Host "5. Ngrok Information"
    Write-Host "6. Stop Ngrok"
    Write-Host "Q. Quit"

    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        '1' { Start-Mining }
        '2' { Initialize-Server }
        '3' { Register-Properties }
        '4' { Start-Ngrok }
        '5' { Get-NgrokInfo }
        '6' { Stop-Ngrok }
        'Q' { exit }
        default { Write-Host "Invalid choice. Please try again." }
    }

    Write-Host "Press Enter to continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}