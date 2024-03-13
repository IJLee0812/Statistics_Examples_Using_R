# 여러 문장 주석 처리 -> ctrl + shift + c
# 자료구조 - 문자형 / 숫자형 / 논리형
# 벡터, 데이터프레임, 행렬, 배열, 요인, 리스트
# 변수명 = c(원하는 자료형 data) -> 벡터(자료구조) 생성
# Values 에 문자형 : chr / 숫자형 : num / 논리형 : logi
# Script 창에서는 실행돼야 할 블록들을 선택해야 실행됨.
# 그렇지 않을 경우, 커서 위치에 있는 한 문장만 실행된다.
# 콘솔창 로그 전부 제거 : ctrl + l
# 선택된 줄 실행 : ctrl + enter

# 벡터 : 변수명 = c(oncatenate)(원소들)
name = c('김함수', '박산술', '이비교', '송논리', '최검정', '유반복')
gender = c('M', 'M', 'M', 'W',  'W',  'W')
age = c(35, 27, 42, 33, 25, 47)
height = c(183, 177, 175, 167, 155, 173)
weight = c(72, 69, 78, 58, 47, 65)

# R에서 벡터를 생성할 때, 문자형과 숫자형을 동시에 입력하는 경우
# 숫자형이 문자형으로 형변환됨.
KHS = c('김함수', '남', 35, 183, 72)
print(KHS)

# 데이터프레임은 벡터들의 모임.
# data.frame(원하는 벡터 data)로 생성
mydf = data.frame(name, gender, age, height, weight)
print(mydf)

# 벡터끼리의 연산
v1 = c(1, 2, 3)
v2 = c(4, 5, 6)
print(v1 + v2)
print(v1 * v2)
print(v1 > v2) # FALSE FALSE FALSE(같은 인덱스 원소 하나당 논리비교)
print(v1 < v2) # TRUE TRUE TRUE

# 조건문
x = 1
if (x >= 3){
  print("안녕")
}

# 반복문 (for, while)
for (i in c(1, 2, 3, 4, 5)){ # for (i in 자료구조){ i가 들어간 문장 }
  print(i * 10)
}
# 1~10 까지의 벡터 == 1:10
for (i in 1:10){
  print(2*i + 3)
}

# 함수
print(round(mean(age), 3)) # 34.833
# 함수이름 = function (입력값) {
#   내용
#   ...
#   return (출력값)
# }
cal_BMI = function(weight, height){
  bmi_ratio = weight / (height / 100)**2
  return (bmi_ratio)
}
cal_BMI(177, 65)

# 패키지(함수, 데이터)
# 패키지 설치법 : ex> install.packages("readxl") -> 엑셀처리 패키지 설치
# 패키지 (설치 후) 불러오기 -> library("패키지명")
library(readxl)
# 패키지는 매번 불러와줘야 한다.

# 그래프, t검정
# -------- 그래프 - 상자수염 그림 (각 성별의 키) ---
boxplot(height~gender, mydf)
# df라는 데이터프레임에서 height라는 열을 
# gender라는 변수를 기준으로 분류해서
# 상자수염 그림을 그리라는 의미
# --------------------------------------------------
# -------- t검정 -----------------------------------
t.test(height~gender, mydf)
# df라는 데이터프레임에서 height라는 열을 
# gender라는 변수를 기준으로 분류해서
# t검정을 수행하라는 의미 (but 표본크기 < 30이라 제대로 검정되지 않음)
#---------------------------------------------------

# 로그함수
print(log(3)) # 밑 = 자연상수 e
print(log(10, base = 10)) # 상용로그 사용을 위해서는 base = 10 옵션 부여

# exponential 함수
print(exp(1)) # == e
print(exp(0)) # 1

# 삼각함수
print(sin(30))
print(cos(pi))
print(tan(pi / 4))

# 제곱근함수
print(sqrt(4))

# 벡터 원소 인덱싱
nums = c(1, 2, 3, 4, 5) 
print(nums[1])
print(nums[5]) # R은 인덱스 1부터 시작
print(nums[2:4])

# 벡터에 함수 적용
x = c(1, 2, 3, 4, 5)
print(sin(x)) # 벡터에 함수를 적용하면 모든 요소에 각각 함수가 적용됨

# ---------- 벡터에 적용하는 유용 함수 ----------
# min(), max() 함수
x = c(1, 2, 3, 4, 5)
min(x) ; max(x)

# range() 함수
x = c(-1, -2, 0, 4, 5)
range(x) # 최솟값 ~ 최댓값 출력(범위)

# length() 함수
x = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 9+1)
length(x)

# sum(), product() 함수
x = c(1, 2, 3, 4, 5)
sum(x)
product(x)

# ---------- 자료의 통계량 ----------

# sort() 함수 -> 오름/내림차순 정렬 가능
x = c(1, 5, 3, 2, 6)
sort(x) # default 오름차순
sort(x, decreasing = TRUE) # 내림차순 옵션

# mean, median 함수
score = c(94, 95, 92, 100, 98)
mean(score)
median(score)
score = c(94, 95, 92, 93, 98, 100) # 자료 짝수
median(score) # 두 값의 평균으로 정의됨
# 최빈값(Mode)
score = c(1, 1, 2, 3, 3, 3, 3, 3, 4)
tscore <- table(score) # table 함수로 score 값의 빈도 계산
names(tscore)[which(tscore == max(tscore))] # 빈도 높은 위치 찾기

# "표본"분산 구하는 var() 함수
score = c(94, 95, 92, 100, 98, 88)
var(score)
# 모분산 값 확인
deviation = score - mean(score)
print(deviation)
deviation_square = deviation ^ 2
sum(deviation_square) / length(score)
# 표본분산 구하기 (n-1)
sum(deviation_square) / (length(score) - 1)

# ---------- 정규분포 함수 ----------

# 1. 난수함수(rnorm) - random
# 난수함수는 정규분포함수의 변수에 해당하는 값을 임의로 생성해줌.
# 디폴트는 "표준정규분포"이고, 평균과 표준편차를 설정해줄 수 있음.

rnorm(5) # 평균이 0이고 표준편차가 1인 정규분포(표준정규분포)
rnorm(5, mean = 100, sd = 5) # 평균이 100이고 표준편차가 5인 정규분포

# 2. 확률밀도함수(dnorm) - density
# 확률밀도함수의 함수값을 구해줌. 확률밀도함수이기 때문에 값 자체가
# 확률을 의미하지는 않음. 디폴트 평균이 0이기 떄문에
# 최댓값은 0에서 발생한다.

dnorm(0) # 0에서의 확률밀도 값
dnorm(0, sd = 10) # 표준편차를 10배 늘린 분포의 0에서의 확률밀도 값

# 3. 누적분포함수(pnorm) - probability
# 표준정규분포에서의 넓이 = 확률을 구해주는 함수

pnorm(1) # P(Z < 1)
pnorm(1, lower.tail = FALSE) # P(Z > 1), 반대편 구해주는 옵션
 
# 4. 분위수 함수(qnorm)
# 확률이 입력변수이다. 어떤 확률(넓이)을 입력하면, 
# 그 확률에 해당하는 변수값을 찾아준다.

