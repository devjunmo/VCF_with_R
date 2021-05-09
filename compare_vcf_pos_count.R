
# bcftools isec으로 얻은 변이에 대한 공통/차이점 시각화

comm_path = 'D:\\junmo\\wd\\WES\\data\\vcf\\'

snp_raw_count = 'raw\\WES_Teratoma_ips_snp_count.csv'
indel_raw_count = 'raw\\WES_Teratoma_ips_indel_count.csv'

snp_cnn_count = 'cnn\\WES1_210420\\WES_Teratoma_ips_snp_count.csv'
indel_cnn_count = 'cnn\\WES1_210420\\WES_Teratoma_ips_indel_count.csv'

snp_hard_count = 'hard\\WES1_210420\\WES_Teratoma_ips_snp_count.csv'
indel_hard_count = 'hard\\WES1_210420\\WES_Teratoma_ips_indel_count.csv'

re_snp_hard_count = 're_hard\\WES_Teratoma_ips_snp_count.csv'
re_indel_hard_count = 're_hard\\WES_Teratoma_ips_indel_count.csv'



snp_raw_df = read.csv(paste0(comm_path, snp_raw_count))
indel_raw_df = read.csv(paste0(comm_path, indel_raw_count))

snp_cnn_df = read.csv(paste0(comm_path, snp_cnn_count))
indel_cnn_df = read.csv(paste0(comm_path, indel_cnn_count))

snp_hard_df = read.csv(paste0(comm_path, snp_hard_count))
indel_hard_df = read.csv(paste0(comm_path, indel_hard_count))

re_snp_hard_df = read.csv(paste0(comm_path, re_snp_hard_count))
re_indel_hard_df = read.csv(paste0(comm_path, re_indel_hard_count))


snp_raw_df
snp_cnn_df
snp_hard_df
re_snp_hard_df

indel_raw_df
indel_cnn_df
indel_hard_df
re_indel_hard_df

# barplot(snp_raw_df) << 에러코드
# ?barplot


# raw vcf

old.par <- par(mai=c(1.5, 0.6, 0.3, 0.2)) 
old.mflow <- par(mfrow=c(2,1))

mt = as.matrix(snp_raw_df[, 2:4])
rownames(mt) <- snp_raw_df$X
mt
t(mt)

barplot(t(mt), beside = T, las=2, ylim = c(0, 200000),
        cex.axis = 0.6, cex.names = 0.7,
        col = c('maroon', 'skyblue', 'snow3'),
        main = "Raw VCF(SNP)")

legend(x=1, y=200000, # 좌표 주기
       legend = c("Teratoma", "IPS", "common"),
       fill=c('maroon', 'skyblue', 'snow3'),
       title = 'position count') 

mt = as.matrix(indel_raw_df[, 2:4])
rownames(mt) <- indel_raw_df$X
mt
t(mt)

barplot(t(mt), beside = T, las=2, ylim = c(0, 10000),
        cex.axis = 0.6, cex.names = 0.7,
        col = c('maroon', 'skyblue', 'snow3'),
        main = "Raw VCF(INDEL)")

legend(x=1, y=10000, # 좌표 주기
       legend = c("Teratoma", "IPS", "common"),
       fill=c('maroon', 'skyblue', 'snow3'),
       title = 'position count', cex=0.8) 
?legend

par(old.par)
par(old.mflow)




# cnn

old.par <- par(mai=c(1.5, 0.6, 0.3, 0.2)) 
old.mflow <- par(mfrow=c(2,1))

mt = as.matrix(snp_cnn_df[, 2:4])
rownames(mt) <- snp_cnn_df$X
mt
t(mt)

barplot(t(mt), beside = T, las=2, ylim = c(0, 200000),
        cex.axis = 0.6, cex.names = 0.7,
        col = c('maroon', 'skyblue', 'snow3'),
        main = "CNN scored VCF(SNP)")

legend(x=1, y=200000, # 좌표 주기
       legend = c("Teratoma", "IPS", "common"),
       fill=c('maroon', 'skyblue', 'snow3'),
       title = 'position count') 

mt = as.matrix(indel_cnn_df[, 2:4])
rownames(mt) <- indel_cnn_df$X
mt
t(mt)

barplot(t(mt), beside = T, las=2, ylim = c(0, 10000),
        cex.axis = 0.6, cex.names = 0.7,
        cex.main = 1.0,
        col = c('maroon', 'skyblue', 'snow3'),
        main = "CNN scored VCF(INDEL)")

legend(x=1, y=10000, # 좌표 주기
       legend = c("Teratoma", "IPS", "common"),
       fill=c('maroon', 'skyblue', 'snow3'),
       title = 'position count', cex=0.8) 
?legend

par(old.par)
par(old.mflow)




# hard

old.par <- par(mai=c(1.5, 0.6, 0.3, 0.2)) 
old.mflow <- par(mfrow=c(2,1))

mt = as.matrix(snp_hard_df[, 2:4])
rownames(mt) <- snp_hard_df$X
mt
t(mt)

barplot(t(mt), beside = T, las=2, ylim = c(0, 200000),
        cex.axis = 0.6, cex.names = 0.7,
        col = c('maroon', 'skyblue', 'snow3'),
        main = "Hard filtered VCF(SNP)")

legend(x=1, y=200000, # 좌표 주기
       legend = c("Teratoma", "IPS", "common"),
       fill=c('maroon', 'skyblue', 'snow3'),
       title = 'position count') 

mt = as.matrix(indel_hard_df[, 2:4])
rownames(mt) <- indel_hard_df$X
mt
t(mt)

barplot(t(mt), beside = T, las=2, ylim = c(0, 10000),
        cex.axis = 0.6, cex.names = 0.7,
        cex.main = 1.0,
        col = c('maroon', 'skyblue', 'snow3'),
        main = "Hard filtered VCF(INDEL)")

legend(x=1, y=10000, # 좌표 주기
       legend = c("Teratoma", "IPS", "common"),
       fill=c('maroon', 'skyblue', 'snow3'),
       title = 'position count', cex=0.8) 
?legend

par(old.par)
par(old.mflow)










































  