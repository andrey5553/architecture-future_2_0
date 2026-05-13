Invoke-WebRequest -Uri "https://storage.yandexcloud.net/yandexcloud-yc/release/stable/windows/amd64/yc-windows-amd64.zip" -OutFile "$env:TEMP\yc.zip"

# Распакуйте
Expand-Archive -Path "$env:TEMP\yc.zip" -DestinationPath "$env:TEMP\yc"

# Скопируйте в Program Files
Copy-Item -Path "$env:TEMP\yc\yc.exe" -Destination "C:\Program Files\yc\yc.exe" -Force

# Добавьте в PATH (нужен PowerShell с админ правами)
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\yc", [EnvironmentVariableTarget]::Machine)

# Проверьте установку
yc version
