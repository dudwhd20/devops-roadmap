resource "null_resource" "before" {
	provisioner "local-exec" {
		command = "echo '[1] 먼저 실행할 리소스입니다. ' > before.txt"
	}
	
}


resource "null_resource" "after"{
	depends_on = [null_resource.before]

	provisioner "local-exec" {
		command = "echo '[2] 반드시 위 리소스 이후 실행됩니다.' > after.txt"
	}
	
}


