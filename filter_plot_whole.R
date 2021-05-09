# 샘플마다 그래프 그려줄건데, 
# 샘플별로 몇개씩 끊어서 그려주는 식으로
# 필터링 되는 부분에는 각각 줄 그어주자
# 제목은 sample명 / x축은 CHR_POS / y축은 


# hard

csv_dir = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\filter_subsets\\'

snp_ips_path_lst = list.files(path = csv_dir, 
                              pattern = "filter_subset_SNP_hiPS*")

snp_teratoma_path_lst = list.files(path = csv_dir, 
                              pattern = "filter_subset_SNP_Teratoma*")

indel_ips_path_lst = list.files(path = csv_dir, 
                              pattern = "filter_subset_INDEL_hiPS*")

indel_teratoma_path_lst = list.files(path = csv_dir, 
                              pattern = "filter_subset_INDEL_Teratoma*")

length(snp_ips_path_lst)

# , 'turquoise', 'violet', 'wheat'
DP = 30
MQ = 40
QD = 2
SOR = 3 # 3보다 큰것 필터링

old.par <- par(mai=c(1, 1, 0.7, 0.3))
old.mfrow <- par(mfrow=c(3, 5))

for (path in snp_ips_path_lst) {
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
          cex.main = 1.5, cex.lab = 1.3,
          col = c('tomato'),
          main = "DP (less than 30)",
          xlab='DP value',
          ylab='Frequency of DP')
  
  # break
}



# =============================================================================


# raw

csv_dir = 'D:\\junmo\\wd\\WES\\data\\vcf\\raw\\raw_subsets\\'

snp_ips_path_lst = list.files(path = csv_dir, 
                              pattern = "raw_subset_SNP_hiPS*")

snp_teratoma_path_lst = list.files(path = csv_dir, 
                                   pattern = "raw_subset_SNP_Teratoma*")

indel_ips_path_lst = list.files(path = csv_dir, 
                                pattern = "raw_subset_INDEL_hiPS*")

indel_teratoma_path_lst = list.files(path = csv_dir, 
                                     pattern = "raw_subset_INDEL_Teratoma*")

length(snp_ips_path_lst)

# , 'turquoise', 'violet', 'wheat'
DP = 30
MQ = 40
QD = 2
SOR = 3 # 3보다 큰것 필터링

old.par <- par(mai=c(1, 1, 0.7, 0.3))
old.mfrow <- par(mfrow=c(3, 5))

# DP

for (path in snp_teratoma_path_lst) {
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
          ylim = c(0, 2500),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.3,
          col = c('tomato'),
          main = "DP (less than 30)",
          xlab='DP value',
          ylab='Frequency of DP')
  
  # break
}



# MQ

for (path in snp_teratoma_path_lst) {
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))

  print(dim(df[df$MQ < MQ, ]))
  print(head(df[df$MQ < MQ, ]))
  low_mq = df[df$MQ < MQ, ]
  print(class(low_mq$MQ))
  a = round(low_mq$MQ)

  # print(table(low_mq[, 'MQ']))
  # freq <- table(low_mq[, 'MQ'])
  
  print(table(a))
  freq <- table(a)
  

  # mt = as.matrix(low_dp[, 3])
  # print(head(mt))
  # rownames(mt) <- low_dp$CH_POS
  # t(mt)

  barplot(freq, beside = T, las=1,
          ylim = c(0, 400),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.3,
          col = c('turquoise'),
          main = "MQ (less than 2)",
          xlab='QD value',
          ylab='Frequency of MQ')

  # break
}




# QD

for (path in snp_teratoma_path_lst) {
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$QD < QD, ]))
  print(head(df[df$QD < QD, ]))
  low_qd = df[df$QD < QD, ]
  print(class(low_qd$QD))
  a = round(low_mq$QD)
  
  # print(table(low_mq[, 'MQ']))
  # freq <- table(low_mq[, 'MQ'])
  
  print(table(a))
  freq <- table(a)
  
  
  # mt = as.matrix(low_dp[, 3])
  # print(head(mt))
  # rownames(mt) <- low_dp$CH_POS
  # t(mt)
  
  barplot(freq, beside = T, las=1,
          ylim = c(0, 200),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.3,
          col = c('violet'),
          main = "QD (less than 2)",
          xlab='QD value',
          ylab='Frequency of QD')
  
  # break
}



# SOR

for (path in snp_teratoma_path_lst) {
  df = read.csv(paste0(csv_dir, path), header = T)
  df$CH_POS = paste(df$CHROM, df$POS, sep = '_')
  print(head(df))
  print(dim(df))
  
  print(dim(df[df$SOR < SOR, ]))
  print(head(df[df$SOR < SOR, ]))
  large_sor = df[df$SOR < SOR, ]
  print(class(large_sor$SOR))
  a = round(large_sor$SOR)
  
  # print(table(low_mq[, 'MQ']))
  # freq <- table(low_mq[, 'MQ'])
  
  print(table(a))
  freq <- table(a)
  
  
  # mt = as.matrix(low_dp[, 3])
  # print(head(mt))
  # rownames(mt) <- low_dp$CH_POS
  # t(mt)
  
  barplot(freq, beside = T, las=1,
          ylim = c(0, 100000),
          cex.axis = 1.0, cex.names = 1,
          cex.main = 1.5, cex.lab = 1.3,
          col = c('steelblue'),
          main = "SOR (more than 3)",
          xlab='SOR value',
          ylab='Frequency of SOR')
  
  # break
}



























