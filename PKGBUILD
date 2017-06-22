pkgname=epiphyte-servers
pkgver=0.1
pkgrel=5
pkgdesc="epiphyte package build helpers"
url="https://github.com/epiphyte/servers"
license=('MIT')
makedepends=('git')
depends=()
source=("git+$url")
sha512sums=('SKIP')
backup=("etc/epiphyte.d/pkgcache.conf")

package() {
    cd ${srcdir}/servers
    local _pkgdir=$pkgdir"/opt/epiphyte/servers"
    install -Dm 755 pkgcaching/run.sh $_pkgdir/pkgcache.sh
    install -Dm 755 pkgcaching/server.sh $_pkgdir/pkgcache-server.sh
    install -Dm 644 pkgcaching/pkgcache.conf $pkgdir/etc/epiphyte.d/pkgcache.conf
    install -Dm 644 configs/vimrc $pkgdir/etc/vimrc
    install -Dm 644 configs/gitignore $pkgdir/etc/.gitignore
    install -Dm 644 configs/ntpd.conf $pkgdir/etc/systemd/system/ntpd.service.d/override.conf
    install -Dm 755 sudo-agent/sudo-ssh-agent.sh $pkgdir/etc/profile.d/sudo-ssh-agent.sh
    install -Dm 755 sudo-agent/sudo-agent.sh $_pkgdir/sudo-agent.sh
    for f in $(find . -type f -print | grep -E "\.(timer|service)$"); do
        install -Dm 644 $f $pkgdir/usr/lib/systemd/system/$(basename $f)
    done
}

