# Terraform 로컬 파일 리소스 실습 (terraform-local-demo)

## ✅ 실습 목표
- Terraform 기본 문법 학습
- 변수(`var`) 선언과 참조 방식 익히기
- 출력값(`output`) 구성 방법
- 상태 파일(`terraform.tfstate`)의 역할과 구조 이해

---

## 📁 디렉토리 구조
```
terraform-local-demo/
├── main.tf
├── variables.tf
└── outputs.tf
```

---

## 📄 main.tf
```hcl
resource "local_file" "example" {
  content  = "변수로 파일명을 지정해봅니다!"
  filename = var.filename
}
```

- `local_file`: 로컬에 파일 생성하는 Terraform 리소스
- `content`: 파일 내용
- `filename`: 파일 이름 (변수 참조)

---

## 📄 variables.tf
```hcl
variable "filename" {
  description = "생성할 파일 이름"
  type        = string
  default     = "hello-from-variable.txt"
}
```

- `var.filename`: 이 변수를 다른 곳에서 참조함
- 기본값(default)을 설정해 두되, 덮어쓰기도 가능

---

## 📄 outputs.tf
```hcl
output "file_path" {
  description = "생성된 파일의 경로"
  value       = local_file.example.filename
}

output "input_filename" {
  value = var.filename
}
```

- 리소스 속성과 변수 값을 출력할 수 있음
- 출력값은 `terraform output` 명령으로 확인 가능

---

## ▶️ 실행 흐름
```bash
terraform init         # 초기화
terraform plan         # 실행 계획 확인
terraform apply        # 적용 (파일 생성됨)
terraform output       # 출력값 확인
terraform destroy      # 리소스 제거
```

---

## 🧪 사용자 입력 값 적용 실습

### 방법 1: CLI에서 직접 전달
```bash
terraform apply -var="filename=custom.txt"
```

### 방법 2: tfvars 파일 사용
```hcl
# terraform.tfvars
filename = "from-tfvars.txt"
```
```bash
terraform apply
```

### 방법 3: 환경 변수 이용
```bash
export TF_VAR_filename=my-env.txt
terraform apply
```

---

## 📂 상태 파일(tfstate) 이해
- `terraform.tfstate`는 Terraform이 리소스의 현재 상태를 추적하는 JSON 파일
- 리소스 정보, 속성값, 의존성 등을 포함

```bash
terraform show                # 전체 상태 출력
terraform state list          # 리소스 목록 확인
terraform state show local_file.example   # 리소스 상세 확인
```

> ⚠️ `terraform.tfstate` 파일은 직접 수정 금지 및 Git 커밋 제외 권장