qnorm(0.8413447) # 0.9999998 출력 (1이라고 보면 됨.)
qnorm(0.8413447, lower.tail = FALSE) # -0.9999998 출력 (-1)

# ---------- 문자열, NA, NULL, Inf ----------

# 문자열
a = c("Hello")
b = c('R is fun.')
x = c("a", "b", 'thank you.')
# 숫자와 문자를 동시에 벡터에 입력하는 것은 불가능하다.
# 숫자가 자동으로 문자열로 전환된다.
combine = c(1, "a", 11)
print(combine)

# NA (Not Available)
# 데이터 값이 존재하지 않을 때 사용함.
a = c(98, 78, 79, NA)
print(a)

# NULL
# NA와 구분된다. NA는 데이터가 있는데 모르겠는 상황에 사용.
# NULL은 데이터를 정의하지 않고 변수만 만들어 놓을 때 사용.
x = NULL
print(x)
print(is.null(x)) # TRUE
a = c(23, NA, NULL)
print(a) # 23 NA 출력 (NULL 출력 X) 
print(is.null(a)) # FALSE

# Inf (Infinity)
# 무한대라는 의미이다. 변수에 입력이 가능하나 거의 사용하지 않음.
# 보통 잘못된 계산식의 결과에 자동으로 입력됨.
x = 1 / 0
print(x) # INF

# ---------- 진리값 ----------

print(TRUE) # TRUE
print(TRUE + 1) # 진리값과 숫자를 연산 시, TRUE = 1 / FALSE = 0
print(FALSE * 10)
print(T) ; print(F) # T -> TRUE, F -> FALSE 출력 (T, F 예약어 X.)
T = 3 ; print(T)

# ---------- 논리연산자 ----------
# &는 원소단위의 개별연산 결과를 출력
# &&는 첫 번째 원소간의 연산결과를 출력
print(TRUE & TRUE) ; print(TRUE && FALSE)
a = c(1, 0, 2, 3)
b = c(0, 1, 1, 4)
print(a & b) # FALSE FALSE TRUE TRUE
a = c(1, 2, 3, 4, 5)
print(2 < a & a < 4)

# |와 ||도 마찬가지
a = c(1, 0, 2, 3)
b = c(0, 1, 1, 4)
print(a | b) # TRUE TRUE TRUE TRUE
print(2 < a | a < 4)

a = c(1, 2, 0, 0, -1)
!a # FALSE FALSE TRUE TRUE FALSE (0만 TRUE)

# ---------- 리스트 ------------
# 벡터처럼 데이터를 담는 그릇이다. 벡터는 같은 종류의 데이터만 입력 가능
# 리스트는 여러 종류의 데이터를 입력할 수 있음
a = list("PAUL", 35)
print(a)
a = list(name = "PAUL", age = 35) # 내부에서 변수 설정 가능
# 변수 값에는 숫자, 문자열, 진리값, NULL, factor 입력 가능
print(a)
example1 = list(ex1 = 123, ex2 = "hi", ex3 = FALSE, ex4 = NULL)
print(example1)

# 스칼라형 뿐만 아니라 벡터형도 입력할 수 있음
example2 = list(ex1 = c(1, 2, 3), ex2 = c("a", "b", "c"))
print(example2)

# 리스트 안에 리스트를 넣을 수도 있음
a = list(kim = 100, park = 80)
b = list(lee = 88, song = 92)
print(a$kim) ; print(b$song)
exam_score = list(class1 = a, class2 = b)
print(exam_score) 
print(exam_score$class1) # 리스트 안의 리스트에 접근
print(exam_score$class1$kim) # 리스트 안의 리스트 안의 원소에 접근 (값 출력)

print(exam_score[1]) # 리스트 인덱싱 가능

print(exam_score["class2"]) # 리스트 명으로 직접 접근 가능

# ---------- 복소수 입력하기 ----------
a = 1 + 1i
# a = 1 + i -> 에러 발생. i를 입력할 때 1i 로 입력해줘야 함
print(a)
print((1 + 2i) * (3 + 3i)) # 복소수 간 곱셈 가능
print((1 + 2i) / (3 - 3i)) # 복소수 간 나눗셈 가능

# 벡터로도 입력할 수 있고, 숫자이기 때문에 실수와 함께 입력 가능
a = c(1, 3, 1 - 3i, 2 + 3i)
print(a)

# ---------- 자료형 분류, 확인 ----------
a = c(1, 2, 3)
mode(a) ; typeof(a) # numeric / double
# R에서는 수를 인식하는 디폴트가 double임
a = c(1L, 2L, 3L) # 따라서 정수로 입력하려면 뒤에 L을 붙여줘야 함
typeof(a)

ex1 = c("a", "b") ; typeof(ex1)
ex2 = c(TRUE, FALSE) ; typeof(ex2)
ex3 = NULL ; typeof(ex3)
ex4 = list(name = "PAUL", age = 35) ; typeof(ex4) # 'list' 출력
ex5 = c(2 + 3i, 2 - 5i) ; typeof(ex5)

# ---------- 자료형 변환 ----------
# 1. 문자열로 변환 as.character()
a = c(1, 2, 3)
b = as.character(a)
print(b)

# 2. 복소수로 변환 as.complex()
a = c("1", "13", "14")
b = as.complex(a)
print(b)

# 3. 실수로 변환 as.numeric() / as.double()
a = c(TRUE, FALSE, FALSE)
b = as.numeric(a) ; c = as.double(a)
print(b) ; print(c)

# 4. 정수로 변환 as.integer()
a = c(2 + 3i)
b = as.integer(a) # 경고 메세지 : 허수부 버려짐
print(b)

# 5. 논리값으로 변환 as.logical()
a = c(0, 1, 2)
b = as.logical(a)
print(b)

# ---------- 정의한 변수 목록 보는 법 ----------
num = c(1, 2, 3)
char = c("a", "b", "c")
.na = c(NA, NA, NA)
null = NULL

ls() # 정의한 변수 목록을 보여주는 함수
ls(all.names = TRUE) # 점(.)으로 시작하는 변수도 보여주는 옵션
ls.str() # 정의한 변수의 이름과 내용을 함께 보여주는 함수

rm(list = ls(all=TRUE)) # 정의한 변수들을 삭제하는 함수(전부 : 옵션)
ls() # character(0)  -> 정의된 변수가 없다는 의미

# ---------- summary() 함수 ----------
nums = c(1, 4, 2, 56, 6, 234, 51, 1, 23)
summary(nums)
# 1st Qu. : first quartile. 1 사분위수(왼쪽에서부터 25%에 있는 수)
# 3rd Qu. : third quartile. 3 사분위수(왼쪽에서부터 75%에 있는 수)

# ---------- 벡터 요소에 이름 부여하기 ----------
x = c(1, 2, 3, 4, 5)
names(x) = c("a", "b", "c", "d", "e")
print(x) ; print(names(x)) # names(x) -> 벡터 요소명만 출력 가능
# 순서를 이용 / 정의한 이름을 가지고 벡터 요소에 접근 가능
print(x[1]) ; print(x["c"])
y = c(1, 2)
names(y) = c("Not NA")
print(y)

