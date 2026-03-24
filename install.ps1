#!/usr/bin/env pwsh

# PingX Windows 安装脚本

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PingX Windows 安装脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 创建虚拟环境
Write-Host "[信息] 创建虚拟环境..." -ForegroundColor Green
python -m venv venv

# 激活虚拟环境
Write-Host "[信息] 激活虚拟环境..." -ForegroundColor Green
$activateScript = Join-Path (Get-Location) "venv\Scripts\Activate.ps1"
& $activateScript

# 升级 pip
Write-Host "[信息] 升级 pip..." -ForegroundColor Green
pip install --upgrade pip

# 安装依赖
Write-Host "[信息] 安装依赖..." -ForegroundColor Green
pip install -r requirements.txt

# 安装 PingX
Write-Host "[信息] 安装 PingX..." -ForegroundColor Green
pip install -e .

# 添加到 PATH（临时用于本次会话）
Write-Host "[信息] 将 PingX 添加到 PATH..." -ForegroundColor Green
$currentDir = Get-Location
$env:PATH = "$currentDir;$env:PATH"
# 设置执行权限
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
chmod +x "$currentDir\pingx_wrapper.ps1"

# 验证安装
Write-Host "[信息] 验证安装..." -ForegroundColor Green
pingx version

Write-Host "" -ForegroundColor White
Write-Host "[成功] PingX 安装完成!" -ForegroundColor Green
Write-Host "现在您可以在终端中使用 'pingx' 命令。" -ForegroundColor White
Write-Host "输入 'pingx help' 查看可用命令。" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
