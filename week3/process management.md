# Linux 프로세스 관리

## 1. ps 명령어

- 전체 프로세스 보기: `ps -ef`
- 특정 프로세스 검색: `ps -ef | grep ssh`

## 2. top / htop

- `top`: 실시간 프로세스 확인
- `htop`: GUI 방식, 설치 후 사용

## 3. kill / killall

- `kill -9 PID`: 특정 프로세스 종료
- `killall name`: 이름으로 전체 종료

## 4. nice / renice

- `nice -n 10`: 낮은 우선순위로 실행
- `renice -n 5 -p PID`: 실행 중인 프로세스 우선순위 조정
