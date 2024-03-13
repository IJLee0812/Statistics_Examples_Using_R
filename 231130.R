emr = read.table("1_EMR data_sex.txt", header = T, sep = '\t') # sex만 사용
emromit = na.omit(emr)
app = read.table("2_App data_e.txt", header = T, sep = '\t') # step만 사용
hist(app$A_steps)
summary(app$A_steps) 
# 걸음걸이에서 마이너스 값이 나올 수 없음.
# 따라서 마이너스 값 제거가 필요함.
# 하루 걸음걸이 532975걸음 걷기 거의 불가능. 극단값 제거 필요함.

boxplot(app$A_steps)
print(boxplot(app$A_steps)$stats)

app_removed = app[app$A_steps >= 0, ]
dim(app_removed) # 마이너스 값은 두 개였음.

app_removed = app_removed[app_removed$A_steps <= 20000, ] # 극단값 제거
dim(app_removed)
summary(app_removed$A_steps)
boxplot(app_removed$A_steps) # 위쪽 꼬리가 길다 -> Right Skewed
hist(app_removed$A_steps) # 정규분포와 거리가 멀다.
# 왜냐하면 사람들마다 걸음걸이의 측정값들 개수가 다름.
# ID별로 측정값들의 개수가 다름. ex) pid = 866인 사람들 약 340개, pid = 906인 사람들 약 4개
# 전체에 대한 mean을 구하는 의미가 없어짐.
# ID/성별 데이터(emromit)는 한 사람 당 하나의 측정값 존재함.
# 스마트폰 데이터(app_removed2)도 한 사람 당 하나의 측정값이 존재하도록 만들어야 함. 하기된 코드 참조.

app_aggr = aggregate(A_steps ~ A_myhealth_id, data = app_removed, mean)
head(app_aggr)
hist(app_aggr$A_steps)
shapiro.test(app_aggr$A_steps) # p-value < 0.05이므로, 귀무가설인 정규분포 따름을 기각. 따르지 않음.

# ---------- 23.11.30(목) 실습 코드 ----------

# sample size 줄여보기
app_removed_minimized = app_removed[app_removed$A_steps <= 10000, ]
boxplot(app_removed_minimized$A_steps)
hist(app_removed_minimized$A_steps) # 500걸음정도를 걷는 사람들이 굉장히 많은 portion을 차지함.

# 한 ID 당 "중앙값(median)이 하나"씩 나오도록 구해보기.
app_aggr = aggregate(A_steps ~ A_myhealth_id, data = app_removed_minimized, median)
head(app_aggr)
hist(app_aggr$A_steps)
View(app_aggr)
dim(app_aggr)
shapiro.test(app_aggr$A_steps) # p-value< 0.05이므로, 정규분포 따르지 않음.

app_aggr$pid = app_aggr$A_myhealth_id
appFin = merge(app_aggr, emromit, key = pid)
dim(appFin)
hist(appFin$sex) # 남녀 수 확인

# ----- 비모수 검정(정규분포 따르지 않을 경우 or 분포의 변동 심하거나 skewed된 경우) -----

# Y : step ~ X : sex
hist(appFin$A_steps) # 분포의 변동이 심함을 알 수 있다. -> 비모수 검정을 적용한다.
wilcox.test(A_steps ~ sex, data = appFin) # sex에 factor를 안 씌워도 됨.
# 귀무가설: 두 개 모집단의 중위수가 동일함.
# p-value < 0.05이므로, 귀무가설 기각. 대립가설 채택되므로,
# 두 개 모집단의 중위수는 다름을 알 수 있음.

# 성별 별 중앙값 도출해보기
appFin_aggr = aggregate(A_steps ~ sex, data = appFin, FUN = median)
appFin_aggr2 = aggregate(A_steps ~ sex, data = appFin, FUN = min)
appFin_aggr3 = aggregate(A_steps ~ sex, data = appFin, FUN = max)
head(appFin_aggr) # 확인하기
head(appFin_aggr2) ; head(appFin_aggr3)

# ----- 걸음걸이와 칼로리(Categorical Variable인 경우)의 관계 -----
summary(app$A_calorie) # 칼로리 값 음수 쳐내고, 보편적 하루 소모 칼로리량 고려하여 데이터 쳐내야 함.
boxplot(app$A_calorie) # 상자수염 그림으로 이상치 직관적으로 파악 가능.
app_cal = app[app$A_calorie >= 0 & app$A_calorie <= 1500, ]
boxplot(app_cal$A_calorie)
hist(app_cal$A_calorie)

app_cal$pid = app_cal$A_myhealth_id
app_cal = merge(app_cal, emromit, key = "pid")
dim(app_cal)

View(app)
app_cal2 = aggregate(A_calorie ~ pid , data = app_cal, median) # 각 id별 "중앙값" 한 개만 산출해야 함. 퍼진 정도가 넓을 경우 median 사용
app_cal3 = aggregate(A_steps ~ pid, data = app_cal, median)
app_cal4 = merge(app_cal2, app_cal3, key = "pid")
dim(app_cal4) # 개수 확 감소됨을 확인 가능
View(app_cal4)
# 상관계수 도출
shapiro.test(app_cal4$A_calorie)
shapiro.test(app_cal4$A_steps)
cor(app_cal4$A_calorie, app_cal4$A_steps, method = "spearman") # 0.715로, 양의 상관성을 강하게 띔을 알 수 있음.
plot(app_cal4$A_calorie ~ app_cal4$A_steps) # 양의 상관성 있음을 확인 가능.

# 상관계수 가설검정
cor.test(app_cal4$A_steps, app_cal4$A_calorie) # 대립가설 채택(상관성 존재)

dim(app_cal4)
summary(app_cal4$A_calorie)
hist(app_cal4$A_calorie)

# 선형회귀 모델 : Y가 정규성 없을 때 lm() 함수 사용 불가. glm() 함수로 회귀분석 수행. 
res = glm(A_calorie ~ A_steps, data = app_cal4)
summary(res)
plot(A_calorie ~ A_steps, data = app_cal4)
abline(res)
# 해석 : 한 걸음 더 걸을 때마다, 하루 소모 칼로리가 0.039 만큼 더 증가한다.