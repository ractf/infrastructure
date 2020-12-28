resource "nomad_job" "example" {
  jobspec = file("${path.module}/jobs/example.hcl")
}
