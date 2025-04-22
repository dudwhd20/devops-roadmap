resource "local_file" "with_var" {
  content  = "파일명은 변수로 지정!"
  filename = var.filename
}