# ---------- Box Plot(상자수염 그림) ----------
# 다섯 가지 정보를 담고 있는 그림
# 최댓값, 3사분위수, 2사분위수(median), 1사분위수, 최솟값
x = c(1, 2, 3, 4, 5)
boxplot(x)
# 극단치(이상점)
x = c(1, 2, 3, 4, 5, 10)
boxplot(x) 
# 최댓값이 있어야 할 자리에 속이 빈 점이 하나 찍혀있고 
# 수염도 사라짐.최댓값이라고 하기에는 나머지 자료들과 너무
# 동떨어져 있기 떄문에 잘못 찍힌 점으로 분류함.
# IQR(interquartile range) -> 3사분위수와 1사분위수 사이의 범위.
# 1사분위수보다 1.5IQR 작은 값 / 3사분위수보다 1.5IQR 큰 값은
# 극단값(이상값) 으로 분류한다.

x = c(1, 2, 3, 4, 5) ; y = c(2, 3, 4, 5, 6) ; z = c(3, 4, 5, 6, 7)
boxplot(x, y, z, col = c("red", "blue", "green"), main = "Boxplot Test", xlab = "xname", ylab = "yname", xlim = c(0, 5), ylim = c(0, 10), names = c("X", "Y", "Z"))

# ---------- 조건문 ----------
x = 3
if (x < 0){
  print("음수")
}else if (x > 0){
  print("양수")
}else{
  print("0")
}
# ifelse 문
# -> ifelse(조건, 참일때 실행 문장, 거짓일때 실행 문장)
x = 3
ifelse(x > 0, "양수", "음수")
x = c(-1, 0, 1, 2, 3)
ifelse(x > 0, "양수", "양수X") # ifelse 문은 벡터에도 사용 가능

# %% : 나머지 연산자
# %/% : 몫(정수) 연산자
cat(3 %% 2, 1239 %/% 3) # 나머지, 몫

# ---------- for문 ----------
sum = 0
for (i in 1:10){
  sum = sum + i
} ; print(sum)

# print 함수 : 하나의 숫자 또는 문자를 출력해주는 함수
# cat 함수 : 여러 숫자 또는 문자를 출력해주는 함수
cat(1, 2, 3, 4, 5)
for (i in 1:10){
  cat(i, "\n") # 개행 옵션 추가
}
cat(1, 2, 3, "hi", "\n", 4, 5, 6, "hi", "\n")

# ---------- 반복문 repeat ----------
i = 0
repeat{
  cat(i+1, "번째 repeat문 실행", "\n")
  i = i + 1
  if (i >= 10){
    print("종료") ; break;
  }
}

# ---------- 함수 ----------
# 형식 : 함수명 = function(매개변수, ...){함수 내용 (return(리턴값))}
mean = function(a){
  return(sum(a) / length(a))
}
mean(c(1, 2, 3, 4, 5))

# ---------- 산점도(scatter plot) 그리기 ----------
# plot(x축 data, y축 data)
plot(1, 2) 
plot(c(1, 2, 3), c(1.2, 1.4, 1.6))
x = c(1, 2, 3) ; y = c(2, 3, 4) ; plot(x, y)

weight = c(50, 60, 70, 80)
height = c(150, 160, 170, 180)
plot(weight, height,
     main = "height & weight", 
     xlab = "weight", 
     ylab = "height", 
     ylim = c(130, 190), 
     xlim = c(40, 90), 
     cex = 3,
     fg = "red", 
     col = "blue", 
     pch = 3)

# ---------- 행렬(Matrix) 정의 ----------
# 행렬은 하나의 벡터를 행과 열로 나누는 방식으로 정의함.
v = c(1, 2, 3, 4, 5, 6, 7, 8, 9)
matrix(v, ncol = 3) ; matrix(v, nrow = 9) # matrix(벡터, ncol/nrow)
mat = matrix(c(1, 2, 3, 4), ncol = 2) # 행렬 안에 벡터 정의하기
print(mat)

# 행렬 가로로 나열하기 ("byrow = T" option)
mat = matrix(c(1, 2, 3, 4), ncol = 2, byrow = T)
print(mat)

# 행렬의 행/열에 이름 붙이기
# -> dimnames 옵션 설정 필요
mat = matrix(c(1, 2, 3, 4), ncol = 2, byrow = T,
             dimnames = list(c("행1", "행2"), c("열1", "열2")))
print(mat)

# 행렬 내부 데이터에 접근하기
mat = matrix(c(1, 2, 3, 4, 5, 6), ncol = 2)
print(mat)
print(mat[1, 1]) # mat[행, 열]
print(mat[3, ])
print(mat[ , 2]) # vector 형태로 가로로만 출력됨
print(mat[c(1, 2), ]) # 여러 행/열 출력하고 싶을 때 벡터 활용
print(mat[c(1, 3), 2]) # 1행과 3행을 불러오는데, 2열만 출력하는 경우

# ---------- 행렬의 연산 ----------
# 1. 행렬과 스칼라의 곱셈
mat = matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), ncol = 3)
print(3 * mat) # 행렬 각 원소에 스칼라 값 3 곱해진 행렬 출력

# 2. 행렬의 덧셈 : 같은 크기의 행렬끼리만 가능
mat1 = matrix(c(1, 2, 3, 4), ncol = 2, byrow = T)
mat2 = matrix(c(3, 4, 5, 6), nrow = 2, byrow = T)
print(mat1 + mat2)

# 3. 행렬의 곱셈 : %*% 기호 사용함.
mat1 = matrix(c(1, 2, 3, 4), ncol = 2, byrow = T)
mat2 = matrix(c(3, 4, 5, 6), nrow = 2, byrow = T)
print(mat1 %*% mat2)

# 4. "원소 간" 의 곱셈, 나눗셈
mat1 = matrix(c(1, 2, 3, 4), ncol = 2, byrow = T)
mat2 = matrix(c(3, 4, 5, 6), nrow = 2, byrow = T)
print(mat1 * mat2) # 원소끼리 곱해짐
print(mat2 / mat1) # 원소끼리 나눠짐

# 5. 행렬 원소 간의 거듭제곱
# 두 행렬에 연산자 ^ 를 사용하면 앞 행렬의 원소를
# 뒤 행렬의 원소로 거듭제곱함.
mat1 = matrix(c(2, 2, 2, 2), ncol = 1)
mat2 = matrix(c(1, 2, 3, 4), nrow = 4)
print(mat1 ^ mat2) # 2 4 8 16 출력

# ---------- 역행렬, 전치행렬 ----------
# 역행렬은 solve 함수를 이용하여 구함, 정방행렬에서만 정의 가능
A = matrix(c(1, 2, 3, 4), ncol = 2)
print(A)
B = solve(A)
print(B)
print(A %*% B) # 단위행렬이 나오는지 확인

# 전치행렬은 t 함수를 이용해서 구함.
A = matrix(c(1, 2, 3, 4), ncol = 2)
A_t = t(A)
print(A_t)
A = matrix(c(1, 2, 3, 4), ncol = 4)
A_t = t(A)
print(A_t)

# ---------- 행렬식, 고유값, 고유벡터 ----------
# 행렬식은 det 함수를 이용해서 구함, 정방행렬일 경우에만 구할 수 있음.
A = matrix(c(1, 2, 3, 4), ncol = 2)
print(det(A))

