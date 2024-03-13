# ---------- 23.12.06(수) 실습과제 ----------

# sex를 덧붙여서, sex와 step이 칼로리에 미치는 영향을 본다.
emr = read.table("1_EMR data_sex.txt", header = T, sep = '\t') # sex만 사용
emromit = na.omit(emr)
app = read.table("2_App data_e.txt", header = T, sep = '\t') # step만 사용

app_cal = app[app$A_calorie >= 0 & app$A_calorie <= 1500, ]
summary(app_cal$A_steps) # 칼로리를 이상치 쳐내고 적정범위로 설정하면,
# 걸음걸이 수도 어느 정도 이상치가 쳐내지는 효과를 볼 수 있다.

app_cal$pid = app_cal$A_myhealth_id # pid를 기준으로 데이터 병합(merge)을 위하여 생성한다.
# app_cal = merge(app_cal, emromit, key = "pid") # 생략 가능. 이유 생각해보기.
View(app_cal)

app_cal2 = aggregate(A_calorie ~ pid, data = app_cal, median)
app_cal3 = aggregate(A_steps ~ pid, data = app_cal, median)

app_cal4 = merge(app_cal2, app_cal3, key = "pid")
app_cal4 = merge(emromit, app_cal4, key = "pid") # app_cal4에 각 pid별 성별(sex) 데이터도 병합함.
dim(app_cal4) # emromit에 있는 pid 418개 중 merge로 인하여 113개 소멸됨.

# 성별 및 걸음걸이 둘 다 X로 포함된 모델
m1 = glm(A_calorie ~ factor(sex) + A_steps, data = app_cal4)
summary(m1)

# 걸음걸이만 X로 포함된 모델
m2 = glm(A_calorie ~ A_steps, data = app_cal4)
summary(m2)

m3 = glm(A_calorie ~ sex, data = app_cal4)
summary(m3)
# glm에 X가 Categorical일 경우, factor() 함수 따로 표시 안할 시
# 더 작은 숫자가 Reference가 됨. 남자(1)가 됨.
plot(A_calorie ~ factor(sex), data = app_cal4) # X가 Categorical : plot 상자수염 그림으로 표현됨.

# ----- 모델 적합도 평가 ----
library(car)
vif(m1)
step(m1, direction = "backward")
# 해석 : factor(sex) 제외할 경우, AIC가 2882.0에서 2948.4( -(minus) factor(sex) )로 높아지기 때문에, 
# 독립변수 X는 성별 및 걸음걸이를 모두 포함시킨 모델이 더 적합함을 알 수 있다.
library(lmtest)
lrtest(m1, m2)
# p-value < 0.05이므로, res != res2이다.

# ----- 당뇨 관련 새로운 데이터 불러들이기 -----
dangnyo = read.table("1_EMR data_hba1c.txt", header = T, sep = '\t')
View(dangnyo)
dim(dangnyo)
########## 변수 제거 방법 ##########
# rm(변수명) 으로 변수 제거 가능하다.
# ex) rm(dangnyo) 콘솔창에서 하는 게 편리할 것.
