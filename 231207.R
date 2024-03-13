# library(FSA) # -> for dunnTest

emr = read.table("1_EMR data_hba1c.txt", header = T, sep = '\t')
View(emr)

dim(emr)
sum(is.na(emr))

# ----- 데이터 정제과정 -----

# 기존 방법 : 한 행에 NA 하나라도 있으면 지워짐. 환자 자체가 날아갈 수 있음
emromit = na.omit(emr)
dim(emromit)
View(emromit)

# complete.cases() 함수 : 
d1 = emr
d2 = d1[ complete.cases(d1), ]
View(d2)
dim(d2)

# ID 중복된다. 중복 해결하는 함수 distinct() 이용.
# 해당 데이터프레임에서의 모든 열에서 동일한 값을
# 갖는 행 데이터 제거
library(dplyr)
d3 = distinct(emr)
View(d3)
distinct(d3, pid, .keep_all = T)
View(d3)

d4 = merge(d2, app_cal4, key = pid)
View(d4)
dim(d4)

# ---------------------------

# hba1c : 당뇨 0/X 구분의 척도가 되는 수치 
# hba1c가 6.5 이상이면 당뇨, 아니면 당뇨 아님. Reference variable 생성

d4$isDM = ifelse(d4$hba1c >= 6.5, 1, 2) # 당뇨 판별 범주형 변수 생성
View(d4)
freq(d4$isDM) # 당뇨 빈도수 확인(diabetes)

# CrossTable 생성
library(survival)

CrossTable(d4$sex, d4$isDM) # 당뇨(1) / 당뇨X(2) 순서로 나타남

# 여자에 비해 남자가 몇 배 많은가?

odds_ratio = (104 * 23) / (9 * 75)
print(odds_ratio) # 3.543704배 많음.

d4$isDM = ifelse(d4$isDM == 1, 1, 0) # glm 이용을 위해서 1 / 2를 1 / 0으로 다시 매핑해준다.
res = glm(isDM ~ sex, data = d4, family = "binomial")
summary(res)
res$coefficients # beta 값 확인
exp(-1.2652) # 0.2821829 값 도출됨. 해석 : reference가 남자(1)가 되므로, 여자는 남자의 0.28배임. 여자가 더 당뇨 적음. 

# 중요!!! 시험 시 유용하게 쓰이는 과정.
d4$gender = ifelse(d4$sex == 2, 0, 1) # reference가 여자(2)가 되도록 dummy variable 추가함.
View(d4)
res2 = glm(isDM ~ gender, data = d4, family = "binomial")
summary(res2)
exp(1.2652)

# wt, ht 이용하여 BMI 구함
d4$BMI = (d4$wt / (d4$ht*d4$ht)) * 10000
View(d4)
# 18.5 미만 : 저체중(0) / 18.5 ~ 25 : 정상 + 과체중(1) / 25 이상 : 비만(2) 세 그룹으로 나눈다.
d4$bmiGroup = ifelse(d4$BMI < 18.5, 0, ifelse(d4$BMI > 25 , 2, 1))
View(d4)
summary(d4$BMI)
freq(d4$bmiGroup) # 당뇨 환자 데이터이므로, 저체중이 없음.

# 고혈압 : 수축기 혈압(sbp) 140 mmHg 이상, 또는 이완기 혈압(dbp) 90 mmHg 이상.
# 고혈압 : 1 / 고혈압 X : 0으로 정의함.
d4$Highbp = ifelse(d4$sbp >= 140 | d4$dbp >= 90, 1, 0)
View(d4)  
freq(d4$Highbp)

View(d4)