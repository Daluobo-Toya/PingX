#!/usr/bin/env powershell

# PingX 卸载脚本
# 用于在 Windows 上卸载 PingX 工具

Write-Host "[*] PingX 卸载脚本" -ForegroundColor Cyan
Write-Host "[*] 正在卸载 PingX 工具..." -ForegroundColor Cyan

# 定义变量
$INSTALL_DIR = "C:\Program Files\PingX"
$SYMLINK = "C:\Windows\System32\pingx.exe"

# 检查是否以管理员权限运行
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Host "[!] 错误：请以管理员权限运行此脚本" -ForegroundColor Red
    Write-Host "[!] 右键点击脚本，选择 '以管理员身份运行'" -ForegroundColor Red
    pause
    exit 1
}

# 检查 PingX 是否安装
if (-not (Test-Path -Path $INSTALL_DIR)) {
    Write-Host "[!] 错误：PingX 似乎未安装在 $INSTALL_DIR" -ForegroundColor Red
    Write-Host "[!] 请检查安装目录是否正确" -ForegroundColor Red
    pause
    exit 1
}

# 移除符号链接或快捷方式
if (Test-Path -Path $SYMLINK) {
    Write-Host "[*] 移除快捷方式 $SYMLINK" -ForegroundColor Yellow
    Remove-Item -Path $SYMLINK -Force
    Write-Host "[+] 快捷方式已移除" -ForegroundColor Green
} else {
    Write-Host "[*] 快捷方式 $SYMLINK 不存在，跳过" -ForegroundColor Yellow
}

# 删除安装目录
Write-Host "[*] 删除安装目录 $INSTALL_DIR" -ForegroundColor Yellow
Remove-Item -Path $INSTALL_DIR -Recurse -Force
Write-Host "[+] 安装目录已删除" -ForegroundColor Green

# 检查并清理环境变量
$envPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($envPath -like "*PingX*") {
    Write-Host "[*] 清理系统环境变量中的 PingX 路径" -ForegroundColor Yellow
    $newEnvPath = $envPath -replace "[^;]*PingX[^;]*;?", ""
    [Environment]::SetEnvironmentVariable("PATH", $newEnvPath, "Machine")
    Write-Host "[+] 环境变量已清理" -ForegroundColor Green
} else {
    Write-Host "[*] 系统环境变量中没有 PingX 相关路径，跳过" -ForegroundColor Yellow
}

# 验证卸载
Write-Host "[*] 验证卸载..." -ForegroundColor Yellow
try {
    $pingxCommand = Get-Command pingx -ErrorAction Stop
    Write-Host "[!] 错误：PingX 命令仍然可用，卸载可能不完整" -ForegroundColor Red
    pause
    exit 1
} catch {
    Write-Host "[+] PingX 命令已不可用，卸载成功" -ForegroundColor Green
}

Write-Host "" -ForegroundColor Cyan
Write-Host "[+] PingX 工具已成功卸载" -ForegroundColor Green
Write-Host "[+] 所有相关文件和配置已清理" -ForegroundColor Green
Write-Host "" -ForegroundColor Cyan
Write-Host "[*] 卸载完成！" -ForegroundColor Cyan
pause
