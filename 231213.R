emr = read.table("1_EMR data_hba1c.txt", header = T, sep = '\t')
emromit = na.omit(emr)
dim(emromit)
View(emromit)
d1 = emr
d2 = d1[ complete.cases(d1), ]
View(d2)
dim(d2)
library(dplyr)
d4 = merge(d2, app_cal4, key = pid)
View(d4)
dim(d4)

# ---------------------------

# hba1c : 당뇨 0/X 구분의 척도가 되는 수치 
# hba1c가 6.5 이상이면 당뇨, 아니면 당뇨 아님. Reference variable 생성

d4$isDM = ifelse(d4$hba1c >= 6.5, 1, 2) # 당뇨 판별 범주형 변수 생성
View(d4)
freq(d4$isDM) # 당뇨 빈도수 확인(diabetes)

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


model1 = glm(isDM ~ factor(bmiGroup), data = d4, family = "binomial")
summary(model1)
exp(-0.2245)

model2 = glm(isDM ~ factor(Highbp), data = d4, family = "binomial")
summary(model2)
exp(0.5836)

model3 = glm(isDM ~ factor(Highbp) + BMI, data = d4, family = "binomial")
summary(model3)
exp(model3$coefficients) # BMI가 한 단계 증가할 때, 당뇨가 0.99배 증가한다.

modeltot = glm(isDM ~ factor(bmiGroup) + factor(Highbp) + BMI, data = d4, family = "binomial")
summary(modeltot)

step(modeltot, direction = "backward")

lrtest(model1, model2)
lrtest(model2, model3)
lrtest(model1, model3)
