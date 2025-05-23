# Linux `top` 명령어 상단 정보 해석

Linux 시스템에서 자원 사용 상태를 실시간으로 모니터링할 때 `top` 명령어는 매우 유용합니다.  
이 문서에서는 `top` 명령어의 **상단(요약) 영역**에 표시되는 정보를 항목별로 분석하고, 이를 어떻게 해석하면 되는지를 설명합니다.

---

## 🧭 전체 화면 예시

```bash
top - 15:12:47 up 3:27, 2 users, load average: 0.42, 0.58, 0.60
Tasks: 134 total,   1 running, 133 sleeping,   0 stopped,   0 zombie
%Cpu(s):  5.3 us,  2.0 sy,  0.0 ni, 91.7 id,  0.7 wa,  0.0 hi,  0.3 si,  0.0 st
MiB Mem :   7972.2 total,   1045.7 free,   2444.6 used,   4481.8 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   5003.5 avail Mem
```

---

## 1️⃣ 시스템 기본 정보

```bash
top - 15:12:47 up 3:27, 2 users, load average: 0.42, 0.58, 0.60
```

| 항목           | 설명                                                                   |
| -------------- | ---------------------------------------------------------------------- |
| `15:12:47`     | 현재 시스템 시간                                                       |
| `up 3:27`      | 시스템이 부팅된 후 경과된 시간                                         |
| `2 users`      | 현재 로그인한 사용자 수                                                |
| `load average` | 1분, 5분, 15분간의 CPU 평균 부하<br>→ CPU 코어 수보다 작으면 여유 있음 |

> 💡 **예시**: CPU가 4코어라면 load average가 4.00 이하이면 정상 범주입니다.

---

## 2️⃣ 작업(Task) 상태

```bash
Tasks: 134 total, 1 running, 133 sleeping, 0 stopped, 0 zombie
```

| 항목           | 설명                      |
| -------------- | ------------------------- |
| `134 total`    | 전체 프로세스 수          |
| `1 running`    | 현재 실행 중인 프로세스   |
| `133 sleeping` | 대기 중인 프로세스        |
| `0 stopped`    | 중지된 프로세스           |
| `0 zombie`     | 좀비 프로세스 (주의 요망) |

> 🧟 좀비 프로세스는 부모 프로세스가 종료 처리를 하지 않아 남은 껍데기 상태의 프로세스입니다.

---

## 3️⃣ CPU 사용률

```bash
%Cpu(s): 5.3 us, 2.0 sy, 0.0 ni, 91.7 id, 0.7 wa, 0.0 hi, 0.3 si, 0.0 st
```

| 항목                | 설명                                                |
| ------------------- | --------------------------------------------------- |
| `us` (User)         | 사용자 영역에서 실행되는 프로세스가 사용한 CPU 비율 |
| `sy` (System)       | 커널 영역에서 사용한 CPU 비율                       |
| `ni` (Nice)         | 우선순위가 변경된 프로세스가 사용한 CPU 비율        |
| `id` (Idle)         | **아무 작업도 하지 않고 대기 중인 CPU 비율**        |
| `wa` (IO Wait)      | 디스크 I/O 작업을 기다리는 시간                     |
| `hi` (Hardware IRQ) | 하드웨어 인터럽트에 사용된 시간                     |
| `si` (Software IRQ) | 소프트웨어 인터럽트에 사용된 시간                   |
| `st` (Steal)        | 가상 머신에서 다른 VM이 CPU를 가져간 시간           |

> ✅ 일반적으로 `id` 값이 높으면 시스템이 여유로운 상태입니다.

---

## 4️⃣ 메모리(Memory) 사용량

```bash
MiB Mem : 7972.2 total, 1045.7 free, 2444.6 used, 4481.8 buff/cache
```

| 항목         | 설명                                                              |
| ------------ | ----------------------------------------------------------------- |
| `total`      | 전체 물리 메모리 용량                                             |
| `free`       | 현재 아무 작업에도 사용되지 않는 메모리                           |
| `used`       | 현재 사용 중인 메모리                                             |
| `buff/cache` | 디스크 캐시, 버퍼 등으로 사용 중이지만 필요 시 회수 가능한 메모리 |

> 🧠 실질적으로 사용 가능한 메모리는 `free + buff/cache` 입니다.

---

## 5️⃣ 스왑(Swap) 메모리

```bash
MiB Swap: 2048.0 total, 2048.0 free, 0.0 used. 5003.5 avail Mem
```

| 항목         | 설명                                                               |
| ------------ | ------------------------------------------------------------------ |
| `Swap total` | 스왑 메모리 총 용량                                                |
| `Swap free`  | 남은 스왑 메모리 용량                                              |
| `Swap used`  | 현재 사용 중인 스왑 메모리                                         |
| `avail Mem`  | 애플리케이션이 사용할 수 있는 전체 메모리 (free + 일부 cache 포함) |

> ⚠️ `Swap used`가 많아지면 실제 메모리가 부족하다는 신호입니다.

---

## ✅ 정리 요약

| 항목         | 체크 포인트                                     |
| ------------ | ----------------------------------------------- |
| Load average | CPU 코어 수보다 작으면 OK                       |
| Tasks        | zombie 프로세스 있는지 확인                     |
| CPU          | `us`, `sy`가 높고 `id`가 낮으면 부하 발생 중    |
| Memory       | `free`만 보지 말고 `buff/cache`까지 합쳐서 해석 |
| Swap         | 사용량이 많다면 성능 저하 우려                  |

---

## 📌 관련 명령어 팁

- `top`: 실시간 프로세스 확인
- `htop`: GUI 기반으로 상호작용 가능 (설치 필요)
- `free -h`: 메모리 전체 사용량 간단 조회
- `vmstat`: CPU, 메모리, IO 상태 요약 보기

---

> 🧑‍💻 실시간 모니터링 외에도, 로그 분석이나 정기 리포팅을 위한 스크립트 자동화와 함께 사용하는 것이 좋습니다.
