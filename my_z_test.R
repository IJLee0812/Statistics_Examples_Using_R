my_z_test = function(sample_mean, n, population_mean, population_sd){
  # 파라미터 : 표본평균, 표본 수, 모집단의 평균, 모집단의 표준편차
  sample_mean_sd = population_sd / sqrt(n) # 표본평균의 표준편차 계산
  
  # p-value : pnorm 함수로 구할 수 있음.
  if (sample_mean <= population_mean){ # 표본평균이 분포 왼쪽에 위치
    p_value = pnorm(sample_mean, m = population_mean, sd = sample_mean_sd)
  }
  else{ # 표본평균이 분포 오른쪽에 위치
    p_value = 1 - pnorm(sample_mean, m = population_mean, sd = sample_mean_sd)
  }
  cat("\n", "p value is", p_value, "\n", "\n")
}