export ARC=$(uname -a)
export CPU=$(cat /proc/cpuinfo | grep -m 1 "cpu cores" | awk '{print $4}')
export VCPU=$(lscpu | grep -m 1 "CPU(s)" | awk '{print $2}')

# MAMORY RAM
export USAGE_MEM=$(free -m | grep -m 1 "Mem" | awk '{print $3}')
export FULL_MEM=$(free -m | grep -m 1 "Mem" | awk '{print $2}')
export USAGE_MEM_PERCENT=$(free -m | grep -m 1 "Mem" | awk '{printf "%0.2f", $3/$2*100}')

# DISK
export ROOT_MEM=$(df -Bg | grep "root" | awk '{print $2+0}')
export HOME_MEM=$(df -Bg | grep "home" | awk '{print $2+0}')
export FULL_DISK=$(echo $(($HOME_MEM+$ROOT_MEM)))

ROOT_MEM=$(df -Bm | grep "root" | awk '{print $3+0}')
HOME_MEM=$(df -Bm | grep "home" | awk '{print $3+0}')
export USED_DISK=$(echo $(($HOME_MEM+$ROOT_MEM)))

export ROOT_MEM=$(df -Bm | grep "root" | awk '{print $2+0}')
export HOME_MEM=$(df -Bm | grep "home" | awk '{print $2+0}')
export FULL_DISK_MB=$(echo $(($HOME_MEM+$ROOT_MEM)))
export USED_DISK_PERCENT=$(echo "$USED_DISK $FULL_DISK_MB" | awk '{printf "%0.2f", $1/$2*100}')


export CPU_LOAD=$(top -bn 1 | grep "Cpu(s)" | awk '{printf "%0.1f", $2+$4 }')
export UPTIME=$(who -b | awk '{print $3, $4}')
export LVM=$(lsblk | grep -m 1 lvm | wc -l)
if [ $LVM > 0 ]
then
   LVM="yes"
else
   LVM="no"
fi

export TCP=$(ss -at | grep ESTAB | wc -l)
export LOGED_USERS=$(who -u | wc -l)
export IP=$(hostname -I) 
export MAC=$(ip address | grep -m 1 "link/ether" | awk '{print $2}')
export SUDO=$(journalctl -q | grep sudo | grep COMMAND | wc -l)

wall "	#Architecture: $ARC
	#CPU : $CPU
	#VCPU : $VCPU
	#Memory Usage: $USAGE_MEM/${FULL_MEM}MB ($USAGE_MEM_PERCENT%)
	#Disk Usage: ${USED_DISK}/${FULL_DISK}Gb (${USED_DISK_PERCENT}%)
	#CPU load: ${CPU_LOAD}%
	#Last boot: $UPTIME
	#LVM use: $LVM
	#Connexions TCP : $TCP ESTABLISHED
	#User log: $LOGED_USERS
	#Network: IP $IP (${MAC})
	#Sudo : $SUDO cmd"