# 고유값과 고유벡터(PCA에서 활용)를 구할 때는 eigen 함수를 사용.
A = matrix(c(1, 2, 3, 4), ncol = 2)
print(eigen(A))

# ---------- 행렬의 행/열에 이름 붙이기 ----------
# 행렬 함수 안에 이름을 정의하는 방법은 dimnames 옵션에 리스트로 추가하면 됨.
# 이미 정의한 행렬에 이름을 붙이는 방법임.
A = matrix(c(1, 2, 3, 4, 5, 6), ncol = 2)

# 행의 이름을 붙여주는 rownames 함수 사용
rownames(A) = c("1행", "2행", "3행")
# 열의 이름을 붙여주는 colnames 함수 사용
colnames(A) = c("1열", "2열")
# 확인
print(A)

# ---------- 행렬의 결합 ----------
# 두 개 이상의 행렬을 결합하는 함수 제공
# 열 방향으로 결합하는 cbind, 행 방향으로 결합하는 rbind 존재

# cbind
a = matrix(c(1, 2, 3), ncol = 1)
b = matrix(c(4, 5, 6), ncol = 1)
c = matrix(c(7, 8, 9), ncol = 1)
cbindres = cbind(a, b, c)
print(cbindres) 

# rbind
a = matrix(c(1, 2, 3), nrow = 1)
b = matrix(c(4, 5, 6), nrow = 1)
c = matrix(c(7, 8, 9), nrow = 1)
rbindres = rbind(a, b, c)
print(rbindres)
print(rbindres == t(cbindres))

# ---------- 배열 ----------
# 벡터 : 1차원 / 행렬 : 2차원 / 배열 : n차원

AB = array(c(1, 2, 3, 4, 5, 6, 7, 8), c(2, 2, 2)) # 3차원 배열 선언
print(AB)

BC = array(1:16, c(2, 2, 2, 2)) # 4차원 배열 선언
print(BC)

# 데이터에 접근_3차원
AB = array(1:8, c(2, 2, 2))
print(AB[1, 1, 1]) # 1
print(AB[1, 2, 1]) # 3
print(AB[,, 1]) # 첫 번째 2차원 행렬 (1, 2, 3, 4)
print(AB[, 1, 2]) # 두 번째 2차원 행렬 중 1열 (5, 6)

# 데이터에 접근_4차원
BC = array(1:16, dim = c(2, 2, 2, 2)) # 2행, 2열, 2층, 2 평행우주
print(BC[1, 1, 1, 1]) # 1
print(BC[1, 1, 1, 2]) # 9
print(BC[,, 1, 1]) # 1 평행우주의 1층 (행렬 1, 2, 3, 4)

# ---------- 상자그림의 이해 ----------
# 내부구조에 대한 이해
a = c(1, 2, 3)
b = c(1, 2, 3, 4, 5)
c = c(1, 2, 3, 4, 5, 6, 7, 8)
BP1 = boxplot(a, b, c, names = c("A", "B", "C"))

print(BP1) # $ 표시 -> 리스트라는 의미.
# stats : 각 변수의 최솟값, 1사분위수, 2사분위수, 3사분위수, 최댓값 저장된 행렬
# n : 각 변수의 원소의 개수
# conf : 중앙값의 95% 신뢰구간 ( median +- 1.58 x IQR / n^(1/2) )

print(BP1$stats[,1])
print(BP1$n)
print(BP1$names)

# 상자그림에 관측수, 표준편차 넣기
a = c(1, 2, 3)
b = c(1, 2, 3, 4, 5)
c = c(1, 2, 3, 4, 5, 6, 7, 8)
BP1 = boxplot(a, b, c, ylim = c(0, 10), names = c("A", "B", "C"))

# 관측 수 입력 : text 함수 사용
# text(x좌표, y좌표, 텍스트)
text(1:3, BP1$stats[5,]+1, paste("n =",BP1$n))
# 표준편차 입력
SD = c(sd(a), sd(b), sd(c))
SD = round(SD, 2)
print(SD)
text(1:3, BP1$stats[5,] + 0.5, paste("SD : ", SD))

# ---------- 모집단에서 표본 추출하기 (sample 함수) ----------
# sample(x, n) : x라는 벡터에서 n개의 표본을 순서가 있게 뽑는 함수
# x를 입력하지 않으면 x에 1:n이 자동으로 입력됨

sample(1:10, 3) # default : 중복 허용 X
sample(10, replace = TRUE) # 1:10, 중복을 허용하여 10개 추출

# sample(x, n, prob = c(...))
# : x라는 벡터에서 중복을 허용하여 n개의 표본을 순서가 있게 뽑음
#   각 변수를 뽑는 확률(0 ~ 1)을 지정해줄 수 있음
sample(1:4, 2, replace = TRUE, prob = c(1, 0.5, 0, 0))

x = 1:10
sample(x[x>3], 5, replace = TRUE) # 3보다 큰 표본만 추출
set.seed(3)

# set.seed(n) : seed 값 지정하면 매번 같은 값 추출 가능

# sample(letters, n) : 알파벳 중 n개의 표본을 순서 있게 추출
sample(letters, 5)

# ---------- 등차수열 생성함수 (seq 함수) ----------
# seq(시작, 끝, 간격/길이)
# 간격/길이를 입력해 주지 않으면 default 값 1이 입력됨
seq(from = 1, to = 10)
seq(1, 10) # from, to 생략 가능

seq(from = 1, to = 10, by = 2)
seq(1, 10, 2) # by 또한 생략 가능

seq(from = 1, to = 99, length = 3)
seq(1, 10, length = 3) # from, to를 생략할 수 있지만,
# length를 생략할 경우 by로 인식되기 때문에 length는 생략 불가

# ---------- 복제함수 (rep) ----------
# replicate
# rep(복제하기 원하는 스칼라 혹은 벡터, 복제 횟수와 방식)
rep(2, times = 5)
rep(2, 5) # times 옵션 생략 가능
rep(c(1, 2, 3), 5)

rep(c(1, 2, 3), each = 5) # 원소단위로 각각 복제, each는 생략 불가

# ---------- 중복된 값 처리하는 함수 ----------
# unique 함수 : 중복된 항을 하나만 남기고 제거해주는 함수
x = c(1, 1, 2, 2, 2, 3, 4, 5)
print(unique(x))
x = c('a', 'a', 'a', 'b', 'c')
print(unique(x))

# duplicated 함수 : 중복된 항에는 TRUE, 처음 등장하는 항에는 FALSE 반환하는 함수
x = c(1, 1, 2, 2, 2, 3, 4, 5)
print(duplicated(x))

# ---------- rank 함수 ----------
# 각 원소가 크기 순서로 몇 위인지 반환. 가장 작은 값이 1위
x = c(54, 3, 234, 12, 33)
print(rank(x))

# 같은 값이 있으면 평균 순위로 설정해줌(default=average)
x = c(1, 2, 3, 3, 4, 5, 6)
print(rank(x, ties.method = c("average")))
print(rank(x, ties.method = c("first")))

# NA(결측치)를 포함할 때
x = c(21, 11, 23, 15, 29, NA, 24, 13)
print(rank(x)) # 기본값 na.last = TRUE (NA를 마지막 순위로 간주)
print(rank(x, na.last = FALSE)) # NA를 첫번째 순위로 간주
print(rank(x, na.last = "keep")) # NA를 원래의 위치로 반환
print(rank(x, na.last = NA)) # NA를 제외시킴

