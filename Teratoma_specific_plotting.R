
# 데이터 불러오기


# hard

csv_dir = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\filter_subsets\\'
csv_dir_ips = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\IPS_specifics\\filter_subsets\\'

snp_teratoma_path_lst = list.files(path = csv_dir, 
                                   pattern = "filter_subset_SNP_Teratoma*")

indel_teratoma_path_lst = list.files(path = csv_dir, 
                                     pattern = "filter_subset_INDEL_Teratoma*")

snp_IPS_path_lst = list.files(path = csv_dir_ips, 
                              pattern = "filter_subset_SNP_hiPS*")


length(snp_teratoma_path_lst)
length(indel_teratoma_path_lst)

length(snp_IPS_path_lst)


DP = 20
MQ = 40
QD = 2
SOR = 3 # 3보다 큰것 필터링

X100 <- c('Teratoma-7', 'Teratoma-8', 'Teratoma-9', 'Teratoma-10', 
          'Teratoma-11', 'Teratoma-12', 'Teratoma-16', 'Teratoma-17', 
          'Teratoma-18', 'Teratoma-21', 'Teratoma-22')

X200 <- c('Teratoma-4', 'Teratoma-6', 'Teratoma-13', 'Teratoma-14', 
          'Teratoma-15', 'Teratoma-19', 'Teratoma-20', 'Teratoma-24', 
          'Teratoma-25', 'Teratoma-26')

# tst = 'Teratoma-7'
# if (tst == X100){
#   print("100X")
# } else if (tst == X200){
#   print("200X")
# }

length(X100[X100 == 'Teratoma-15']) ==1
length(X100[X100 == 'Teratoma-7']) ==1
X100[X100 == 'Teratoma-15']
X100[X100 == 'Teratoma-7']


old.par <- par(mai=c(1, 1, 0.7, 0.3))
old.mfrow <- par(mfrow=c(3, 5))


# snp - DP small

for (path in snp_teratoma_path_lst) {
  str1 = strsplit(path, split = "_")[[1]][4]
  name = strsplit(str1, split="\\.")[[1]][1]
  print(name)
  
  x_type = ifelse(length(X100[X100 == name] == 1), '100X',
                  ifelse(length(X200[X200 == name]) == 1, '200X', NULL))

  x_col = ifelse(length(X100[X100 == name] == 1), 'magenta',
                 ifelse(length(X200[X200 == name]) == 1, 'turquoise4', NULL))
  
  # x_type = ifelse(name==X100, '100X',
  #                 ifelse(name==X200, '200X', NULL))
  # x_col = ifelse(name==X100, 'midnightblue',
  #                 ifelse(name==X200, 'magenta', NULL))
  
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$DP < DP, ]))
  print(head(df[df$DP < DP, ]))
  low_dp = df[df$DP < DP, ]
  
  print(table(low_dp[, 'DP']))
  freq <- table(low_dp[, 'DP'])
  
  # mt = as.matrix(low_dp[, 3])
  # print(head(mt))
  # rownames(mt) <- low_dp$CH_POS
  # t(mt)
  
  barplot(freq, beside = T, las=1,
          ylim = c(0, 700),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.0, cex.sub = 1.2,
          col = c('tomato'),
          main = "DP (less than 20)",
          xlab='DP count',
          ylab='Frequency of DP',
          sub = name)
  mtext(text = x_type, col = x_col,
        side=1, line=4.8, cex = 0.7)
}


# snp dp large

for (path in snp_teratoma_path_lst) {
  str1 = strsplit(path, split = "_")[[1]][4]
  name = strsplit(str1, split="\\.")[[1]][1]
  
  x_type = ifelse(length(X100[X100 == name] == 1), '100X',
                  ifelse(length(X200[X200 == name]) == 1, '200X', NULL))
  
  x_col = ifelse(length(X100[X100 == name] == 1), 'magenta',
                 ifelse(length(X200[X200 == name]) == 1, 'turquoise4', NULL))
  
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$DP >= DP, ]))
  print(head(df[df$DP >= DP, ]))
  high_dp = df[df$DP >= DP, ]
  
  print(table(high_dp[, 'DP']))
  freq <- table(high_dp[, 'DP'])
  
  # mt = as.matrix(high_dp[, 3])
  # print(head(mt))
  # rownames(mt) <- high_dp$CH_POS
  # t(mt)
  
  barplot(freq, beside = T, las=1,
          ylim = c(0, 1200),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.0, cex.sub = 1.2,
          col = c('tomato'),
          main = "DP (more than 20)",
          xlab='DP count',
          ylab='Frequency of DP',
          sub = name)
  mtext(text = x_type, col = x_col,
        side=1, line=4.8, cex = 0.7)
  
}



