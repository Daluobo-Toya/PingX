#!/bin/bash

# PingX 包装脚本，用于激活虚拟环境并执行命令

# 手动设置脚本所在目录（根据实际安装路径修改）
SCRIPT_DIR="/home/dlb/Tools/PingX"
VENV_DIR="$SCRIPT_DIR/venv"

# 检查虚拟环境是否存在
if [ ! -d "$VENV_DIR" ]; then
    echo "[错误] 虚拟环境不存在，请先运行 install.sh 安装 PingX"
    echo "[错误] 期望的虚拟环境路径: $VENV_DIR"
    echo "[错误] 当前目录: $(pwd)"
    exit 1
fi

# 激活虚拟环境
source "$VENV_DIR/bin/activate"

# 确保 PYTHONPATH 包含项目根目录
export PYTHONPATH="$SCRIPT_DIR"

# 执行 PingX 命令
python "$SCRIPT_DIR/cli/main.py" "$@"

# 退出虚拟环境
deactivate
