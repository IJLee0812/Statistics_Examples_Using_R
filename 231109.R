b1 = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8")
b1 = b1[, c("F_BR", "HT", "MH", "SEX", "AGE")]
b1 = na.omit(b1)
View(b1)
sum(is.na(b1))
b1$F_BR_1 = ifelse(b1$F_BR == 8, 1, 0) # 간소화 하여 dummy variable 사용 최소화.

# 단순회귀 STEP FUNCTION VAR SELECTION 잘 걸러서 아침식사 여부가 들어간 BEST MODEL을 찾아봄.

res1 = lm(HT ~ factor(MH), data = b1)
summary(res1)
# baseline은 고등학교임(사전순 ㄱ이 ㅈ보다 먼저이므로). 
# 고등학생에 비해 중학생의 키가 평균적으로 3.99637만큼 작음.
# baseline 바꾸려면 dummy variable 처리 또는 option 추가하면 됨.
vif(res1) # 다중공선성 확인은 분산확대인자 VIF로 확인.
# X가 단 한 개이므로 수행되지 않음.
plot(res1, 1)
plot(res1, 2)
plot(res1, 3)
plot(res1, 4)
# p < 0.05

res2 = lm(HT ~ factor(F_BR_1), data = b1)
summary(res2)
# p < 0.05
plot(res2, 1)
plot(res2, 2)
plot(res2, 3)
plot(res2, 4)

res3 = lm(HT ~ factor(SEX), data = b1)
summary(res3)
# p < 0.05 
plot(res3, 1)
plot(res3, 2)
plot(res3, 3)
plot(res3, 4)

res4 = lm(HT ~ AGE, data = b1) # 범주형 변수가 아님. 연속형임에 유의. factor 처리 X
summary(res4)
# p < 0.05
plot(res4, 1)
plot(res4, 2)
plot(res4, 3)
plot(res4, 4)


res = lm(HT ~ factor(F_BR_1) + factor(MH) + factor(SEX) + AGE, data = b1)
summary(res)
# factor(F_BR_1)1 의 p-value = 0.607384 > 0.05여도 무시한다. 강제적으로 포함시키기로 했기 때문.

# install.packages("car")
# library(car)
vif(res)
# VIF들이 모두 10보다 작음.

step(res, direction = "forward")
# AIC = 181807.5 (4개의 Variable 전부 넣었을 때.)
step(res, direction = "backward")
# F_BR_1을 제거한 게 AIC가 낮아지긴 하지만,
# 아침식사가 키에 영향을 주는지 확인하는 것이기 때문에 F_BR_1은 강제적으로 포함.
# 나머지 변수들은 Adjusted Variable이 됨.
step(res, direction = "both")
# 해석 : Step: AIC = 181805.7 에서
# F_BR_1, MH, AGE, SEX 제외할 경우 모두 AIC 높아지므로, 4가지 모두 포함되어야 한다.

# ----- Likelihood Ratio Test(사실 위 step의 결과로 굳이 수행하지 않아도 됨) -----
install.packages("lmtest")
library(lmtest)

m1 = lm(HT ~ factor(F_BR_1), data = b1)
m2 = lm(HT ~ factor(F_BR_1) + factor(MH), data = b1)
lrtest(m1, m2)
# p-value < 0.05이므로 m1 != m2임.
m3 = lm(HT ~ factor(F_BR_1) + factor(MH) + factor(SEX), data = b1)
lrtest(m2, m3)
# p-value < 0.05이므로 m2 != m3임.
m4 = lm(HT ~ factor(F_BR_1) + factor(MH) + factor(SEX) + AGE, data = b1)
lrtest(m3, m4)
# p-value < 0.05이므로 m3 != m4임.
# 해석 : 아무 것도 제외시키지 않아야 한다.

# ---------- 범주형 자료 분석 ----------

library(survival)
freq(b1$MH)
freq(b1$SEX)
CrossTable(b1$SEX, b1$MH)

help(chisq.test)
chisq.test(b1$SEX, b1$MH) # CHI-SQUARED TEST
# 해석 : p-value > 0.05이므로 통계적 연관성(독립성, 동질성)이 없다. 
# (동질성 검정) 중학교, 고등학교 남녀의 비율이 일정. (동질성 검정 귀무가설 : "차이 없음")
# (독립성 검정) 성별과 학교는 독립이다. (독립성 검정 귀무가설 : "서로 독립")

