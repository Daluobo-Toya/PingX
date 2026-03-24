# PingX

强大的网络测试和安全工具

## 概述

PingX 是一款功能强大的现代网络测试和安全工具，专为网络工程师、安全专业人员和系统管理员设计。它提供全面的网络测试功能，包括拒绝服务测试、端口扫描、网络探测和数据包构造，帮助用户评估网络安全性和性能。

## 功能

### 核心功能
- **多协议支持**：TCP、UDP、ICMP 和 RAW-IP，满足各种网络测试需求
- **数据包构造**：创建自定义数据包，完全控制头部和负载，支持各种协议的详细参数配置
- **拒绝服务测试**：SYN Flood、UDP Flood、ICMP Flood 攻击，可配置速率、持续时间和数据包大小
- **端口扫描**：SYN、FIN、XMAS 扫描，支持并发扫描和自定义超时设置
- **网络探测**：ICMP 探测、MTU 发现、防火墙测试和路径分析
- **实时统计**：监控数据包发送速率、响应时间、成功率等关键指标
- **连通性验证**：多方法验证目标可达性，包括 ICMP、TCP 80/443 和指定端口

### 现代增强
- **高性能设计**：优化的数据包发送和接收机制，支持高速测试
- **跨平台支持**：适用于 Windows、Linux 和 macOS，提供一致的用户体验
- **模块化架构**：易于通过插件扩展功能，支持自定义测试方法
- **现代命令行界面**：基于 Click 和 Rich 库，提供美观、信息丰富的命令行输出
- **参数灵活性**：支持单破折号参数格式，简化命令输入
- **虚拟环境管理**：自动创建和使用虚拟环境，确保依赖隔离和一致性

## 安装

### 从 GitHub 安装

```bash
# 克隆仓库
git clone https://github.com/Daluobo-Toya/PingX.git
cd PingX

# 使安装脚本可执行
chmod +x install.sh

# 运行安装脚本
sudo ./install.sh
```

### 从源码安装

```bash
# 克隆仓库
git clone https://github.com/Daluobo-Toya/PingX.git
cd PingX

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
git clone https://github.com/Daluobo-Toya/PingX.git
cd PingX

# 运行安装脚本
./install.ps1
```

## 使用

### 命令行模式

#### 基本用法

```bash
# SYN Flood 攻击
pingx dos syn-flood -target 192.168.1.1 -p 80 -rate 1000

# 端口扫描
pingx scan syn-scan -target 192.168.1.1 -ports 1-1000

# ICMP 探测
pingx probe packet-probe -target 192.168.1.1 -protocol icmp
```

#### 高级用法

```bash
# 自定义 TCP 数据包
pingx probe packet-probe -target 192.168.1.1 -protocol tcp -flags SYN -sport 12345 -dport 80 -payload "Hello, World!"

# 带速率限制的 UDP Flood
pingx dos udp-flood -target 192.168.1.1 -p 53 -rate 500 -t 60

# 全面端口扫描
pingx scan syn-scan -target 192.168.1.1 -ports 1-65535 -concurrent 100
```

## 虚拟环境管理

PingX 自动创建并使用位于项目目录下 `venv/` 的虚拟环境。这确保所有依赖被隔离并正确管理，对于 Kali Linux 尤为重要，因为 Kali 上的 pip 可能有限制。

### 虚拟环境优势
- **隔离依赖**：与系统包无冲突，避免依赖版本冲突
- **一致环境**：不同系统上使用相同的依赖版本，确保测试结果一致性
- **易于管理**：简单更新或重建环境，简化依赖管理
- **安全可靠**：避免修改系统级 Python 环境，减少系统风险

## 配置

PingX 使用 YAML 配置文件存储持久设置。默认配置存储在 `~/.pingx/config.yaml`，包含以下主要配置项：

- **默认参数**：设置常用命令的默认值
- **网络设置**：配置网络接口、超时时间等
- **输出设置**：自定义命令行输出格式和颜色
- **插件配置**：管理插件的启用状态和参数

## 插件系统

PingX 支持通过插件系统扩展功能。插件可以放在 `~/.pingx/plugins/` 目录中，支持以下类型的扩展：

- **新的测试方法**：添加自定义的网络测试功能
- **输出格式**：自定义结果展示方式
- **网络协议**：支持新的网络协议
- **集成工具**：与其他网络工具集成

## 文档

PingX 提供全面的文档，帮助用户和开发者快速上手：

- **用户指南**：`docs/user_guide.md` - 详细的使用说明和命令参考
- **开发者指南**：`docs/developer_guide.md` - 插件开发和代码贡献指南
- **API 参考**：`docs/api_reference.md` - 编程接口文档

## 贡献

PingX 欢迎社区贡献！如果你想参与项目开发，可以通过以下方式：

1. **报告问题**：在 GitHub 仓库提交 issue
2. **提交代码**：通过 Pull Request 提交改进和新功能
3. **编写文档**：完善现有文档或添加新的使用示例
4. **开发插件**：创建新的插件扩展功能

请参阅 [开发者指南](docs/developer_guide.md) 获取详细的贡献指南。

## 许可证

PingX 使用 MIT 许可证，允许自由使用、修改和分发。请参阅 [LICENSE](LICENSE) 文件获取完整的许可证文本。

## 作者

- **Daluobo-Toya** - 主要开发者
- 邮箱: xs62784520@163.com
- GitHub: [https://github.com/Daluobo-Toya](https://github.com/Daluobo-Toya)

## 致谢

PingX 基于现代 Python 技术栈构建，感谢以下开源项目的支持：

- **Scapy** - 强大的网络数据包处理库
- **Click** - 命令行接口构建工具
- **Rich** - 富文本终端输出库
- **Python** - 简洁高效的编程语言

PingX 设计灵感来自经典的网络测试工具，但采用现代技术栈和架构，提供更强大、更易用的网络测试和安全功能。
