# 实验三 systemd入门

## 实验目的
- 学习使用system命令

## 实验视频
- [系统管理](https://asciinema.org/a/G7a7V1jHv3y2KB4ykISgHAHtH)
- [unit管理](https://asciinema.org/a/ITXY9eFMFOdsna1ECczhaFmdz)
- [unit配置文件](https://asciinema.org/a/A5zArkFcOpHSM7LFsaPsnb6JR)
- [Target使用](https://asciinema.org/a/MDnYWPNAeDHFEO75TeKruhz52)
- [日志管理](https://asciinema.org/a/cpOJzak99hUM1Zzlcyal1rJgJ)

## 自查清单

- 如何添加一个用户并使其具备sudo执行程序的权限？
-
  ```shell
    # 创建新用户
    useradd -m newuser
    # 设置密码
    passwd newuser
    # 添加用户到 sudo 组
    usermod -a -G sudo newuser
  ```

- 如何将一个用户添加到一个用户组？

  ```shell
  # 将 newuser 添加到组 staff 中
  usermod -G staff newuser
  ```

- 如何查看当前系统的分区表和文件系统详细信息？

  ```
  fdisk -l
  ```

- 如何实现开机自动挂载Virtualbox的共享目录分区？

  ```
  * 安装增强功能
  * 配置共享文件夹
  * /etc/fstab 文件中，添加 `sharing /mnt/share vboxsf defaults 0 0`
  ```

- 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？

  ```
  - `https://blog.csdn.net/seteor/article/details/6708025`
  - 将逻辑卷组挂载到物理卷组下
  - 在物理卷组有足够剩余空间时,可以对逻辑分区进行扩容
  - 扩容分区
    `lvextend -L +10G -f -r /dev/vg_server1/local`
  - 减少分区容量
    `lvreduce -L -10G -f -r /dev/vg_server1/local`
  ```

- 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

  在networking.service配置文件的区块[Service]处填写`ExecStart`和`ExecStop` 的脚本路径

  ```
  ExecStart=<脚本路径>
  ExecStop=<脚本路径>
  ```

- 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？

  ```
  将`Service`区块"restart:always" ,即不管是什么原因退出，总是重启
  ```
