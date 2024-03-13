# 카이제곱 검정(Chi-Square Test)
# 두 범주형 변수 간의 연관성을 평가하기 위해 사용
# 종류 : 1. 일원 카이제곱 검정 / 2. 이원 카이제곱 검정

# 일원 카이제곱 검정 ('적합도' 검정, goodness of fit test)
# 교차분할표(Contingency Table)를 사용하지 않는 카이제곱 검정.
# 표본 데이터의 분포가 특정 형태의 분포와 일치하는지
# 범주형 데이터의 관측치와 기댓값과의 차이를 근거로 검정.
# 기댓값 : table에서 marginal 값과의 비율을 산출하여 만들어짐.
# 한 개의 변인(범주)을 대상으로 검정을 수행.
# 관찰도수가 기대도수와 일치하는지 검정.

# 이원 카이제곱 검정
# 교차분할표를 사용하는 카이제곱 검정으로
# 두 개 이상의 변인(범주)을 대상으로 검정을 수행.
# 분석대상의 집단 수에 의해서 독립성 검정과 동질성 검정으로 나뉨.
# - 독립성 검정 : 한 집단 내에서 두 변인의 관계가 독립인지 검정.
# - 동질성 검정 : 두 집단 이상에서 각 범주(집단)간의 비율이 서로 동일한지 검정.

# 동질성 검정 예제
# 주사위를 120번 던져서 나온 눈의 도수가 다음과 같을 때,
# 이 주사위가 공정한지 유의수준 5%에서 검정하라.
x = c(31, 26, 22, 18, 13, 10)
ct = chisq.test(x)
cat("p-val : ", ct$p.value)
library(psych)
chitest.plot2(stat = ct$stat, df = ct$parameter, side = "up")

# ---------- 23.11.16(목) 실습 ----------
b1 = read.spss("kyrbs2022.sav", to.data.frame = T, reencode = "UTF-8")
View(b1)

freq(b1$ECZ_DG_LT) # 평생 아토피 피부염 의사진단 경험, 1 : 없음 / 2 : 있음
table(b1$ECZ_DG_LT) # table 함수의 한계 : 퍼센테이지 표현되지 않음.
# 단독으로 쓰이는 것 보다 다른 차트를 활용하기 전에 적용하는 함수

freq(b1$F_FASTFOOD)
b1$FASTFOOD = ifelse(b1$F_FASTFOOD >= 5 & b1$F_FASTFOOD <= 7, 3, ifelse(b1$F_FASTFOOD >= 2 & b1$F_FASTFOOD <= 4, 2, 1))
freq(b1$FASTFOOD)

# Method 1
b1_1 = b1[, c("FASTFOOD", "ECZ_DG_LT")]
barplot(table(b1_1))
b1_2 = b1[, c("ECZ_DG_LT", "FASTFOOD")]
barplot(table(b1_2))

# Method 2 (바로 대입, 더 간편한 방법)
barplot(table(b1$ECZ_DG_LT, b1$FASTFOOD))
barplot(table(b1$FASTFOOD, b1$ECZ_DG_LT))

# 데이터를 보고 해석하는 게 중요함. 패스트푸드와 아토피 유무의 연관성 중 
# 독립성을 보여야 적합한가, 동질성을 보여야 적합한가?
# => 동질성을 보여야 한다. CrossTable에서 Col Total의 비율이 아토피 환자/비환자 유사하기 때문.
CrossTable(b1$FASTFOOD, b1$ECZ_DG_LT)
prop.table(table(b1$ECZ_DG_LT, b1$FASTFOOD)) # CrossTable()의 "N / Table Total" 만 산출됨.

chisq.test(b1$FASTFOOD,b1$ECZ_DG_LT) # 독립성 검정보다 동질성 검정으로의 해석이 필요함.
# p-value = 0.2642 > 0.05이므로,(독립성, 동질성 검정에 '모두' 적용됨) 
# 귀무가설을 기각할 수 없다.
# 동질성 검정 : 귀무가설인 통계적으로 유의한 차이가 없다 를
# 기각할 수 없음. 따라서 패스트푸드를 많이 먹는 사람들 / 먹지 않는 사람들의 
# 아토피의 유무는 통계적으로 유의한 차이가 없음을 알 수 있음.

# cor() 함수 : Continuous Variable일 때만 사용할 수 있는 함수.

b1$atopy = ifelse(b1$ECZ_DG_LT == 2, 1, 0)
freq(b1$atopy)

res = glm(atopy ~ factor(FASTFOOD), family = binomial, data = b1)
summary(res)
exp(0.03682) ; exp(0.10992)
