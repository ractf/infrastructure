resource "github_repository" "shell" {
  name        = "shell"
  description = "A shiny new SPA frontend for the RACTF core."
  private     = false
}

resource "github_repository" "core" {
  name        = "core"
  description = "The public RACTF backend."
  private     = false
}

resource "github_repository" "infrastructure" {
  name        = "infrastructure"
  description = "The infrastructure-as-code which runs the cloud components of RACTF."
  private     = false
}

resource "github_repository" "ui-kit" {
  name        = "ui-kit"
  description = "The RACTF UI framework."
  private     = false
}

resource "github_repository" "challenges" {
  name        = "challenges"
  description = "RACTF challenges."
  private     = true
}

resource "github_repository" "homepage" {
  name        = "homepage"
  description = "The RACTF UI homepage."
  private     = true
}

resource "github_repository" "writeups" {
  name        = "writeups"
  description = "Community-contributed writeups for RACTF!"
  private     = false
}

resource "github_repository" "andromeda" {
  name        = "andromeda"
  description = "Manages challenge docker containers for RACTF."
  private     = false
}

resource "github_repository" "backend" {
  name        = "backend"
  description = "The proprietary RACTF backend."
  private     = true
}