# ---------- 히스토그램 그리기 & 꾸미기 ----------
ht = sample(155:190, 50, replace = TRUE) # replace = TRUE는 복원추출이라는 뜻
print(ht)
HT1 = hist(ht) # hist 함수로 히스토그램 그릴 수 있음

# 계급 구간 변경_breaks 옵션
HT1 = hist(ht, breaks = seq(155, 190, 2))

# y축을 상대도수로 변경 : y축 기본값은 각 계급의 '도수'임.
# 이를 상대도수(Density)로 변경할 수 있음. freq = FALSE로 설정해주면 됨
HT1 = hist(ht, breaks = seq(155, 190, 2), freq = FALSE)

# 꾸미기
ht = sample(160:190, 50, replace = TRUE)
HT1 = hist(ht, breaks = seq(160, 190, 2), 
           main = "Height_Histogram",
           xlab = "Height",
           ylab = "Frequency",
           col = c("blue", "orange", "cyan"), # 계급 수 > 색 수일 때 반복 적용됨
           fg = "red")
HT2 = hist(ht, breaks = seq(160, 190, 2), 
           main = "Height_Histogram",
           xlab = "Height",
           ylab = "Frequency",
           col = rainbow(15), # 괄호 안에 입력된 숫자만큼의 색이 자동으로 지정됨
           fg = "red")

# ---------- 히스토그램 내부 구조 ----------
ht = sample(160:190, 50, replace = TRUE)
HT1 = hist(ht)
print(HT1) # 히스토그램 내부 구조 확인
# break : 계급구간(초과 ~ 이하), 시작하는 값은 예외
# counts : 도수
# density : 상대도수
# mids : 계급 중앙값
# xname : x축 이름
# equidist : 계급구간의 길이가 균일한지의 여부

HT1 = hist(ht, ylim = c(0, 16))
text(HT1$mids, HT1$counts+1, HT1$counts)
HT1 = hist(ht)
text(HT1$mids, HT1$counts, HT1$counts, adj = c(0.5, 0.5))
# adj(adjustment) 옵션을 이용하면 ylim 없이 글자가 잘리는
# 문제를 해결할 수 있음. x, y축 옵션 값을 둘다 입력할 수 있다.
# 0.5를 기준으로 0.5보다 크면 x는 좌측, y는 하측으로 이동한다.

# ---------- 분위수 구하는 법(quantile) ----------
# quantile : 분위수. 전체 자료를 특정 개수로 나눌 때
# 그 기준이 되는 수. 
# 2-quantiles = median / 4-quantiles = quartiles
# quantile(x, probs = seq(0, 1, 0.25), type = 7) => 디폴트 옵션

a = c(24, 28, 37, 43, 46, 47, 59, 67, 75, 77)
quantile(a); # 디폴트 옵션 : 사분위수 계산, 타입 7번 선택됨
quantile(a, probs = seq(0, 1, length = 7), type = 4)
# 6분위수(length는 6 '+ 1' = 7) 계산, 타입 4번 선택됨

# ---------- Q-Q plot 그리는 방법(qqnorm) ----------
# Quantile-Quantile plot의 약어.
# 분위수들을 그래프로 그림, 좌표평면에 있는 두개의 축에 서로 다른
# 두 데이터의 분위수를 각각 그려서 서로 비교함
# 넓은 의미의 Q-Q plot : 임의의 두 데이터 분포를 비교함
# 좁은 의미의 Q-Q plot : "정규성 검정"의 한 방법
# qqnorm 함수 사용. 분위수 계산 포함됨. type 9의 계산방법 사용
SP = sample(1:1000, 50)
qqnorm(SP)
qqline(SP) # 데이터들이 라인 위에 있을수록 만든 샘플들이
# 정규분포를 잘 따르고 있는 것을 의미

SP_normal = rnorm(50) # 표준정규분포에서 표본 임의추출(rnorm)
print(SP_normal)
qqnorm(SP_normal)
qqline(SP_normal)

# --------- 화면분할, 야러 그래프 한 화면에 그리기 ---------
# par 함수 : 한 화면에 여러 그래프 넣을 수 있음
# par(mfrow = c(x축 방향으로의 분할 수, y축 방향으로의 분할 수))
par(mfrow = c(2, 2))
ht = sample(160:190, 50, replace = T)
HT1 = hist(ht)
HT2 = hist(ht, breaks = seq(160, 190, 2))
HT3 = hist(ht, breaks = seq(160, 190, 2), freq = F)
HT4 = hist(ht, breaks = seq(160, 190, 2), freq = F, col = c("blue", "red", "green"))

# ---------- 중심극한정리 시뮬레이션 ----------
population = c(1:10, 40:50, 90:100) # 정규분포를 전혀 따르지 않는 모집단 정의
qqnorm(population)
qqline(population)
par(mfrow = c(3, 2)) # 화면 6개로 분할

Sample_Mean = numeric() # n = 1
for (i in 1:3000) Sample_Mean[i] = mean(sample(population, 1, replace = TRUE))
hist(Sample_Mean, freq = F, main = "n = 1", xlab = "Sample_Mean (n = 1)")
lines(density(Sample_Mean))

Sample_Mean = numeric() # n = 5
for (i in 1:3000) Sample_Mean[i] = mean(sample(population, 5, replace = TRUE))
hist(Sample_Mean, freq = F, main = "n = 5", xlab = "Sample_Mean (n = 5)")
lines(density(Sample_Mean))

Sample_Mean = numeric() # n = 30
for (i in 1:3000) Sample_Mean[i] = mean(sample(population, 30, replace = TRUE))
hist(Sample_Mean, freq = F, main = "n = 30", xlab = "Sample_Mean (n = 30)")
lines(density(Sample_Mean))

Sample_Mean = numeric() # n = 50
for (i in 1:3000) Sample_Mean[i] = mean(sample(population, 50, replace = TRUE))
hist(Sample_Mean, freq = F, main = "n = 50", xlab = "Sample_Mean (n = 50)")
lines(density(Sample_Mean))

Sample_Mean = numeric() # n = 100
for (i in 1:3000) Sample_Mean[i] = mean(sample(population, 100, replace = TRUE))
hist(Sample_Mean, freq = F, main = "n = 100", xlab = "Sample_Mean (n = 100)")
lines(density(Sample_Mean))

# 작업폴더 보기/설정하기
getwd() # 작업 폴더 경로 확인
# setwd("/Users/ikjoon/Codes/R") -> 작업 폴더 경로 설정(\ 아니고 /)
dir() # 작업폴더 내 들어있는 파일 확인 가능

# ---------- 함수를 파일(.R)로 저장 및 사용 ----------
# 예시 > my_mean 함수 사용 (my_mean.R)
# 작업 폴더를 함수가 있는 폴더로 설정해야 저장된 함수를 사용할 수 있음
# 함수를 사용하려면 먼저 source 함수를 이용하여 함수 실행해줘야 함
source("my_mean.R")
source("my_mean.R", echo = T) # echo 옵션 : 함수 내용 출력 가능
a = c(1, 2, 3, 4, 5) ; my_mean(a) # 3 출력됨.

