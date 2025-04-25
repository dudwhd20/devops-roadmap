resource "docker_image" "nginx"{
	name ="nginx:latest"
}


resource "docker_container" "nginx_with_volume"{
	name = "nginx-volume"
	image = docker_image.nginx.name


	ports {
		internal = 80
		external = 8081
	}


	mounts{
		target = "/usr/share/nginx/html"
		source = abspath("${path.module}/html")
		type   = "bind"
	}
}
