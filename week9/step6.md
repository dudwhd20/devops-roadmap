# Step 6: 병렬 실행 & 동기 처리 (Background & Parallel)

Bash에서는 `&`, `wait`, `xargs`, `parallel`을 통해 이를 제어할 수 있습니다.

---

## ✅ 1. `&` : 백그라운드 실행

```bash
sleep 3 &
sleep 5 &
echo "모든 작업이 시작됨"
```

- `&`를 붙이면 명령이 백그라운드에서 실행됩니다.
- 여러 명령을 동시에 실행할 때 유용합니다.

---

## ✅ 2. `wait` : 백그라운드 작업이 끝날 때까지 대기

```bash
sleep 3 &
sleep 2 &
wait

echo "모든 작업 완료됨"
```

- `wait`는 모든 백그라운드 프로세스가 종료될 때까지 대기합니다.
- `wait PID` 형식으로 특정 프로세스를 기다릴 수도 있습니다.

---

## ✅ 3. `jobs`, `fg`, `bg` : 작업 제어 명령어

| 명령어  | 설명                              |
| ------- | --------------------------------- |
| `jobs`  | 백그라운드 작업 목록 표시         |
| `fg %n` | n번째 작업을 포그라운드로 가져옴  |
| `bg %n` | 중단된 작업을 백그라운드로 재시작 |

---

## ✅ 4. `xargs`를 이용한 병렬 실행

```bash
cat list.txt | xargs -I {} bash -c 'echo 처리 중: {}; sleep 1'
```

- `xargs`는 파이프를 통해 받은 값을 반복적으로 명령에 전달합니다.
- `-P N` 옵션을 사용하면 N개 병렬 실행이 가능합니다.

### 예제:

```bash
cat list.txt | xargs -n 1 -P 4 bash -c 'echo "{} 시작"; sleep 2'
```

> 동시에 최대 4개의 작업을 병렬 실행

---

## ✅ 5. `parallel` (GNU parallel)

```bash
cat urls.txt | parallel -j 5 curl -O {}
```

- `-j N`: 동시에 N개 작업 수행
- `parallel`은 `xargs`보다 더 강력한 병렬처리 도구로, 설치가 필요합니다.

설치 (Debian/Ubuntu 기준):

```bash
sudo apt install parallel
```

---
