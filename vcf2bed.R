
# vcf2bed

# T-specific SNP vcf (Teratoma-6)

library(bedr)

T6_specific_SNP_path = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics_pass_only\\SNP_Teratoma-6.vcf.gz'

out_path = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\bed\\SNP_Teratoma-6.bed'

?system.file

T6_specific_SNP_vcf <- read.vcf(T6_specific_SNP_path)

head(T6_specific_SNP_vcf)

T6.bed <- vcf2bed(T6_specific_SNP_vcf)

head(T6.bed)

class(T6.bed) # df

setwd('D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\bed')
getwd()

write.table(T6.bed, sep='\t', file='SNP_Teratoma-6.bed', quote = F,
            row.names = F, col.names = F)

# install.packages("openxlsx")
library("openxlsx")
write.xlsx(T6.bed, file = "SNP_Teratoma-6.xlsx")



# REF ALT 있는 bed file 만들기 

T6_specific_SNP_path = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\SNP_Teratoma-6.vcf.gz'

out_path = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\bed\\SNP_Teratoma-6_plus.bed'

T6_specific_SNP_vcf <- read.vcf(T6_specific_SNP_path)
?vcf2bed
T6.bed <- vcf2bed(T6_specific_SNP_vcf, other = c('REF', 'ALT'))


head(T6.bed)

setwd('D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\bed')
getwd()

library("openxlsx")
write.xlsx(T6.bed, file = "SNP_Teratoma-6.xlsx")