# snp - MQ

par(mai=c(1, 1.0, 0.7, 0.3))
par(mfrow=c(3, 5))

for (path in snp_teratoma_path_lst) {
  str1 = strsplit(path, split = "_")[[1]][4]
  name = strsplit(str1, split="\\.")[[1]][1]
  
  x_type = ifelse(length(X100[X100 == name] == 1), '100X',
                  ifelse(length(X200[X200 == name]) == 1, '200X', NULL))
  
  x_col = ifelse(length(X100[X100 == name] == 1), 'magenta',
                 ifelse(length(X200[X200 == name]) == 1, 'turquoise4', NULL))
  
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$MQ >= MQ, ]))
  print(head(df[df$MQ >= MQ, ]))
  high_mq = df[df$MQ >= MQ, ]
  
  a = round(high_mq$MQ)
  
  print(table(a))
  freq <- table(a)

  barplot(freq, beside = T, las=1,
          ylim = c(0, 90000),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.0, cex.sub = 1.2,
          col = c('tomato'),
          main = "MQ (more than 40)",
          xlab='MQ count',
          # ylab='Frequency of MQ',
          sub = name)
  mtext(text = 'Frequency of MQ',
        side=2, line=3.8, srt = 90, cex = 0.7)
  mtext(text = x_type, col = x_col,
        side=1, line=4.8, cex = 0.7)
  
  # break
}


# snp - QD

for (path in snp_teratoma_path_lst) {
  str1 = strsplit(path, split = "_")[[1]][4]
  name = strsplit(str1, split="\\.")[[1]][1]
  
  x_type = ifelse(length(X100[X100 == name] == 1), '100X',
                  ifelse(length(X200[X200 == name]) == 1, '200X', NULL))
  
  x_col = ifelse(length(X100[X100 == name] == 1), 'magenta',
                 ifelse(length(X200[X200 == name]) == 1, 'turquoise4', NULL))
  
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$QD >= QD, ]))
  print(head(df[df$QD >= QD, ]))
  high_qd = df[df$QD >= QD, ]
  
  a = round(high_qd$QD)
  
  print(table(a))
  freq <- table(a)
  
  barplot(freq, beside = T, las=1,
          ylim = c(0, 40000),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.0, cex.sub = 1.2,
          col = c('tomato'),
          main = "QD (more than 2)",
          xlab='QD count',
          # ylab='Frequency of QD',
          sub = name)
  mtext(text = 'Frequency of QD',
        side=2, line=3.8, srt = 90, cex = 0.7)
  mtext(text = x_type, col = x_col,
        side=1, line=4.8, cex = 0.7)
  
  # break
}
  

# snp - SOR

for (path in snp_teratoma_path_lst) {
  str1 = strsplit(path, split = "_")[[1]][4]
  name = strsplit(str1, split="\\.")[[1]][1]
  
  x_type = ifelse(length(X100[X100 == name] == 1), '100X',
                  ifelse(length(X200[X200 == name]) == 1, '200X', NULL))
  
  x_col = ifelse(length(X100[X100 == name] == 1), 'magenta',
                 ifelse(length(X200[X200 == name]) == 1, 'turquoise4', NULL))
  
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$SOR <= SOR, ]))
  print(head(df[df$SOR <= SOR, ]))
  high_SOR = df[df$SOR <= SOR, ]
  
  a = round(high_SOR$SOR)
  
  print(table(a))
  freq <- table(a)
  
  barplot(freq, beside = T, las=1,
          ylim = c(0, 70000),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.0, cex.sub = 1.2,
          col = c('tomato'),
          main = "SOR (less than 3)",
          xlab='SOR count',
          # ylab='Frequency of QD',
          sub = name)
  mtext(text = 'Frequency of SOR',
        side=2, line=3.8, srt = 90, cex = 0.7)
  mtext(text = x_type, col = x_col,
        side=1, line=4.8, cex = 0.7)
  
  # break
}

par(old.par)
par(old.mfrow)



# three plot (DP, MQ)



old.par = par(mai=c(1, 1.0, 0.7, 0.3))
old.mfrow = par(mfrow=c(3, 5))

# 