# ---------- 1표본 Z검정 함수 만들기 ----------
source("my_z_test.R", echo = T)
my_z_test(68.5, 100, 70, 5)
# 모평균 : 70, 모표준편차 : 5, 표본평균 : 68.5, 표본의 크기 : 100
# p value is 0.001349898

# ---------- 23.09.14(목) 실습 ----------
# 예제 : trt2 제외한 데이터 aa 변수에 재저장
aa = PlantGrowth
dim(aa)
# view(aa)
aa_ = subset(aa, subset = (aa$group != "trt2"))
aa = aa_
print(aa)
# 동일
aa = PlantGrowth
aa[aa$group != "trt2", ]
dim(aa)

aa = PlantGrowth
aa_ = aa[(aa$group != "trt2") | (aa$group == "trt2"), ]
View(aa_)

# ---------- 23.09.20(수) 실습 ----------
ex_data = read.table("1_EMR data_sex.txt", header = TRUE, sep = "\t") 
# header = TRUE : 원시 데이터의 1행이 변수명으로 지정됨
# sep 옵션 : 원시 데이터의 데이터 구분자에 따라 옵션 설정, 설정 안할 시 오류 발생
View(ex_data)

# ---------- 23.09.21(목) 실습 ----------
ex_data = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8") # 옵션 지정 안 하면, 오류 발생.
View(ex_data)
dim(ex_data)
head(ex_data) # 데이터의 규모가 너무 큰 경우에 데이터의 앞부분을
# 확인하고 싶을 때 사용하는 함수. 
# head(Data, n = 10) -> 출력하고 싶은 개수 지정 가능

hist(ex_data$HT, breaks = seq(135, 200, by=1))
# breaks 옵션 : 계급구간 변경 옵션. seq함수를 이용하여 구간 전체를 정의하는 것이 편리함.

str(ex_data) # 해당 데이터프레임의 구조를 보여주는 함수(structure)
length(ex_data) # DataFrame의 길이 출력하는 함수

a = PlantGrowth
head(a)
tail(a, n = 10)
summary(a) # Categorical Variable에 대해서는 각 범주의 사이즈 출력

c = ex_data[, c("F_BR", "HT")]
View(c)
d = c[c$F_BR == 1, ]
View(d)

# 기술통계량 관련 라이브러리
install.packages("descr")
library(descr) 
freq(c$F_BR) # 빈도수 구해주는 함수. 1(아침식사 0)~8(아침식사 매일)의 빈도수, 퍼센테이지

mean(c$HT) ; sd(c$HT) # 결측치 때문에 NA 출력됨.
summary(c$HT) # continuous variable일 때 매우 자주 활용됨.
# 기술통계량 및 결측치 개수 보여줌.
is.na(c$HT) # 결측치 존재 시, TRUE
sum(c$HT, na.rm = T) # na.rm = T : NA 값 제외

# ---------- 23.09.27(수) 실습 ----------
ex_data = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8") # 옵션 지정 안 하면, 오류 발생.
dim(ex_data)

b1 = ex_data[, c("F_BR", "HT")]
View(b1)
is.na(b1)
sum(is.na(b1)) # 결측치 개수 세기
dim(b1)

b1_naremoved = na.omit(b1) # 결측치 제거 함수, 결측값 제거한 객체 반환
View(b1_naremoved)
sum(is.na(b1_naremoved)) # 0 출력(결측치 모두 제거)
dim(b1_naremoved) # dim 함수로도 파악 가능

freq(b1_naremoved$F_BR) 
mean(b1_naremoved$HT) ; sd(b1_naremoved$HT)
summary(b1_naremoved$HT)

# Method 1
everyRice = b1_naremoved[b1_naremoved$F_BR == 8, ] ; dim(everyRice)
noRice = b1_naremoved[b1_naremoved$F_BR != 8, ] ; dim(noRice)
# 1 <= ~~~$F_BR & ~~~$F_BR <= 7 동치
summary(everyRice$HT) ; sd(everyRice$HT)
summary(noRice$HT) ; sd(noRice$HT)

# Method 2
b1_naremoved$group = ifelse(b1_naremoved$F_BR == 8, 0, 1)
# ifelse(조건, True일 때 리턴할 값, False일 때 리턴할 값)
# Dataframe에 $를 붙이고 추가하길 원하는 column(파생변수명)
# 입력 시, 없는 column의 경우 생성이 됨. 있는 변수의 경우 update.
View(b1_naremoved) ; sum(is.na(b1_naremoved))

# aggregate() 함수 : 그룹별로 통계 적용하기
print(aggregate(HT ~ group, data = b1_naremoved, mean))
print(aggregate(HT ~ group, data = b1_naremoved, sd))

# ---------- 23.10.05(목) 실습 ----------
aa = PlantGrowth
View(aa)
aa1 = aa[aa$group != "trt2", ]
View(aa1)
hist(aa1$weight)
qqnorm(aa1$weight) ; qqline(aa1$weight) # shapiro test 맹목적 수용 X. Q-Q plot 및 히스토그램 그려서 정규성 테스트
shapiro.test(aa1$weight) 

ex_data = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8") # 옵션 지정 안 하면, 오류 발생.
b1 = ex_data[, c("F_BR", "HT")]
b1_naremoved = na.omit(b1) # 결측치 제거 함수, 결측값 제거한 객체 반환
View(b1_naremoved)
everyRice = b1_naremoved[b1_naremoved$F_BR == 8, ] ; dim(everyRice)
noRice = b1_naremoved[b1_naremoved$F_BR != 8, ] ; dim(noRice)
shapiro.test(everyRice$HT) ; shapiro.test(noRice$HT) # R은 데이터 개수가 5000개 이상일 경우 shapiro.test 불가능

var.test(weight ~ group, data = aa1, conf.level = 0.95) # PlantGrowth control / treatment1 분산분석
# 분산분석. control / treatment1
# ~ 왼쪽 : X (group) , ~ 오른쪽 : Y(weight)
# group(독립)이 weight(종속)에 영향을 줌.
# conf.level = 0.95. 0.05 = 5%의 오류 허용하겠다는 뜻.
# p-value = 0.3719 > 0.05이므로, "귀무가설을 기각할 수 없음." (두 분산은 같다는 뜻)
b1_naremoved$group = ifelse(b1_naremoved$F_BR == 8, 1, 0) # Method 2 (1, 0으로 순서 변경함)
var.test(HT ~ group, data = b1_naremoved, conf.level = 0.95) # b1_naremoved group 0(매일 식사) / group 1(매일 식사 X) 분산분석
# p-value = 0.00291 < 0.05이므로, "귀무가설 기각." (두 분산은 다르다는 뜻)
t.test(HT ~ group, data = b1_naremoved, var.equal = FALSE, conf.level = 0.95)
# 최종 p-value = 1.615e-09 < 0.05이므로, 대립가설 채택.(매일 식사하는 사람들의 키가 큼)

