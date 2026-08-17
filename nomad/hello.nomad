job "hello-devops" {
  datacenters = ["dc1"]
  type = "service"

  group "hello" {
    count = 1

    task "hello" {
      driver = "docker"

      config {
        image = "devops-hello"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
