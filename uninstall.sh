#!/bin/bash

# PingX 卸载脚本
# 用于在 Kali Linux 上卸载 PingX 工具

set -e

echo "[*] PingX 卸载脚本"
echo "[*] 正在卸载 PingX 工具..."

# 定义可能的安装目录
POSSIBLE_DIRS=("/opt/pingx" "$(pwd)" "$HOME/pingx" "$HOME/PingX")
SYMLINK="/usr/local/bin/pingx"
INSTALL_DIR=""

# 检查是否以 root 权限运行
if [ "$(id -u)" != "0" ]; then
    echo "[!] 错误：请使用 root 权限运行此脚本"
    echo "[!] 例如：sudo ./uninstall.sh"
    exit 1
fi

# 自动检测 PingX 安装位置
echo "[*] 正在检测 PingX 安装位置..."
for dir in "${POSSIBLE_DIRS[@]}"; do
    if [ -d "$dir" ] && [ -f "$dir/cli/main.py" ]; then
        INSTALL_DIR="$dir"
        echo "[+] 找到 PingX 安装在：$INSTALL_DIR"
        break
    fi
done

# 检查 PingX 是否安装
if [ -z "$INSTALL_DIR" ]; then
    echo "[!] 错误：未找到 PingX 安装目录"
    echo "[!] 请确保 PingX 已正确安装"
    exit 1
fi

# 移除符号链接
if [ -L "$SYMLINK" ]; then
    echo "[*] 移除符号链接 $SYMLINK"
    rm -f "$SYMLINK"
    echo "[+] 符号链接已移除"
else
    echo "[*] 符号链接 $SYMLINK 不存在，跳过"
fi

# 删除安装目录
echo "[*] 删除安装目录 $INSTALL_DIR"
rm -rf "$INSTALL_DIR"
echo "[+] 安装目录已删除"

# 检查并清理环境变量
if grep -q "pingx" ~/.bashrc; then
    echo "[*] 清理 .bashrc 中的环境变量"
    sed -i '/pingx/d' ~/.bashrc
    echo "[+] 环境变量已清理"
else
    echo "[*] .bashrc 中没有 PingX 相关环境变量，跳过"
fi

if grep -q "pingx" ~/.zshrc; then
    echo "[*] 清理 .zshrc 中的环境变量"
    sed -i '/pingx/d' ~/.zshrc
    echo "[+] 环境变量已清理"
else
    echo "[*] .zshrc 中没有 PingX 相关环境变量，跳过"
fi

# 验证卸载
echo "[*] 验证卸载..."
if command -v pingx >/dev/null 2>&1; then
    echo "[!] 错误：PingX 命令仍然可用，卸载可能不完整"
    exit 1
else
    echo "[+] PingX 命令已不可用，卸载成功"
fi

echo ""
echo "[+] PingX 工具已成功卸载"
echo "[+] 所有相关文件和配置已清理"
echo ""
echo "[*] 卸载完成！"
