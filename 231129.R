# 데이터 합치기 : Join 함수 (inner_join)
# 데이터프레임화 시키고 사용해야 함
library(dplyr)

id = c(1:10) # 1 ~ 10번
x = c(41:50)
a = cbind(id, x)
View(a)

id = c(3:12) # 1, 2번 없고, 11, 12번이 추가됨
y = c(51:60)
b = cbind(id, y)
View(b)

# a, b를 그냥 join 함수(들)에 넣으면, 에러 발생.
# data.frame() 함수를 이용하여 데이터프레임화 시킴
a = data.frame(a)
b = data.frame(b)

# 교집합
innerJoin = inner_join(a, b, by = "id")
# innerJoin() 함수는, merge() 함수와 동일함.
# 결측치가 발생하지 않으므로 분석에 용이함.
# merge함수 옵션은 key = xx 꼴임에 유의.
View(innerJoin)

# 합집합
fullJoin = full_join(a, b, by = "id") 
# Missing이 생길 수 있음.
View(fullJoin)

# 좌측부 + 교집합
leftJoin = left_join(a, b, by = "id")
View(leftJoin)

# 우측부 + 교집합
rightJoin = right_join(a, b, by = "id")
View(rightJoin)

# 연습 : Sex 별 Step의 차이가 있는지 검정.
hist(app$A_steps)
summary(app$A_steps) 
# 걸음걸이에서 마이너스 값이 나올 수 없음.
# 따라서 마이너스 값 제거가 필요함.
# 하루 걸음걸이 532975걸음 걷기 거의 불가능. 극단값 제거 필요함.

boxplot(app$A_steps)
print(boxplot(app$A_steps)$stats)

app_removed = app[app$A_steps >= 0, ]
dim(app_removed) # 마이너스 값은 두 개였음.

app_removed2 = app_removed[app_removed$A_steps <= 20000, ] # 극단값 제거
dim(app_removed2)
summary(app_removed2$A_steps)
boxplot(app_removed2$A_steps)
hist(app_removed2$A_steps) # 정규분포와 거리가 멀다.
# 왜냐하면 사람들마다 걸음걸이의 측정값들 개수가 다름.
# ID별로 측정값들의 개수가 다름. ex) pid = 866인 사람들 약 340개, pid = 906인 사람들 약 4개
# 전체에 대한 mean을 구하는 의미가 없어짐.
# ID/성별 데이터(emromit)는 한 사람 당 하나의 측정값 존재함.
# 스마트폰 데이터(app_removed2)도 한 사람 당 하나의 측정값이 존재하도록 만들어야 함.

app_aggr = aggregate(A_steps ~ A_myhealth_id, data = app_removed2, mean)
head(app_aggr)
hist(app_aggr$A_steps)
shapiro.test(app_aggr$A_steps) # p-value < 0.05이므로, 귀무가설인 정규분포 따름을 기각. 따르지 않음.

# ---------- 비모수 검정(정규분포 따르지 않을 경우) ----------