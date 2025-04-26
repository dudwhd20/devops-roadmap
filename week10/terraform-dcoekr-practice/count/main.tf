

resource "docker_image" "nginx"{
	name = "nginx:latest"
}

resource "docker_container" "nginx_containers" {
	count = var.container_count


	name = "nginx-${count.index + 1}"
	image = docker_image.nginx.name

	ports{
		internal = 80
		external = var.base_port + count.index
	}
}
