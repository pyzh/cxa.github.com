---
title: 硬盘安装Zenwalk的注意事项
---
[Zenwalk][0]（刚开始的时候叫MiniSlack）是一个轻量级的Slackware衍生版本，跟Vector差不多。两者比较大的区别是，Zenwalk支持ReiserFS 4，从而引起我一丝兴趣，决定安装一个试试。

既然是Slackware的衍生版本，那么按照Slackware的方法来安装它应该没有问题。Slackware只要有bzImage和color.gz即可安装，把Zenwalk安装盘文件（iso）解压开来，可以在kernel目录下找到bzImage（有ata和scsi两个版本），在isolinux目录下发现initrd.img。有这两个文件就够了。

接着，使用lilo/grub（Dos版或者linux版都可以）进行引导，即可进入安装，安装界面跟Slackware差不多，配色稍微变化而已。加了swap区，分好root等分区后，即可开始了。这里要注意，选择硬盘安装方式后，Slackware要你填入分区，然后填目录，Zenwalk需要直接填写安装源，因此必须先把安装文件所在的盘mount好。

一切按照Slackware的方式进行，直到它叫你Ctrl + Alt + Del。注意！！！此时不能这样做，你还不能重起！或许是由于Zenwalk对硬盘安装的支持还不是很完善，如果此时重起，你是没有机会进入Zenwalk的……因为，它还没有装上引导！

Alt + Fn(n=2-7)打开终端，把刚才所安装Zenwalk的root目录mount上，chroot进去，编写/etc/lilo.conf（还没有就新建），写好后执行lilo，这样才算大功告成。

好了，我可以试用我的ReiserFS 4版的Slackware了……

[0]: http://zenwalk.org
