# build.ps1
# 导入 VS 环境
# 此模式打包出一个exe, 并且嵌入元数据，防止杀毒软件报错
cmd /c "call `"C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat`" -arch=x64 -host_arch=x64 && set" | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
    }
}

# 激活 conda 环境
conda activate packingTest

# 打包（移除了不支持的参数）
python -m nuitka --standalone --onefile --windows-console-mode=disable --enable-plugin=pyside6 --msvc=latest --lto=no --remove-output --output-dir=dist `
    --windows-company-name="YourCompanyName" `
    --windows-product-name="HelloApplication" `
    --windows-file-version=1.0.0.1 `
    --windows-product-version=1.0.0.1 `
    --windows-file-description="Hello GUI Application" `
    hello.py

Write-Host "Build completed! Check dist\hello.dist\hello.exe"