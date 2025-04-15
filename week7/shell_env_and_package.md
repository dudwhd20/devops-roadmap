# 7주차: 패키지 매니저 & 사용자 환경 구성

## ✅ 핵심 목표

- 패키지 매니저(yum/dnf/apt)의 차이와 사용법 이해
- 사용자 환경 설정 파일(.bashrc, .bash_profile 등)의 차이와 활용법 학습
- alias, 환경변수, 프롬프트 설정 등 실전 셸 환경 커스터마이징 실습

---

## 🧩 Step 1. 패키지 매니저 기초

### 🔧 주요 패키지 매니저

| 배포판                      | 패키지 매니저 | 설명             |
| --------------------------- | ------------- | ---------------- |
| RedHat 계열 (Rocky, CentOS) | dnf, yum, rpm | .rpm 패키지 기반 |
| Debian 계열 (Ubuntu 등)     | apt, dpkg     | .deb 패키지 기반 |

- `dnf`, `apt`: 저장소 기반, 의존성 자동 처리
- `rpm`, `dpkg`: 단일 패키지 설치, 의존성 미처리

---

## 🧩 Step 2. 패키지 설치/삭제/검색 실습

### ✅ 기본 명령어

```bash
# 설치
sudo dnf install git
sudo apt install git

# 삭제
sudo dnf remove git
sudo apt remove git

# 검색
dnf search nginx
apt search nginx

# 정보 확인
dnf info nginx
apt show nginx

# 설치 목록 확인
rpm -qa
dpkg -l
```

---

## 🧩 Step 3. 사용자 환경 설정 파일

| 파일명          | 설명                                  | 실행 시점                  |
| --------------- | ------------------------------------- | -------------------------- |
| `.bash_profile` | 로그인 셸 환경 설정                   | ssh 로그인 시 1회 실행     |
| `.bashrc`       | 반복 실행되는 bash 인터랙티브 셸 설정 | 터미널 새로 열 때마다 실행 |
| `.zshrc`        | zsh용 설정 파일                       | zsh 사용자용               |

```bash
# ~/.bash_profile에서 .bashrc 호출
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
```

---

## 🧩 Step 4. alias 및 환경변수 실습

### ✅ alias 예시

```bash
alias ll='ls -alF'
alias gs='git status'
alias rm='rm -i'
alias grep='grep --color=auto'
```

### ✅ 환경변수 예시

```bash
export PATH=$PATH:$HOME/scripts
export EDITOR=vi
export LANG=ko_KR.UTF-8
```

### 적용 방법

```bash
source ~/.bashrc
```

---

## 🧩 Step 5. 실전 `.bashrc` 구성 예시

```bash
# ~/.bashrc 예시

# 히스토리 설정
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT="%F %T "

# 환경변수
export EDITOR=vi
export PATH=$PATH:$HOME/bin:$HOME/scripts

# 컬러 설정
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# alias 설정
alias ll='ls -alF'
alias gs='git status'
alias grep='grep --color=auto'
alias rm='rm -i'
alias vi='vim'

# 프롬프트 커스터마이징
PS1='\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '

# 자동완성
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
```

---
