# 使用ansible技术重构FTP、NFS、DHCP、DNS、Samba服务器的自动安装与自动配置

ansible安装与配置

- ```sudo apt-get nstall ansible ```

- 修改```/etc/ansible/hosts```

  添加远程被控制主机的ip ```192.168.56.101```

- 修改ansible配置文件 ```/etc/ansible/ansible.cfg```

```    # 禁用每次执行ansible命令检查ssh key host
    host_key_checking = False
    # 开启日志记录
    log_path = /var/log/ansible.log
    # 连接加速配置
    [accelerate]
    #accelerate_port = 5099
    accelerate_port = 10000
    #accelerate_timeout = 30
    #accelerate_connect_timeout = 5.0

    # If set to yes, accelerate_multi_key will allow multiple
    # private keys to be uploaded to it, though each user must
    # have access to the system via SSH to add a new key. The default
    # is "no".
    accelerate_multi_key = yes```
