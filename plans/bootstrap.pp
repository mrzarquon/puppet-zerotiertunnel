plan zerotiertunnel::bootstrap (
  TargetSpec $nodes,
) {

  add_to_group($nodes, 'raspberrybootstrap')

  $result = run_command('echo `whoami`', $nodes)

  notice("result: ${result}")

}
