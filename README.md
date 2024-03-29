# Minecraft Server Management Script

## Overview

This PowerShell script provides a convenient way to manage your Minecraft server, offering functionalities like starting the server, initializing a new server instance, configuring properties, setting up an Ngrok tunnel, and retrieving Ngrok information.

## Prerequisites

- Ensure you have [Java](https://www.java.com/en/download/) installed on your system.
- Download the [ngrok executable](https://ngrok.com/download) and place it in a directory of your choice.
- Have a Minecraft [server JAR](https://www.minecraft.net/en-us/download/server) file ready.

## Usage

1. **Starting the Minecraft Server:**

   - Run the following command in PowerShell:

     ```powershell
     .\MinecraftUtils.ps1
     ```

2. **Interacting with the Menu:**

   - Use the displayed menu to select options (1-6 or Q for Quit).
   - Press `Enter` to execute the chosen action.

3. **Starting the Minecraft Server:**

   - Choose option `1` to start the Minecraft server.
   - Follow prompts for directory and additional arguments.

4. **Initializing a New Minecraft Server:**

   - Choose option `2` to initialize a new server instance.
   - Provide existing server.jar location and setup details.

5. **Configuring Properties File:**

   - Choose option `3` to configure properties for the server.

6. **Starting an Ngrok Tunnel:**

   - Choose option `4` to start an Ngrok tunnel.
   - Enter the directory where ngrok.exe is located and the port.

7. **Ngrok Information:**

   - Choose option `5` to get information about the Ngrok tunnel.

8. **Stopping Ngrok:**

   - Choose option `6` to stop Ngrok.

9. **Quitting:**
   - Choose option `Q` to exit the script.
