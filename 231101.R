# ---------- 23.11.01(수) 다변인 선형회귀 ----------

d = mtcars
d = d[,c("mpg", "disp", "hp", "drat", "wt")]
View(d)
cor(d) # Correlation Matrix 
plot(d) # 상관관계에서 가장 중요한 것은 Scatter Plot.

help(PlantGrowth)
res = lm(weight ~ factor(group), data = PlantGrowth)
# X가 범주형이므로 factor() 처리 반드시 수행.
summary(res)
# 결과 해석
# baseline이 default로 ctrl이 됐음. 
# ctrl에 비해 trt1을 0.3710만큼 "감소"시킨다는 것이고,
# ctrl에 비해 trt2를 0.4940만큼 "증가"시킨다는 것임.

# baseline을 임의로 trt2로 잡고 싶은 경우, 직접 Dummy Variable을 만들어 줘야 함.
p = PlantGrowth
p$d1 = ifelse(p$group == "ctrl", 1, 0)
p$d2 = ifelse(p$group == "trt1", 1, 0)
View(p)

p_res = lm(weight ~ d1 + d2, data = p)
summary(p_res)

# 개인 연습
d = mtcars
View(d)
help(mtcars)

d = d[, c("qsec", "cyl", "wt", "am")]
View(d)
cor(d)
plot(d)

d_res = lm(qsec ~ cyl + wt + am, data = d)
summary(d_res)
plot(d_res)
abline(d_res)
# 범주형 변수에 factor 적용 시
d_res = lm(qsec ~ factor(cyl) + wt + factor(am), data = d)
summary(d_res)
