p = PlantGrowth

View(p)

plot(weight ~ group, data = p)
# continuous var는 plotting이 예쁘게 되는데,
# cartegorical var는 scatter plot이 나타나지 않고, boxplot으로 나타남.  

result = lm(weight ~ group, data = p)
summary(result)

# weight = alpha + beta * group
# weight = 5.03 + d1 * -0.3710 + d2 * 0.4940
# d1 : ctrl에 비한 trt1의 효과. (0.3710만큼 감소했음.) / d2 : ctrl에 비한 trt2의 효과. (0.4940만큼 증가했음.)

c = cars
plot(c)
View(c)
plot(dist ~ speed, data = c)

result = lm(dist ~ speed, data = c)
abline(result)
summary(result)

# dist = -17.5791 + speed * 3.9324
# 해석 : speed와 dist 둘 다 continuous variable. speed가 1 증가할 때, dist는 약 3.93 만큼 증가한다.
# 중요 : continuous variable과 categorical variable에 따라 회귀식의 의미는 달라짐.

# ------------------------------------------------------------------------------

c1 = mtcars
View(c1)
# mpg : 연비
# mpg = alpha + beta * wt
res1 = lm(mpg ~ wt, data = c1)
summary(res1)
# mpg = 37.2851 + wt * -5.3445
# 해석 : wt가 1 증가할 때, mpg는 5.3445 감소한다.


c2 = c1[, c("mpg", "gear")]
View(c2)
c2$d1 = ifelse(c2$gear == 3, 1, 0)
c2$d2 = ifelse(c2$gear == 4, 1, 0)
View(c2)
# X로 범주형 변수가 들어갈 때는, factor 처리를 해줘야 한다.
res1_1 = lm(mpg ~ factor(gear), data = c2)
summary(res1_1)

# ----- mpg = alpha + beta * gear -> baseline이 gear 5가 되는 것을 구해보기. -----
res2 = lm(mpg ~ d1 + d2, data = c2)
summary(res2)
res3 = lm(mpg ~ factor(gear, level = c(5, 3:4)), mtcars) # level이라는 option을 붙임. 5가 reference인 경우, 3과 4에 대한 효과를 봄.
summary(res3)

# mpg = 16.107 + gear4 * (8.427) + gear5 * (5.273)
# baseline default gear3이므로, gear4는 8.427만큼 증가했음. / gear5는 5.273만큼 증가했음.

# mpg = 21.380 + d1 * (-5.273) + d2 * (3.153)
# d1 : gear5에 비한 gear3의 효과. 5.273만큼 감소했음. / d2 : gear5에 비한 gear4의 효과. 3.153만큼 증가했음. 

# 기말시험 시 데이터에 대한 의구심 / 질문 생기면 문제 풀기 전에 바로바로 질문.
# 선형회귀 : X가 Categorical일 때, factor 명시 필수 : 변수를 보고 continuous인지, categorical인지 구분 필요.

# Categorical Variable이 3 level 이상일 때 aov()와 lm() 동일한 F통계량 산출됨. ANOVA는 회귀분석의 특별한 형태이기 때문. 
# TukeyHSD로 contrast(각각의 level들 비교)한 결과와 동일 결과 산출됨. 
# level이 2개이면 regression model은 t.test와 동일한 결과 산출됨.
output = aov(mpg ~ factor(gear), data = c1)
summary(output)
TukeyHSD(output)
