resource "docker_image" "nginx"{
	name = "nginx:latest"
}


resource "docker_container" "nginx"{
	name = "nignx-server"
	image = docker_image.nginx.name
	ports{
		internal = 80
		external = 8080
	}




}
