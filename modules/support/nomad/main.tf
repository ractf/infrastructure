resource "nomad_job" "app" {
  jobspec = file("${path.module}/jobfiles/example.hcl")
}
