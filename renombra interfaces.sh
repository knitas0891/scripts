#! /bin/bash

echo "ifconfig | grep UP,BROADCAST > /tmp/ifs" > /root/creanamedif
echo "cat /tmp/ifs | awk {'print \$1'} | awk -F: {'print \$1'}  > /tmp/ifsb" >> /root/creanamedif
echo "for i in \$(cat /tmp/ifsb); do" >> /root/creanamedif
echo "    echo \$i " >> /root/creanamedif
echo "    ifconfig \$i | grep ether| awk {'print \$2'} > /tmp/mac\$i" >> /root/creanamedif
echo "    if [ \$i = \"eth0\" ]" >> /root/creanamedif
echo "    then" >> /root/creanamedif
echo "        echo \"SUBSYSTEM==\\\"net\\\", ACTION==\\\"add\\\", DRIVERS==\\\"?*\\\", ATTR{address}==\\\"\$(cat /tmp/maceth0)\\\", ATTR{type}==\\\"1\\\", KERNEL==\\\"eth*\\\", NAME=\\\"LAN\\\"\" > /etc/udev/rules.d/70-persistent-net.rules" >> /root/creanamedif
echo "    fi" >> /root/creanamedif
echo "    if [ \$i = \"eth1\" ]" >> /root/creanamedif
echo "    then" >> /root/creanamedif
echo "        echo \"SUBSYSTEM==\\\"net\\\", ACTION==\\\"add\\\", DRIVERS==\\\"?*\\\", ATTR{address}==\\\"\$(cat /tmp/maceth1)\\\", ATTR{type}==\\\"1\\\", KERNEL==\\\"eth*\\\", NAME=\\\"DSL\\\"\" >> /etc/udev/rules.d/70-persistent-net.rules" >> /root/creanamedif
echo "    fi" >> /root/creanamedif
echo "done" >> /root/creanamedif
chmod +x /root/creanamedif
/root/creanamedif
