pkgname=epiphyte-servers
pkgver=0.1
pkgrel=0
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
    local _pkgdir=$pkgdir"opt/epiphyte/servers"
    install -Dm 755 pkgcaching/run.sh $_pkgdir/pkgcache.sh
    install -Dm 755 pkgcaching/server.sh $_pkgdir/pkgcache-server.sh
    install -Dm 644 pkgcaching/pkgcache.conf $_pkgdir/etc/epiphyte.d/pkgcache.conf
    for f in $(find . -type f -print | grep -E "\.(timer|service)$"); do
        install -Dm 644 $f $pkgdir/usr/lib/systemd/system/$(basename $f)
    done
}

