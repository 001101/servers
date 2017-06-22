servers
===

# repository

configure and setup the epiphyte [repository](https://github.com/epiphyte/repository)

## zfs

### scrub monthly

enable zfs monthly scrubbing
```
systemctl enable zfs-scrub-monthly.timer
```

## pkgcaching

### server

enable timed server tasks to clean a package cache
```
systemctl enable pkgcaching-server.timer
```

### client

request an rsyncd-based cache pull
```
systemctl enable pkgcaching.timer
```
