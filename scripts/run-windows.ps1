$ErrorActionPreference = "Stop"

$arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString().ToLowerInvariant()
switch ($arch) {
  "x64"   { $url = "https://github.com/hemdan-dev/it-collector-build/raw/refs/heads/main/it-collector-windows-amd64.exe" }
  "arm64" { $url = "https://github.com/hemdan-dev/it-collector-build/raw/refs/heads/main/it-collector-windows-arm64.exe" }
  default { throw "Unsupported Windows architecture: $arch" }
}

$file = Join-Path $env:TEMP "it-collector-go.exe"
try {
  Invoke-WebRequest -Uri $url -OutFile $file
  Start-Process -FilePath $file -Verb RunAs -Wait
}
finally {
  Remove-Item $file -Force -ErrorAction SilentlyContinue
}
