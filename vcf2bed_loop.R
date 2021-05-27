
library(bedr)
# install.packages("openxlsx")
library("openxlsx")

wd = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\'
patt = 'SNP_*'

if (!dir.exists('bed')){
  dir.create('bed')
}

bed_root_dir = paste0(wd, 'bed\\')

setwd(bed_root_dir)
getwd()


file_list = list.files(wd, pattern = patt)

print(file_list[1])

class(file_list)

name_vector = c()
path_vector = c()


for (f in file_list){
  spt = strsplit(f, split = '\\.')[[1]]
  spt.last = spt[length(spt)]
  
  if (spt.last == 'gz'){
    name_vector = c(name_vector, spt[1])
    path_vector = c(path_vector, paste0(wd, f))
  }
}

name_vector
path_vector

# 각 디렉토리에 bed, xlsx 파일 생성성

for (i in 1:range(length(name_vector))){
  
  setwd(bed_root_dir)
  if (!dir.exists(name_vector[i])){
    dir.create(name_vector[i])
  }
  vcf_path = path_vector[i]
  output_dir = paste0(bed_root_dir, name_vector[i], '\\')
  output_bed = paste0(name_vector[i], '.bed')
  output_xlsx = paste0(name_vector[i], '.xlsx')
  
  vcf_f <- read.vcf(vcf_path)
  bed_f <- vcf2bed(vcf_f, other = c('REF', 'ALT'))
  setwd(output_dir)
  
  write.table(bed_f, sep='\t', file=output_bed, quote = F,
              row.names = F, col.names = F)
  write.xlsx(bed_f, file = output_xlsx)
}


