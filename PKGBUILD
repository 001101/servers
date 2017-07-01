pkgname=epiphyte-servers
pkgrel=1
pkgdesc="epiphyte package build helpers"
url="https://github.com/epiphyte/servers"
license=('MIT')
makedepends=('git' 'arch-install-scripts')
depends=('perl-json' 'git' 'vim' 'bash-completion' 'smirc')
source=("git+$url")
sha512sums=('SKIP')

package() {
    cd ${srcdir}/servers
    local _pkgdir=$pkgdir"/opt/epiphyte/servers"
    install -Dm 644 configs/gitignore $pkgdir/etc/.gitignore
    install -Dm 644 configs/ntpd.conf $pkgdir/etc/systemd/system/ntpd.service.d/override.conf
    install -Dm 644 configs/nspawn.conf $pkgdir/etc/systemd/system/systemd-nspawn@.service.d/override.conf
    install -Dm 755 sudo-agent/sudo-ssh-agent.sh $pkgdir/etc/profile.d/sudo-ssh-agent.sh
    install -Dm 755 sudo-agent/sudo-agent.sh $_pkgdir/sudo-agent.sh
    for f in $(find . -type f -print | grep -E "\.(timer|service)$"); do
        install -Dm 644 $f $pkgdir/usr/lib/systemd/system/$(basename $f)
    done

    local _bootdir=$_pkgdir/bootstrap/
    # bootstrap
    install -Dm 755 bootstrapper/bootstrapper.sh $pkgdir/usr/local/bin/epiphyte-bootstrap-server
    for f in $(find bootstrapper/ -type f -print | grep "\.template"); do
        install -Dm 644 $f $_bootdir$(basename $f)
    done
    install -Dm 755 bootstrapper/pacstrap-container.sh $pkgdir/usr/local/bin/pacstrap-container
}

