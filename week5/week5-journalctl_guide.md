# 📘 journalctl 완전 정복 가이드

`journalctl`은 systemd 로그를 관리하고 분석하기 위한 강력한 도구입니다.

---

## ✅ 기본 사용법

```bash
journalctl
```

- 시스템 전체의 로그를 출력합니다 (부팅 이후 전체 로그).
- 로그는 시간순으로 출력되며, 위/아래 방향키로 탐색 가능합니다.

---

## ✅ 특정 서비스 로그 확인

```bash
journalctl -u myapp.service
```

- `-u`: 유닛(Unit) 이름을 지정하여 해당 서비스의 로그만 필터링

---

## ✅ 실시간 로그 모니터링

```bash
journalctl -u myapp.service -f
```

- `-f`: follow 옵션으로 실시간 로그 스트리밍 (tail -f와 유사)

---

## ✅ 시간 기준 필터링

```bash
journalctl --since "2024-04-14 13:00" --until "2024-04-14 13:45"
```

- `--since`, `--until`은 날짜, 시간, 상대시간(`10 minutes ago`, `yesterday`) 등 다양한 형식을 지원합니다.

예시:

```bash
journalctl --since "10 minutes ago" -u myapp.service
```

---

## ✅ 로그 우선순위로 필터링

```bash
journalctl -p err -u myapp.service
```

| 숫자 | 레벨    | 설명                  |
| ---- | ------- | --------------------- |
| 0    | emerg   | 시스템 사용 불가 수준 |
| 1    | alert   | 즉각 조치 필요        |
| 2    | crit    | 심각한 오류           |
| 3    | err     | 일반 오류             |
| 4    | warning | 경고                  |
| 5    | notice  | 주목할 정보           |
| 6    | info    | 일반 정보             |
| 7    | debug   | 디버그 정보           |

---

## ✅ 부팅 단위로 로그 보기

```bash
journalctl --list-boots
```

```bash
journalctl -b -1 -u myapp.service
```

- `-b`: 현재 부팅에서 발생한 로그
- `-b -1`: 이전 부팅의 로그
- `-b -2`: 두 번째 이전 부팅…

---

## ✅ 기타 유용한 옵션들

```bash
journalctl -n 100
```

- 가장 최근 100개의 로그만 출력

```bash
journalctl -xe
```

- 상세 에러 로그와 context 확인 (서비스 실패 원인 분석에 유용)

---

## 🔍 디버깅 팁

서비스가 비정상적으로 종료되었을 때는 다음 명령어로 로그를 확인하세요:

```bash
sudo systemctl status myapp.service
sudo journalctl -u myapp.service -xe
```

---

## 🧪 실습 요약

```bash
# 서비스 로그 전체 보기
journalctl -u myapp.service

# 최근 로그 스트리밍
journalctl -u myapp.service -f

# 시간 조건 필터링
journalctl --since "1 hour ago" -u myapp.service

# 오류만 필터링
journalctl -p err -u myapp.service
```

---

## 📌 참고

- 로그는 기본적으로 `/run/log/journal/` 또는 `/var/log/journal/`에 저장됩니다.
- 로그 보존 기간은 `journald.conf` 파일로 설정할 수 있습니다.