# 실습(가설 : 카페인 섭취자와 카페인 미섭취자의 몸무게는 차이가 있을 것이다.)
ex_data = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8") # 옵션 지정 안 하면, 오류 발생.
b1 = ex_data[, c("F_CAFF_A", "WT")]
b1_naremoved = na.omit(b1)
dim(b1_naremoved) 
yesCaff = b1_naremoved[b1_naremoved$F_CAFF_A != 1, ] ; dim(yesCaff)
summary(yesCaff$WT) ; sd(yesCaff$WT)
noCaff = b1_naremoved[b1_naremoved$F_CAFF_A == 1, ] ; dim(noCaff)
summary(noCaff$WT) ; sd(noCaff$WT)

qqnorm(yesCaff$WT) ; qqline(yesCaff$WT)
qqnorm(noCaff$WT) ; qqline(noCaff$WT)
b1_naremoved$group = ifelse(b1_naremoved$F_CAFF_A == 1, 1, 0)
View(b1_naremoved)
var.test(WT ~ group, data = b1_naremoved, conf.level = 0.95)
t.test(WT ~ group, data = b1_naremoved, var.equal = FALSE, conf.level = 0.95)
# 대립가설 채택 (카페인 섭취자, 카페인 미섭취자의 몸무게는 차이가 있다.)

# ---------- 23.10.12(목) 실습 ----------
aa = PlantGrowth
aa1 = aa[aa$group == "trt1", ] ; dim(aa1) 
aa2 = aa[aa$group == "trt2", ] ; dim(aa2) 
aa3 = aa[aa$group == "ctrl", ] ; dim(aa3)

# install.packages("descr") -> freq() 사용 ; library("descr")
freq(aa$group == "trt1") ; freq(aa$group == "trt2") ; freq(aa$group == "ctrl")
summary(aa)
freq(aa$group)

summary(aa$weight)
boxplot(aa$weight) # 상자수염 그림 -> Quartile로 이상치(Outlier) 점 찍혀있는지 점검.
# 이상치 있으면 삭제 처리 해줘야함.
hist(aa$weight)

# Step 1
qqnorm(aa$weight) ; qqline(aa$weight) # 정규성 확인하기        
shapiro.test(aa$weight) # 귀무가설 기각 불가(각 그룹은 정규분포를 따름)
# aggregate 함수 : 그룹별 통계 적용
print(aggregate(weight ~ group, data = aa, mean))                            
print(aggregate(weight ~ group, data = aa, sd))
# Confidence interval : +- 표준편차 하는 이유는 95% 양측 신뢰구간이기 때문

# Step 2
bartlett.test(weight ~ group, data = aa) # homogeneity = equality.
# p-value = 0.2371 > 0.05 이므로 귀무가설을 기각할 수 없음. 따라서 분산 동일

# Step 3
aov(weight ~ group, data = aa) # ANOVA 분석 수행. 
output = aov(weight ~ group, data = aa) # aov 함수 출력 결과 내 p-value 포함돼있지 않으므로 output에 담음
summary(output) # p-value(Pr(>F)) = 0.0159 < 0.05이므로 귀무가설 기각. 대립가설 채택.
# 결론 : 세 집단의 모평균은 동일하지 않다.

# 다중비교 (Multiple comparison)_Tukey Procedure
TukeyHSD(output) # 3가지 Combination 나타남. "p adj" : 각 combination의 p-value
# 해석 : trt2 - trt1간의 평균은 차이가 있음. trt2 apply mean value big  
plot(TukeyHSD(output))

# [분석2] 분산분석.pdf dummy table I. (ANOVA)
# 그룹 : 일주일간 아침식사 0일 / 한 번 이상 / 7일 식사하는 세 그룹으로 분류.
# 입증하고 싶은 가설 : H_1 = 아침식사와 키 평균 차이가 있다. <-> H_0 : 아침식사와 키 평균 차이가 없다.(모두 동일)

ex_data = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8") # 옵션 지정 안 하면, 오류 발생.
b1 = ex_data[, c("F_BR", "HT")]
b1_naremoved = na.omit(b1) # 결측치 제거 함수, 결측값 제거한 객체 반환
everyRice = b1_naremoved[b1_naremoved$F_BR == 8, ] ; dim(everyRice)
noRice = b1_naremoved[b1_naremoved$F_BR == 1, ] ; dim(noRice)
oneRice = b1_naremoved[b1_naremoved$F_BR >= 2 & b1_naremoved$F_BR <= 7, ] ; dim(oneRice)
summary(everyRice$HT) ; summary(noRice$HT) ; summary(oneRice$HT)
sd(everyRice$HT) ; sd(noRice$HT) ; sd(oneRice$HT)
qqnorm(everyRice$HT) ; qqline(everyRice$HT)
qqnorm(noRice$HT) ; qqline(noRice$HT)
qqnorm(oneRice$HT) ; qqline(oneRice$HT)
View(b1_naremoved)
b1_naremoved$group = ifelse(b1_naremoved$F_BR == 1, 0, ifelse(b1_naremoved$F_BR == 8, 2, 1))
View(b1_naremoved)
bartlett.test(HT ~ group, data = b1_naremoved)
output = aov(HT ~ group, data = b1_naremoved)
summary(output)

oneway.test(HT ~ group, data = b1_naremoved)

# ---------- 23.10.14(토) 복습 ----------
ex_data = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8")
b1 = ex_data[, c("F_BR", "HT")]
View(b1)
is.na(b1)
sum(is.na(b1))
b1_naremoved = na.omit(b1)
sum(is.na(b1_naremoved))
View(b1_naremoved)
summary(b1_naremoved$HT)

# Method 1.
noRice = b1_naremoved[b1_naremoved$F_BR == 8, ] ; dim(noRice)
summary(noRice$HT) ; sd(noRice$HT)
everyRice = b1_naremoved[b1_naremoved$F_BR != 8, ] ; dim(everyRice)
summary(everyRice$HT) ; sd(everyRice$HT)

# Method 2.
b1_naremoved$group = ifelse(b1_naremoved$F_BR == 8, 1, 0)
View(b1_naremoved)
print(aggregate(HT ~ group, data = b1_naremoved, mean))
print(aggregate(HT ~ group, data = b1_naremoved, sd))

# 정규성 검정 방법
# 1. qqnorm() 이용
qqnorm(noRice$HT) ; qqline(noRice$HT)
qqnorm(everyRice$HT) ; qqline(everyRice$HT)

# 2. hist() 이용
hist(noRice$HT) # 정규분포와 근사.
hist(everyRice$HT) # 상동.

# 3. shapiro.test() 이용
# H_0 : 정규분포를 따름.
shapiro.test(noRice$HT) ; shapiro.test(everyRice$HT) # n > 5,000이면 Shapiro-Wilk Normality Test 불가.

# Perform F test for the quality of two variances.
var.test(HT ~ group, data = b1_naremoved, conf.level = 0.95)
# 결과 : p-value가 0.00291 < 0.05이므로 귀무가설(두 분산 동일)을 기각. 대립가설 채택.(두 분산 다름)

# Perform t test (Assuming unequal variances)
t.test(HT ~ group, data = b1_naremoved, var.equal = FALSE, conf.level = 0.95)
# 결과 : p-value가 1.615e-09 < 0.05이므로 귀무가설(두 평균 동일)을 기각. 대립가설 채택.(두 평균 다름)
# 해석 : 매일 아침식사를 하는 학생들과 매일 식사하지는 않는 학생들의 키는 차이가 있다.

