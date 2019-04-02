class zerotiertunnel::install (
  $version,
  $networks,
) {
  archive { '/tmp/staging/zerotier.dpkg':
    source => "https://download.zerotier.com/debian/stretch/pool/main/z/zerotier-one/zerotier-one_${version}_armhf.deb",
  }

  package { 'zerotier-one':
    ensure   => latest,
    provider => dpkg,
    source   => '/tmp/staging/zerotier.dpkg',
    require  => Archive['/tmp/staging/zerotier.dpkg'],
  }

  service { 'zerotier-one':
    ensure    => 'running',
    enable    => 'true',
    subscribe => Package['zerotier-one'],
  }

  $networks.each |$network| {
    exec { "Join-Zerotier-Network-${network}":
      command => "/usr/sbin/zerotier-cli join ${network}",
      unless  => "/usr/sbin/zerotier-cli listnetworks | /bin/grep ${network}",
    }
  }
}
