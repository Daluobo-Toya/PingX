#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
PingX
A powerful network testing and security tool
"""

from setuptools import setup, find_packages

with open('README.md', 'r', encoding='utf-8') as f:
    long_description = f.read()

with open('requirements.txt', 'r', encoding='utf-8') as f:
    requirements = f.read().splitlines()

setup(
    name='pingx',
    version='1.0',
    description='A powerful network testing and security tool',
    long_description=long_description,
    long_description_content_type='text/markdown',
    author='Daluobo',
    author_email='xs62784520@163.com',
    url='https://github.com/daluobo/pingx',
    packages=find_packages(where='src'),
    package_dir={'': 'src'},
    entry_points={
        'console_scripts': [
            'pingx=cli.main:cli',
        ],
    },
    install_requires=requirements,
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: System Administrators',
        'Intended Audience :: Security Professionals',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Topic :: System :: Networking',
        'Topic :: Security',
    ],
    python_requires='>=3.7',
)
