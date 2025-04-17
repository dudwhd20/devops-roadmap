## 🧩 Step 1: 함수(Function)

### 📌 개념

- Bash 함수는 반복적인 작업을 하나의 블록으로 묶어 재사용할 수 있는 구조입니다.
- 프로그래밍 언어와 달리 함수 선언 시 파라미터를 명시하지 않으며, 위치 기반 인자(`$1`, `$2`, ...)로 접근합니다.

### ✅ 기본 구조

```bash
함수이름() {
  명령어들
}
```

### 🧪 예제 1: 함수 정의 및 호출

```bash
say_hello() {
  echo "안녕하세요, DevOps 세계에 오신 걸 환영합니다!"
}

say_hello
```

### 🧪 예제 2: 파라미터 전달

```bash
greet() {
  echo "안녕하세요, $1님!"
}

greet "영종"
```

### 📥 함수 반환값 처리 (`echo` 기반)

```bash
add_numbers() {
  local sum=$(( $1 + $2 ))
  echo "$sum"
}

result=$(add_numbers 3 7)
echo "결과: $result"
```

> 📌 `return` 키워드는 0~255 범위의 숫자만 반환 가능 (보통 성공/실패 코드용)

### 🧪 예제 3: 파일 존재 체크 함수

```bash
check_file_exists() {
  if [[ -f "$1" ]]; then
    echo "$1 파일이 존재합니다."
    return 0
  else
    echo "$1 파일이 없습니다."
    return 1
  fi
}

check_file_exists "/etc/passwd" || echo "에러 처리 로직 실행됨"
```

### 📊 파라미터 제어 관련 내장 변수

| 변수 | 설명                        |
| ---- | --------------------------- |
| `$#` | 인자의 개수                 |
| `$@` | 인자 목록 (배열처럼 다룸)   |
| `$*` | 인자 전체 (문자열처럼 다룸) |

### 🧪 예제 4: 동적 파라미터 처리

```bash
dynamic_add() {
  local sum=0
  for i in "$@"; do
    sum=$((sum + i))
  done
  echo "$sum"
}

dynamic_add 1 2 3 4 5
```

### 🛡️ 인자 체크 실전 예제

```bash
safe_echo() {
  if [ $# -lt 1 ]; then
    echo "사용법: safe_echo <문자열>"
    return 1
  fi
  echo "입력된 문자열: $1"
}
```

---

> 다음 Step: 배열(Array)

---
