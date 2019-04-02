plan zerotiertunnel::build (
  TargetSpec $nodes,
) {

  run_task('zerotiertunnel::gem_puppet', $nodes)

  apply_prep($nodes)

  $reports = apply ($nodes) {
    include zerotiertunnel::ntp
    include zerotiertunnel::install
  }
  $reports.each |$report| {
    notice("Node: ${report.target.name} Report: ${report.report}")
  }
}
