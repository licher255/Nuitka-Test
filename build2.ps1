l# build.ps1
# 导入 VS 环境
# 此模式打包出依赖为dll
cmd /c "call `"C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat`" -arch=x64 -host_arch=x64 && set" | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
    }
}

# 激活 conda 环境
conda activate packingTest

# 打包
python -m nuitka --standalone --windows-console-mode=disable --enable-plugin=pyside6 --msvc=latest --lto=yes --remove-output --output-dir=dist --windows-company-name="YourCompany" --windows-product-name="HelloApp" --windows-file-version=1.0.0.0 hello.py
Write-Host "Build completed! Check dist\hello.exe"