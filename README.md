# PingX

强大的网络测试和安全工具

## 概述

PingX 是一款现代、功能丰富的网络测试和安全工具。它提供高级网络测试功能，包括数据包构造、DoS 测试、端口扫描和网络探测。

## 功能

### 核心功能
- **多协议支持**：TCP、UDP、ICMP 和 RAW-IP
- **数据包构造**：创建自定义数据包，完全控制头部和负载
- **DoS 测试**：SYN Flood、UDP Flood、ICMP Flood 攻击
- **端口扫描**：SYN、FIN、XMAS 和 NULL 扫描
- **网络探测**：MTU 发现、防火墙测试和路径分析
- **实时统计**：监控数据包速率、响应时间等

### 现代增强
- **异步操作**：高性能数据包发送和接收
- **跨平台支持**：适用于 Windows、Linux 和 macOS
- **模块化架构**：易于通过插件扩展
- **现代命令行界面**：用户友好的命令行界面，具有丰富的输出
- **API 支持**：可编程接口，便于与其他工具集成
- **交互式shell**：进入交互式模式，获得更友好的用户体验
- **虚拟环境管理**：自动创建和使用虚拟环境

## 安装

### 从 GitHub 安装

```bash
# 克隆仓库
git clone https://github.com/daluobo/pingx.git
cd pingx

# 使安装脚本可执行
chmod +x install.sh

# 运行安装脚本
sudo ./install.sh
```

### 从源码安装

```bash
# 克隆仓库
git clone https://github.com/daluobo/pingx.git
cd pingx

# 创建虚拟环境
python3 -m venv venv

# 激活虚拟环境
source venv/bin/activate

# 安装依赖
pip install -r requirements.txt

# 安装包
pip install -e .

# 创建符号链接以便于访问
sudo ln -sf "$(pwd)/venv/bin/pingx" /usr/local/bin/pingx
```

### Windows 安装

```powershell
# 克隆仓库
git clone https://github.com/daluobo/pingx.git
cd pingx

# 运行安装脚本
./install.ps1
```

## 使用

### 交互式模式

直接输入 `pingx` 进入交互式模式：

```bash
$ pingx
PingX 交互式 Shell
输入 'help' 查看可用命令，'exit' 退出
>
```

在交互式模式下，您可以运行如下命令：

```
> dos syn-flood
SYN Flood 攻击
目标 IP 地址: 192.168.1.1
目标端口: 80
每秒数据包数: 1000
持续时间（秒）: 60
启用 IP 欺骗？(y/n): n
```

### 命令行模式

#### 基本用法

```bash
# SYN Flood 攻击
pingx dos syn-flood --target 192.168.1.1 --port 80 --rate 1000

# 端口扫描
pingx scan syn-scan --target 192.168.1.1 --ports 1-1000

# ICMP 探测
pingx probe packet-probe --target 192.168.1.1 --protocol icmp
```

#### 高级用法

```bash
# 自定义 TCP 数据包
pingx probe packet-probe --target 192.168.1.1 --protocol tcp --flags SYN --sport 12345 --dport 80 --payload "Hello, World!"

# 带速率限制的 UDP Flood
pingx dos udp-flood --target 192.168.1.1 --port 53 --rate 500 --duration 60

# 全面端口扫描
pingx scan syn-scan --target 192.168.1.1 --ports 1-65535 --concurrent 100
```

## 虚拟环境管理

PingX 自动创建并使用位于项目目录下 `venv/` 的虚拟环境。这确保所有依赖被隔离并正确管理，对于 Kali Linux 尤为重要，因为 Kali 上的 pip 可能有限制。

### 虚拟环境优势
- **隔离依赖**：与系统包无冲突
- **一致环境**：不同系统上使用相同的依赖
- **易于管理**：简单更新或重建环境

## 配置

PingX 使用 YAML 配置文件存储持久设置。默认配置存储在 `~/.pingx/config.yaml`。

## 插件

PingX 支持通过插件系统扩展功能。插件可以放在 `~/.pingx/plugins/` 目录中。

## 文档

- **用户指南**：`docs/user_guide.md`
- **开发者指南**：`docs/developer_guide.md`
- **API 参考**：`docs/api_reference.md`

## 贡献

欢迎贡献！请参阅 [开发者指南](docs/developer_guide.md) 获取更多信息。

## 许可证

PingX 使用 MIT 许可证。请参阅 [LICENSE](LICENSE) 文件获取更多信息。

## 作者

- **Daluobo** - 主要开发者
- 邮箱: xs62784520@163.com

## 致谢

PingX 使用现代 Python 构建，提供丰富的网络测试和安全功能。
