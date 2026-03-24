#!/usr/bin/env pwsh

# PingX 包装脚本，用于激活虚拟环境并执行命令

# 获取脚本所在目录
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$VENV_DIR = Join-Path $SCRIPT_DIR "venv"

# 检查虚拟环境是否存在
if (-not (Test-Path -Path $VENV_DIR -PathType Container)) {
    Write-Host "[错误] 虚拟环境不存在，请先运行 install.ps1 安装 PingX" -ForegroundColor Red
    exit 1
}

# 激活虚拟环境
$ACTIVATE_SCRIPT = Join-Path $VENV_DIR "Scripts\Activate.ps1"
& $ACTIVATE_SCRIPT

# 执行 PingX 命令
python -m cli.main $args

# 退出虚拟环境
deactivate
