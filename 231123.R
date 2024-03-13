# https://wikidocs.net/33591 데이터셋 출처.

d1 = read.csv("HR_comma_sep.csv")
head(d1)

dim(d1)
sum(is.na(d1))

### 변수 설명 ###
# satisfaction_level : 직무 만족도
# last_evaluation : 마지막 평가점수
# number_project : 진행 프로젝트 수
# average_monthly_hours : 월평균 근무시간
# time_spend_company : 근속년수
# work_accident : 사건사고 여부(0: 없음, 1: 있음)
# left : 이직 여부(0: 잔류, 1: 이직)
# promotion_last_5years: 최근 5년간 승진여부(0: 승진 x, 1: 승진)
# department : 부서
# salary : 임금 수준

# 이직 여부, 사건사고 여부 CrossTable
CrossTable(d1$Work_accident, d1$left)

# 연관성 검정
chisq.test(d1$Work_accident, d1$left)
# p-value < 0.05이기 때문에, 귀무가설 기각. 독립 X.
# Row Total, Col Total을 확인 
# -> 이직 여부와 사건사고와 관련성은 있지만, 
# 행 퍼센트 : 이직 안 한 그룹이 사건사고 비율이 더 높다.
# 열 퍼센트 : 사건사고 없었던 그룹이 더 많이 이직함.

# 이직 : Y, 사건사고 여부 X로 가정하고 로지스틱 회귀 분석
help(glm)
res = glm(left ~ Work_accident, data = d1, family = "binomial") 
#'g' lm함수 사용해야 함에 유의.
# family = "binomial" 옵션 (이항분포) -> 로지스틱 회귀 가능. (Y = 0 or 1)

summary(res) # Work_accident Estimate 값 : -1.45168

exp(-1.45168) 
# 로지스틱 회귀에서는, Estimate 값에 exponential 함수를 씌워줘야 함.
# 0.235. 해석 : 사건사고가 발생힌 경우, 없는 경우에 비해 23.5% 이직함. (덜 이직함)

# glm 말고, CrossTable에서 odds ratio를 구해서도 알아낼 수 있음.
# /  0  |  1 
# 0  a     b
# -  - - - -
# 1  c     d
# odds ratio = ad/(bc)
odds_ratio = 9428 * 169 / (3402 * 2000)
print(round(odds_ratio, digits = 3)) # 동일한 값 산출됨. 사건사고가 없었던 그룹(0)에 비해 있었던 그룹(1)이 0.23배 이직한다.


# ---------- 데이터 병합 연습 ----------

emr = read.table("1_EMR data_sex.txt", header = T, sep = '\t') # sex만 사용
app = read.table("2_App data_e.txt", header = T, sep = '\t') # step만 사용
# ID가 중요함.

head(emr) ; head(app)
dim(emr)
# 4,815건(한 사람이 여러 줄 갖고 있는 data)

dim(app)
sum(is.na(app)) # 결측치 없는 데이터임.
# 112,031건
app_866 = app[app$A_myhealth_id == 866, c("A_myhealth_id", "A_steps")]
app_866$pid = app_866$A_myhealth_id

# 결측치 제거
emromit = na.omit(emr)

# ----- merge() 함수 : 동일 key값 기준 결합 함수 -----
# 두 개의 데이터셋을 열 결합할 때 동일 key값을 기준으로 결합해야할 때 유용.
# cbind()의 경우 각 행의 관찰치가 서로 동일하지 않은 것이 섞여있을 경우 사용 불가.
# merge() 함수의 사용이 필요함.

res = merge(emromit, app_866, key=pid) # merge()로 붙임. 
dim(res)

res2 = merge(app_866, emromit, key=pid)
dim(res2)

# 전체의 아이디 고려
app$pid = app$A_myhealth_id
res3 = merge(app, emromit, key=pid)
res4 = merge(emromit, app, key = pid)
View(res3)
View(res4)
dim(res3)
dim(res4)
# 차원 축소된 이유 : emromit에 있는 pid와 / app에 있는 pid(원 : A_myhealth_id)
# 는 서로 동일한 pid로부터 결합된 데이터들과(71,038개)
# 그렇지 않고 한 쪽에만 존재하는 pid 데이터들도 있었을 것임.
# 한 쪽에만 존재하는 pid 데이터들 약 40,000개는 merge() 과정에서 소멸됨.
# merge() 함수의 장점.
