# 🐧 리눅스 실습 - 2주차 (DevOps 로드맵 기반)

오늘은 DevOps 12주차 로드맵 중 2주차 실습으로 리눅스의 기본 디렉터리 구조와 사용자, 권한, 파일 관리 등을 실습했습니다.

---

## ✅ 1. 리눅스 주요 디렉터리 구조 학습

| 디렉터리        | 설명                                       |
| --------------- | ------------------------------------------ |
| `/`             | 루트 디렉터리. 모든 경로의 시작            |
| `/home`         | 일반 사용자 홈 디렉터리                    |
| `/root`         | 루트 계정의 홈 디렉터리                    |
| `/etc`          | 설정 파일 저장 디렉터리                    |
| `/bin`, `/sbin` | 기본 명령어가 위치한 디렉터리              |
| `/usr`          | 사용자 앱과 라이브러리                     |
| `/var`          | 로그, 캐시, 메일 등 가변 데이터            |
| `/tmp`          | 임시 파일 저장소                           |
| `/proc`, `/sys` | 가상 파일 시스템 (시스템 및 하드웨어 정보) |

```bash
cd /
ls -l # all files and directories
tree -L 1 / # tree sudo dnf install tree -y     # Rocky Linux 기준
du -sh * # 디렉터리 크기 확인
```

---

## ✅ 2. 사용자 및 권한 관리

```bash
sudo useradd devops # 사용자 생성
sudo passwd devops  # 비밀번호 설정
sudo usermod -aG wheel devops # sudo 권한 부여
```

```bash
whoami  # 현재 사용자 확인
id      # 사용자 정보 확인
chmod 755 myfile.txt
chown devops:devops myfile.txt
```

---

## ✅ 3. 파일 및 디렉터리 관리

```bash
mkdir testdir
touch testfile.txt
cp testfile.txt testdir/
mv testdir/testfile.txt testdir/newfile.txt
rm -r testdir
```

리다이렉션:

```bash
echo "hello" > out.txt  # 처음 쓰면 새로 쓰기
echo "again" >> out.txt # 이어쓰기
cat out.txt | tee copy.txt # 같이 보기
```

---

## ✅ 4. 파일 검색 및 내용 보기

```bash
cat file.txt
head -n 5 file.txt
tail -n 10 file.txt
less file.txt
grep "keyword" file.txt
find /etc -name "*.conf"
```

---

## ✅ 5. 종합 실습 예제

```bash
# 사용자 생성 및 디렉터리 생성
sudo useradd devops
sudo passwd devops
sudo mkdir /home/devops/test-practice
sudo chown devops:devops /home/devops/test-practice

# 권한 설정 및 파일 조작
sudo su - devops
cd ~/test-practice
touch log.txt
echo "Hello DevOps" > log.txt
chmod 600 log.txt
```

---

## 🏁 마무리

> "리눅스의 기본 디렉터리 구조와 사용자, 권한, 파일 관리 등을 실습했습니다. 다음 주차에는 더 심화된 내용을 다룰 예정입니다."
> "오늘의 실습은 여기까지입니다! 고생하셨습니다 👏"
