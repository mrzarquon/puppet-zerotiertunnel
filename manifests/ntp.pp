# simple class to create a profile like thing
class zerotiertunnel::ntp (
  $servers,
) {
  class { 'ntp':
      servers => $servers,
  }
}
