#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
测试数据包大小调整功能
"""

from src.core.packet.builder import PacketBuilder

def test_packet_size():
    """测试数据包大小调整功能"""
    builder = PacketBuilder()
    
    print("测试数据包大小调整功能...")
    
    # 测试 TCP 数据包
    print("\n1. 测试 TCP 数据包:")
    tcp_packet = builder.build_tcp(
        src_ip="192.168.1.1",
        dst_ip="192.168.1.100",
        src_port=12345,
        dst_port=80,
        flags="S",
        packet_size=100
    )
    print(f"  原始大小: {len(tcp_packet)}")
    
    # 测试 UDP 数据包
    print("\n2. 测试 UDP 数据包:")
    udp_packet = builder.build_udp(
        src_ip="192.168.1.1",
        dst_ip="192.168.1.100",
        src_port=12345,
        dst_port=80,
        packet_size=150
    )
    print(f"  原始大小: {len(udp_packet)}")
    
    # 测试 ICMP 数据包
    print("\n3. 测试 ICMP 数据包:")
    icmp_packet = builder.build_icmp(
        src_ip="192.168.1.1",
        dst_ip="192.168.1.100",
        type=8,
        code=0,
        packet_size=200
    )
    print(f"  原始大小: {len(icmp_packet)}")
    
    # 测试原始 IP 数据包
    print("\n4. 测试原始 IP 数据包:")
    raw_packet = builder.build_raw(
        src_ip="192.168.1.1",
        dst_ip="192.168.1.100",
        protocol=6,
        packet_size=250
    )
    print(f"  原始大小: {len(raw_packet)}")
    
    print("\n测试完成！")

if __name__ == "__main__":
    test_packet_size()
