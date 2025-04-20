# Step 4: 파일 처리 (File Handling)

이번 스텝에서는 파일 존재 검사, `while read`, 리다이렉션, 파일 작성 등 실전에서 유용한 파일 처리 방법을 학습합니다.

---

## ✅ 1. 파일 존재 여부 확인

```bash
if [ -f "file.txt" ]; then
  echo "파일이 존재합니다."
else
  echo "파일이 없습니다."
fi
```

| 옵션 | 설명                                |
| ---- | ----------------------------------- |
| `-f` | 일반 파일인지 확인                  |
| `-d` | 디렉토리인지 확인                   |
| `-e` | 존재 여부 확인 (파일 또는 디렉토리) |

---

## ✅ 2. 파일에서 한 줄씩 읽기 (`while read`)

```bash
while read line; do
  echo "읽은 줄: $line"
done < file.txt
```

> 💡 `< file.txt`는 파일 내용을 표준 입력으로 전달.

---

## ✅ 3. IFS 설정하여 CSV 등 처리

```bash
while IFS=',' read -r name age; do
  echo "$name 님은 $age세입니다."
done < users.csv
```

예시 `users.csv`:

```
철수,22
영희,30
```

---

## ✅ 4. 파일 쓰기 (리다이렉션)

| 연산자 | 설명                      |
| ------ | ------------------------- |
| `>`    | 덮어쓰기 (기존 내용 삭제) |
| `>>`   | 이어쓰기 (append)         |

```bash
echo "로그 시작" > log.txt     # 새로 쓰기
echo "추가 로그" >> log.txt     # 이어 쓰기
```

---

## ✅ 5. 명령어 결과를 파일에 저장

```bash
ls -al > file_list.txt
```

---

## ✅ 6. 여러 줄 파일 작성 (`cat <<EOF`)

```bash
cat <<EOF > hello.txt
안녕하세요
DevOps 배우는 중입니다.
EOF
```

---

## ✅ 7. 존재하지 않는 경우 자동 생성

```bash
logfile="app.log"

if [ ! -f "$logfile" ]; then
  touch "$logfile"
  echo "로그 파일 생성됨"
fi
```

---
