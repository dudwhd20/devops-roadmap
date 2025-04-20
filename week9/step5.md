# Step 5: 에러 처리 & 로그 분리

---

## ✅ 1. `set -e`: 에러 발생 시 스크립트 즉시 종료

```bash
set -e
```

- 스크립트 내 명령이 실패(0이 아닌 exit code 반환)하면 즉시 종료됨
- 테스트 중에는 비활성화 가능: `set +e`

### 예제:

```bash
set -e
echo "작업 1"
false  # 실패 명령
echo "작업 2"  # 실행되지 않음
```

---

## ✅ 2. `trap`: 종료/에러 시 실행할 명령 등록

```bash
trap 'echo "에러 발생!"; exit 1' ERR
trap 'echo "스크립트 종료됨"' EXIT
```

| 시그널 | 설명                           |
| ------ | ------------------------------ |
| `EXIT` | 스크립트 종료 시 실행          |
| `ERR`  | 명령어 실패 시 실행            |
| `INT`  | Ctrl+C (인터럽트) 발생 시 실행 |

### 예제:

```bash
trap 'echo "스크립트 종료됨"' EXIT
trap 'echo "오류 발생!"' ERR

echo "실행 중..."
false  # ERR 트리거됨
```

---

## ✅ 3. 표준 출력 / 에러 로그 분리

```bash
echo "정상 메시지" > stdout.log
echo "에러 메시지" > stderr.log 2>&1
```

| 연산자 | 의미                              |
| ------ | --------------------------------- |
| `>`    | 표준 출력 리다이렉션              |
| `2>`   | 표준 에러 리다이렉션              |
| `2>&1` | 에러를 출력으로 합치기            |
| `&>`   | 출력 + 에러 모두 저장 (bash 전용) |

### 예제:

```bash
ls . > output.log 2> error.log
```

---

## ✅ 4. 로그 출력 + 저장 (`tee` 사용)

`tee`는 로그를 파일에 저장하면서도 화면에 동시에 출력합니다.

```bash
echo "시작합니다" | tee -a combined.log
```

### 예제:

```bash
my_log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a script.log
}

my_log "백업 시작"
sleep 2
my_log "백업 완료"
```

---
