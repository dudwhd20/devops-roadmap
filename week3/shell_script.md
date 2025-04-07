# Shell Script 기초부터 고급 사용까지 정리

DevOps 및 시스템 자동화를 위한 **쉘 스크립트(Bash)** 를 정리한 문서입니다.

---

## ✅ 1. 쉘 스크립트 기본 구조

```bash
#!/bin/bash

echo "Hello, world!"
```

- `#!/bin/bash`: Bash 셸을 사용하겠다는 선언 (shebang)
- `echo`: 문자열 출력 명령어

### 실행 방법

```bash
chmod +x script.sh
./script.sh
```

---

## ✅ 2. 변수 사용법

```bash
name="DevOps"
echo "Hello, $name"
```

- 변수 선언 시 `=` 양쪽에 공백이 없어야 함
- 변수 사용 시 `$변수명` 또는 `"$변수명"` (권장)

### "$변수명" vs $변수명

| 표현        | 차이점                                      |
|-------------|---------------------------------------------|
| `$변수명`   | 공백이 있으면 나뉘어 처리됨                |
| `"$변수명"` | 값 전체를 안전하게 인식 (공백 포함 시 필수) |

---

## ✅ 3. 조건문 if

```bash
if [ "$1" == "start" ]; then
  echo "시작합니다"
else
  echo "알 수 없는 명령입니다"
fi
```

### 숫자 비교 연산자

| 연산자 | 의미       | 예시                     |
|--------|------------|--------------------------|
| -eq    | 같음       | `[ "$a" -eq "$b" ]`      |
| -ne    | 다름       | `[ "$a" -ne "$b" ]`      |
| -lt    | 미만 (<)   | `[ "$a" -lt "$b" ]`      |
| -le    | 이하 (<=)  | `[ "$a" -le "$b" ]`      |
| -gt    | 초과 (>)   | `[ "$a" -gt "$b" ]`      |
| -ge    | 이상 (>=)  | `[ "$a" -ge "$b" ]`      |

---

## ✅ 4. 반복문

### for 문

```bash
for i in 1 2 3
do
  echo "i = $i"
done
```

```bash
for file in *.log
do
  echo "파일: $file"
done
```

### while 문

```bash
count=1
while [ $count -le 3 ]
do
  echo "count: $count"
  ((count++))
done
```

---

## ✅ 5. Here Document (`<<EOF`) 사용법

### 기본 구조

```bash
command <<EOF
여러 줄의
내용을 전달합니다.
EOF
```

### 예제: 파일 생성

```bash
cat <<EOF > file.txt
이 파일은
히어도큐먼트로 만들어졌습니다.
EOF
```

### 예제: ssh 원격 실행

```bash
ssh user@host <<EOF
echo "원격 접속 성공"
cd /var/log
ls -al *.log
EOF
```

### 변수 사용

- 로컬 변수는 자동 치환됨
- 원격 변수는 `\$변수`로 escape 필요
- `'EOF'` 형태로 쓰면 치환 방지 가능

```bash
ssh user@host <<EOF
echo "$HOME"          # 로컬 $HOME 치환됨
echo "\$HOME"         # 원격에서 \$HOME 그대로 전달됨
EOF
```

---

## 🔁 for vs while 비교

| 항목       | for                              | while                              |
|------------|----------------------------------|------------------------------------|
| 반복 대상  | 값 목록                          | 조건                               |
| 종료 방식  | 값 소진 시 자동 종료             | 조건이 false가 되어야 종료         |
| 사용 예    | 범위 반복, 파일 목록 처리         | 사용자 입력, 무한 루프 등          |

---

## 🧠 실전 팁

- 조건문에는 `[ "$var" == "value" ]` 형태로 쓰고, 띄어쓰기를 반드시 지켜야 함
- 변수는 항상 `"$var"`처럼 따옴표로 감싸는 것이 안전
- `<<EOF`를 사용할 때는 로컬 변수와 원격 변수 혼용에 주의

---

> 📌 이 문서는 DevOps 3주차 교육 중 쉘 스크립트 파트를 정리한 실습 문서입니다.
