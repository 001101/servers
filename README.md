servers
===

# repository

configure and setup the epiphyte [repository](https://github.com/epiphyte/repository)

# install

make sure to pre-clean and then install
```
pacman -S epiphyte-servers
```

## bootstrapper

setup initial sshd, iptables, resolv, and vimrc settings for the system
```
epiphyte-bootstrap-server
```

for container helper to create a new systemd-nspawn container
```
# cd /var/lib/machines
# mkdir -p <name>
pacstrap-container <name>
```

## zfs

### scrub monthly

enable zfs monthly scrubbing
```
systemctl enable zfs-scrub-monthly.timer
```

## sudo ssh agent

provides socket pass through on ssh
```
sudo-ssh-agent
```

## configs

### vimrc

common/useful vimrc though simple

### gitignore

default gitignore for system etc keeping

### ntpd

an override for ntpd that sets to ipv4 only
