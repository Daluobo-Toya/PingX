#!/bin/bash

# PingX 安装脚本

set -e

echo "========================================"
echo "PingX 安装脚本"
echo "========================================"

# 检查是否在 Kali Linux 上
if [[ ! -f /etc/kali_version ]]; then
    echo "[警告] 此脚本针对 Kali Linux 优化，但会尝试在当前系统上运行"
fi

# 创建虚拟环境
echo "[信息] 创建虚拟环境..."
python3 -m venv venv

# 激活虚拟环境
echo "[信息] 激活虚拟环境..."
source venv/bin/activate

# 自动选择最快的镜像源
echo "[信息] 检测并选择最快的镜像源..."

# 定义国内镜像源列表
MIRRORS=("https://pypi.tuna.tsinghua.edu.cn/simple" "https://mirrors.aliyun.com/pypi/simple" "https://pypi.mirrors.ustc.edu.cn/simple" "https://pypi.org/simple")

# 测试镜像源响应时间
fastest_mirror=""
fastest_time=999999

for mirror in "${MIRRORS[@]}"; do
    # 测试镜像源响应时间
    start_time=$(date +%s.%N)
    curl -s -o /dev/null -w "%{http_code}" "$mirror" > /dev/null 2>&1
    end_time=$(date +%s.%N)
    response_time=$(echo "$end_time - $start_time" | bc)
    
    # 转换为毫秒
    response_time_ms=$(echo "$response_time * 1000" | bc | cut -d. -f1)
    
    echo "[信息] 镜像源 $mirror 响应时间: ${response_time_ms}ms"
    
    # 更新最快镜像源
    if (( $(echo "$response_time < $fastest_time" | bc -l) )); then
        fastest_time=$response_time
        fastest_mirror=$mirror
    fi
done

echo "[信息] 选择最快的镜像源: $fastest_mirror"

# 升级 pip
echo "[信息] 升级 pip..."
pip install -i "$fastest_mirror" --upgrade pip

# 安装依赖
echo "[信息] 安装依赖..."
pip install -i "$fastest_mirror" -r requirements.txt

# 安装 PingX
echo "[信息] 安装 PingX..."
# 安装为可编辑模式，这样修改代码后不需要重新安装
pip install -i "$fastest_mirror" -e .

# 创建符号链接以便于访问
echo "[信息] 创建符号链接以便于访问..."
# 先删除可能存在的符号链接或可执行文件
sudo rm -f /usr/local/bin/pingx
# 创建新的符号链接，指向我们的包装脚本
sudo ln -sf "$(pwd)/pingx_wrapper.sh" /usr/local/bin/pingx
# 设置执行权限
chmod +x "$(pwd)/pingx_wrapper.sh"

# 验证安装
echo "[信息] 验证安装..."
# 直接运行包装脚本进行验证
"$(pwd)/pingx_wrapper.sh" version

# 测试模块导入
echo "[信息] 测试模块导入..."
source venv/bin/activate
export PYTHONPATH="$(pwd)"
python -c "import cli; print('模块导入成功')"
deactivate

echo ""
echo "[成功] PingX 安装完成!"
echo "现在您可以在终端中使用 'pingx' 命令。"
echo "输入 'pingx help' 查看可用命令。"
echo "========================================"
