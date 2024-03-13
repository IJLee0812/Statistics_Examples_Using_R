c = mtcars
View(c)
plot(mpg ~ wt, data = c)
res = lm(mpg ~ wt, data = c)
summary(res)
# 오차 : prediction한 line을 그려야 함.
abline(res)
# 오차항은 점과 선사이의 거리.

plot(res, 1)
# Fitted values : 데이터(점)에 Weight와 Bias를 대입한 값
# Residuals : 오차항
# 빨간 실선은 잔차의 추세, 점선에서 크게 벗어난다면 
# 예측값에 따라 잔차가 크게 달라진다는 것

plot(res, 2) # Q-Q plot (잔차 정규성 검정)
shapiro.test(res$residuals) # P-value : 0.1044 > 0.05이므로 귀무가설 기각 불가.

plot(res, 3) # 잔차 등분산성 검정, 빨간색 실선이 수평선을 그리는 것이 이상적

plot(res, 4) # 오차(잔차 X), 즉 점과 선사이의 거리를 그대로 그림.
# 극단값 추정 가능. 


res = lm(mpg~factor(vs), data = c) # factor 생략 가능
summary(res)

res = lm(mpg ~ factor(gear), data = c)
summary(res)

res = lm(mpg ~ wt + vs + factor(gear), data = c) 
summary(res)
# p-value > 0.05. 즉 vs, gear들의 유의성이 사라짐. 회귀모형의 유의성.

# 다중공선성 확인을 위한 라이브러리 설치
install.packages("car")
library(car)
vif(res) # GVIF < 10임. X들간의 상관성은 너무 크지 않음.
step(res, direction = "forward") 
# 전향적 변수 추가법 = forward 방법론은 X로 넣어준 애들을 모형에 왕창 다 넣는 방법.
# step()은 AIC 값을 추정해주는 함수. AIC 값이 작을수록 해당 모델이 좋음을 의미.

step(res, direction = "backward") 
# 해석 (후향적 변수 '제거'법)
# Start:  AIC = 70.95
# gear를 빼줌으로써(제외함) AIC 값이 68.28로 떨어짐.
# <none>은 forward (70.954), 기준값이 됨.
# vs를 빼면 AIC 값이 72.202로 오름, wt를 빼면 AIC 값이 94.172로 오름.
# vs와 wt는 제거하면 안 되고 필요하다는 의미로 해석됨.

# Step: AIC = 68.28
# vs / wt 제외 시 AIC값이 커지므로, 해당 모델(gear만 제거)이 가장 적합한 모델이 됨.

step(res) # default option은 direction = "both" 
step(res, direction = "both") # X들이 많아지면 forward, backward와 다른 결과가 산출될 수 있음.

install.packages("lmtest")
library(lmtest)
m1 = lm(mpg ~ wt, data = c)
m2 = lm(mpg ~ wt + vs, data = c) # vs : Engine Type
lrtest(m1, m2) # Likelihood Ratio test
# p-value < 0.05이므로 m1 != m2임.
m3 = lm(mpg ~ wt + vs + factor(gear), data = c)
lrtest(m2, m3)
# p-value > 0.05이므로 m1 = m2임.
# 모수 절약의 원칙에 의해 gear를 제외하는 게 최적의 모형임.