for (path in snp_teratoma_path_lst) {
  str1 = strsplit(path, split = "_")[[1]][4]
  name_T = strsplit(str1, split="\\.")[[1]][1]
  print(name_T)
  
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$DP < DP, ]))
  print(head(df[df$DP < DP, ]))
  
  dp_rng = df[df$DP > 10 && df$DP < 200, ]
  
  dp_mq_rng_df = dp_rng[dp_rng$MQ >= 50, ]
  dp_mq_rng_df
  
  # dp_mq_rng_df$MQ = round(dp_mq_rng_df$MQ)

  plot(dp_mq_rng_df$MQ, dp_mq_rng_df$DP,
       xlim = c(50, 60.1), cex=0.4, col = 'red')

  
  # break
}

for (path in snp_IPS_path_lst) {
  str1 = strsplit(path, split = "_")[[1]][4]
  name_I = strsplit(str1, split="\\.")[[1]][1]
  print(name_I)

  df = read.csv(paste0(csv_dir_ips, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$DP < DP, ]))
  print(head(df[df$DP < DP, ]))
  
  dp_rng = df[df$DP > 10 && df$DP < 200, ]
  
  dp_mq_rng_df = dp_rng[dp_rng$MQ >= 50, ]
  dp_mq_rng_df
  
  # dp_mq_rng_df$MQ = round(dp_mq_rng_df$MQ)
  
  plot(dp_mq_rng_df$MQ, dp_mq_rng_df$DP,
       xlim = c(50, 60.1), cex=0.4, col = 'blue')
  
  
  break
}



old.par = par(mai=c(1, 1.0, 0.7, 0.3))
old.mfrow = par(mfrow=c(3, 5))

# 
# length(snp_teratoma_path_lst)

for (i in  1:length(snp_teratoma_path_lst)){
  str1 = strsplit(snp_teratoma_path_lst[i], split = "_")[[1]][4]
  name_T = strsplit(str1, split="\\.")[[1]][1]
  print(name_T)
  
  x_type = ifelse(length(X100[X100 == name_T] == 1), '100X',
                  ifelse(length(X200[X200 == name_T]) == 1, '200X', NULL))

  x_col = ifelse(length(X100[X100 == name_T] == 1), 'magenta',
                 ifelse(length(X200[X200 == name_T]) == 1, 'turquoise4', NULL))
  
  df_t = read.csv(paste0(csv_dir, snp_teratoma_path_lst[i]), header = T)
  df_t$CH_POS = paste(df_t$CHROM, df_t$POS, sep = '_')
  print(head(df_t))
  print(dim(df_t))
  print(dim(df_t[df_t$DP < DP, ]))
  print(head(df_t[df_t$DP < DP, ]))
  
  dp_rng_t = df_t[df_t$DP > 10 && df_t$DP < 200, ]
  
  dp_mq_rng_df_t = dp_rng_t[dp_rng_t$MQ >= 50, ]
  dp_mq_rng_df_t
  
  plot(dp_mq_rng_df_t$MQ, dp_mq_rng_df_t$DP,
       xlim = c(50, 60.1), ylim =c(0,  1200), cex=0.4, col = 'red',
       pch=18, xlab = 'MQ', ylab='DP')
  
  #break
  
  str1 = strsplit(snp_IPS_path_lst[i], split = "_")[[1]][4]
  name_I = strsplit(str1, split="\\.")[[1]][1]
  print(name_I)
  
  df_i = read.csv(paste0(csv_dir_ips, snp_IPS_path_lst[i]), header = T)
  df_i$CH_POS = paste(df_i$CHROM, df_i$POS, sep = '_')
  print(head(df_i))
  print(dim(df_i))
  
  print(dim(df_i[df_i$DP < DP, ]))
  print(head(df_i[df_i$DP < DP, ]))
  
  dp_rng_i = df_i[df_i$DP > 10 && df_i$DP < 200, ]
  
  dp_mq_rng_df_i = dp_rng_i[dp_rng_i$MQ >= 50, ]
  dp_mq_rng_df_i
  
  points(dp_mq_rng_df_i$MQ, dp_mq_rng_df_i$DP,
         xlim = c(45, 60.1), ylim = c(0,  1200), cex=0.4, col = 'blue',
         pch=18)
  
  mtext(text = x_type, col = x_col,
         side=1, line=4.8, cex = 0.7)

  legend(50, 1200, legend = c("Teratoma", "IPS"),
         pch=18, col = c('red', 'blue'),
         title = 'MQ & DP plot')
  
  mtext(text = name_T,
        side=3, line=1, srt = 90, cex = 0.8)
  mtext(text = name_I,
        side=3, line=2.3, srt = 90, cex = 0.8)
  # break
  
}

?pch
?leg


par(old.par)
par(old.mfrow)































































