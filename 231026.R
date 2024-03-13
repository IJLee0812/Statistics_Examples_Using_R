# ---------- Pearson 상관계수 / 상관분석 ----------

require(stats)
View(cars)
dim(cars)
plot(cars)
lines(cars)
# lowess() 함수 : Scatter Plot을 smoothing해주는 함수이다.
lines(lowess(cars))

# 상관계수 도출
cor(cars$speed,cars$dist)
cor(cars$dist, cars$speed)

# Pearson 상관분석, 귀무가설 : 모집단 상관계수(ρ) = 0
cor.test(cars$speed,cars$dist)
# 결과 해석 : p-value < 0.05이므로, 귀무가설을 기각한다. 양의 상관관계를 가진다.

# mtcars 이용
a = mtcars
a = a[, c("mpg", "wt")]
class(a$wt) ; class(a$mpg)
View(a)
plot(a)
lines(a)
lines(lowess(a))
cor(a$mpg,a$wt)
cor.test(a$mpg,a$wt)

# ---------- 선형회귀 분석 ----------
View(cars)
res = lm(dist~speed,data=cars) # lm = linear regression model
plot(dist ~ speed, data = cars)
summary(res)# 65%
abline(res)

plot(wt ~ mpg, data = mtcars)
res = lm(wt ~ mpg, data = mtcars)
summary(res)
# 결과 해석 : p-value 3개 도출됨, 첫번째는 bias의 p-value, 두번째는 
# weight의 p-value, 세번째는 해당 회귀모델의 p-value임. 
# 결정계수 Multiple R-squared = 0.7528, 75%의 영향력이 있음.
# Multiple R-squared의 값과 Adjusted R-squared의 값의
# 차이가 크면, 모델이 Overfitting된 것임.
abline(res) # 선형회귀 직선 그래프에 표시.
