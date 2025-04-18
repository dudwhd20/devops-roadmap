# Step 2: 배열(Array)

이번 스텝에서는 배열 선언, 접근, 반복 처리, 함수 인자로 전달하는 방식까지 실습합니다.

---

## ✅ 배열 선언 방식

### 정적 선언

```bash
fruits=("apple" "banana" "cherry")
```

### 인덱스 지정 방식

```bash
numbers=()
numbers[0]=10
numbers[1]=20
numbers[2]=30
```

---

## 🔍 배열 접근

```bash
echo "첫 과일: ${fruits[0]}"
echo "모든 과일: ${fruits[@]}"
echo "과일 갯수: ${#fruits[@]}"
```

---

## 🔁 배열 반복 처리

```bash
for fruit in "${fruits[@]}"; do
  echo "과일: $fruit"
done
```

---

## 🧪 예제: 배열을 이용한 합계 계산

```bash
scores=(80 90 70 85)
sum=0

for score in "${scores[@]}"; do
  sum=$((sum + score))
done

echo "총합: $sum"
```

---

## 📥 배열을 함수에 전달 (간접 방식)

Bash 함수는 배열을 직접 인자로 받을 수는 없지만, 아래처럼 배열을 전개해서 전달할 수 있습니다.

```bash
print_all() {
  for i in "$@"; do
    echo "값: $i"
  done
}

arr=("foo" "bar" "baz")
print_all "${arr[@]}"
```

---

## 🔍 `$@`, `$*`, `$#` 차이 설명

| 표현 | 의미                                                  |
| ---- | ----------------------------------------------------- |
| `$@` | 모든 인자를 **개별 요소**로 처리 ("apple" "banana")   |
| `$*` | 모든 인자를 **하나의 문자열**로 처리 ("apple banana") |
| `$#` | 전달된 인자의 **갯수**                                |

### 예제: `$@` vs `$*` 비교

```bash
compare() {
  echo "$* 처리 결과:"
  for item in "$*"; do
    echo " - $item"
  done

  echo "$@ 처리 결과:"
  for item in "$@"; do
    echo " - $item"
  done
}

compare apple banana "fruit juice"
```

#### 출력 예시:

```
$* 처리 결과:
 - apple banana fruit juice
$@ 처리 결과:
 - apple
 - banana
 - fruit juice
```

---

✅ 다음은 Step 3: 조건 분기로 넘어갑니다.