# ----------23.10.15(일) 복습_ 중학교 고등학교 Dummy Table 채우기----------
View(ex_data)
rawData = ex_data[,c("AGE", "HT")]
View(rawData) 
head(rawData, n = 50) # head 함수 : 많은 데이터를 사용자가 설정한 처음에서부터 n개까지 볼 수 있음.
students = na.omit(rawData)
sum(is.na(students))
View(students)
summary(students$AGE)
midSchool = students[students$AGE >= 14 & students$AGE <= 16, ] ; dim(midSchool)
summary(midSchool$HT) ; sd(midSchool$HT)
freq(midSchool$AGE)
highSchool = students[students$AGE >= 17 & students$AGE <= 19, ] ; dim(highSchool)
summary(highSchool$HT) ; sd(highSchool$HT)
freq(highSchool$AGE)

# 0. 상자수염 그림으로 이상치 확인하기
boxplot(midSchool$HT)
boxplot(highSchool$HT)

# 1. 정규성 검정.
qqnorm(midSchool$HT) ; qqline(midSchool$HT)
qqnorm(highSchool$HT) ; qqline(highSchool$HT)
hist(midSchool$HT)
hist(highSchool$HT)

# 2. var.test
grouping = rbind(midSchool, highSchool)
# grouping = rawData[rawData$AGE>= 16 & rawData$AGE <= 19, ]
View(grouping) ; dim(grouping)
grouping$group = ifelse(grouping$AGE <= 16, 0, 1)
View(grouping)
var.test(HT ~ group, data = grouping, conf.level = 0.95)
# 두 분산 다름.

# 3. t.test
t.test(HT ~ group, data = grouping, var.equal = FALSE, conf.level = 0.95)
# 두 평균 다름. 따라서 중학교 / 고등학교의 키 평균은 차이가 있음.

aa = subset(grouping, subset = grouping$AGE != 16)
View(aa)

# ---------- 23.10.18(수) ----------

ex_data = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8") # 옵션 지정 안 하면, 오류 발생.
b1 = ex_data[, c("F_BR", "HT")]
b1_naremoved = na.omit(b1) # 결측치 제거 함수, 결측값 제거한 객체 반환

everyRice = b1_naremoved[b1_naremoved$F_BR == 8, ] ; dim(everyRice)
noRice = b1_naremoved[b1_naremoved$F_BR == 1, ] ; dim(noRice)
oneRice = b1_naremoved[b1_naremoved$F_BR >= 2 & b1_naremoved$F_BR <= 7, ] ; dim(oneRice)

summary(everyRice$HT) ; summary(noRice$HT) ; summary(oneRice$HT)
sd(everyRice$HT) ; sd(noRice$HT) ; sd(oneRice$HT)

qqnorm(everyRice$HT) ; qqline(everyRice$HT)
qqnorm(noRice$HT) ; qqline(noRice$HT)
qqnorm(oneRice$HT) ; qqline(oneRice$HT)

b1_naremoved$group = ifelse(b1_naremoved$F_BR == 1, 0, ifelse(b1_naremoved$F_BR == 8, 2, 1))
View(b1_naremoved)

bartlett.test(HT ~ group, data = b1_naremoved) # 분산을 비교할 때는 factor()를 사용할 필요가 없음.
bartlett.test(HT ~ factor(group), data = b1_naremoved) # 해당 코드도 위와 동일한 결과 출력됨.
# 분산을 비교하는 test, 결과 : 세개의 분산은 서로 같지 않음.

# (Oneway) ANOVA Test
help(aov) # aov는 분산이 같지 않을 때의 옵션이 없음.
output = aov(HT ~ group, data = b1_naremoved) # 오류. df가 1이 나오면 안 됨. group은 continuous variable로 인식됨.
summary(output) # df = 1
output = aov(HT ~ factor(group), data = b1_naremoved) # "group은 continuous variable로 인식"되므로, 
# group을 factor()함수를 이용하여 categorical variable로 정상작동하게 함. df가 2로 정상적으로 나옴.
summary(output) # df = 2, 위의 p-value와 다른 값 산출됨.
# 평균을 비교하는 test

help(oneway.test)
oneway.test(HT ~ group, data = b1_naremoved) # Default : var.eqaul = F(ALSE)
oneway.test(HT ~ factor(group), data = b1_naremoved) 
# oneway.test는 group에 factor(group) 적용시키지 않아도 동일한 P-value 산출됨. aov와 다름.

oneway.test(HT ~ group, data = b1_naremoved, var.equal = T) # TRUE로 옵션 명시 가능함.

# 날짜 변수 처리 방법
DATE_O = "2018-01-02"
DATE = as.Date(DATE_O, format = "%Y-%m-%d")
print(DATE)

# ---------- 층화 임의 추출, strata ----------
b2 = ex_data[, c("HT", "F_BR", "SEX", "MH")]
b2_naremoved = na.omit(b2)
View(b2_naremoved)
# SEX : 2 여자 / 1 남자, MH : 중학교 / 고등학교
b2_naremoved$food = ifelse(b2_naremoved$F_BR == 8, 1, 0)
var.test(HT ~ SEX, data = b2_naremoved)
t.test(HT ~ SEX, data = b2_naremoved, var.equal = F)
# 결과 : 남녀의 평균 차이가 있음.

# strata 나눔 : 남/녀 두 개의 dummy table로 나타냄.
bb1 = b2_naremoved[b2_naremoved$SEX == 1, ]
bb2 = b2_naremoved[b2_naremoved$SEX == 2, ]
View(bb1)
View(bb2)
var.test(HT ~ food, data = bb1)
t.test(HT ~ food, data = bb1)

mbb1 = b2_naremoved[ (b2_naremoved$MH == "중학교" & b2_naremoved$SEX == 1), ] # 중학생 남자
mbb1$food = ifelse(mbb1$F_BR == 8, 1, 0)
var.test(HT ~ food, data = mbb1)
t.test(HT ~ food, data = mbb1, var.equal = T)
# 해석 : 아침을 매일 먹은 인원들과 그렇지 않은 인원들의 평균 차이는 없다. 따라서 매일 아침식사를 한다고 해서 키에 차이가 있지 않다.

mbb2 = b2_naremoved[ (b2_naremoved$MH == "중학교" & b2_naremoved$SEX == 2), ] # 중학생 여자
View(mbb2)
mbb2$food = ifelse(mbb2$F_BR == 8, 1, 0)
var.test(HT ~ food, data = mbb2)
t.test(HT ~ food, data = mbb2, var.equal = T)
help(t.test)

hbb1 = b2_naremoved[ (b2_naremoved$MH == "고등학교" & b2_naremoved$SEX == 1), ] # 고등학생 남자
hbb1$food = ifelse(hbb1$F_BR == 8, 1, 0)
var.test(HT ~ food, data = hbb1)
t.test(HT ~ food, data = hbb1, var.equal = T)

hbb2 = b2_naremoved[ (b2_naremoved$MH == "고등학교" & b2_naremoved$SEX == 2), ] # 고등학생 여자
hbb2$food = ifelse(hbb2$F_BR == 8, 1, 0)
var.test(HT ~ food, data = hbb2)
t.test(HT ~ food, data = hbb2, var.equal = T)
