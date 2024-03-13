a = read.spss("kyrbs2022.sav", to.data.frame = T, header = T, reencode = "UTF-8")
View(a)
dim(a)

sum(is.na(a))
a = na.omit(a)
dim(a)

View(a)
a = a[, c("F_BR", "WT")]
a$F_BR_0_1 = ifelse(a$F_BR >= 0 & a$F_BR <= 7, 0, 1)
View(a)
freq(a$F_BR_0_1)

res = lm(WT ~ factor(F_BR_0_1), data = a)
summary(res)
