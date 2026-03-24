#!/bin/bash

# 修复 PingX 安装问题的脚本

echo "[*] PingX 安装修复脚本"
echo "[*] 正在检查安装情况..."

# 获取当前目录
CURRENT_DIR="$(pwd)"
echo "[*] 当前目录: $CURRENT_DIR"

# 检查虚拟环境
if [ ! -d "$CURRENT_DIR/venv" ]; then
    echo "[!] 错误：虚拟环境不存在，请先运行 install.sh 安装 PingX"
    exit 1
fi

echo "[+] 虚拟环境存在: $CURRENT_DIR/venv"

# 检查符号链接
echo "[*] 检查符号链接..."
if [ -L "/usr/local/bin/pingx" ]; then
    echo "[+] 符号链接存在: /usr/local/bin/pingx"
    echo "[+] 符号链接指向: $(readlink /usr/local/bin/pingx)"
else
    echo "[!] 符号链接不存在"
fi

# 检查虚拟环境中的 pingx 可执行文件
echo "[*] 检查虚拟环境中的 pingx 可执行文件..."
if [ -f "$CURRENT_DIR/venv/bin/pingx" ]; then
    echo "[+] 虚拟环境中的 pingx 可执行文件存在"
    echo "[*] 文件内容:"
    cat "$CURRENT_DIR/venv/bin/pingx"
else
    echo "[!] 虚拟环境中的 pingx 可执行文件不存在"
fi

# 修复符号链接
echo "[*] 修复符号链接..."
sudo rm -f /usr/local/bin/pingx
sudo ln -sf "$CURRENT_DIR/pingx_wrapper.sh" /usr/local/bin/pingx
chmod +x "$CURRENT_DIR/pingx_wrapper.sh"
echo "[+] 符号链接已修复"

# 测试运行
echo "[*] 测试运行 pingx..."
$CURRENT_DIR/pingx_wrapper.sh version

echo "[*] 修复完成！"
