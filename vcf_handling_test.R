

# vcf파일 핸들링 연습코드


library(bedr)
library(dplyr)
library(stringr)

input_dir = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\'
output_dir_name = 'processed_teratoma_sample\\'
output_dir = paste0(input_dir, output_dir_name)
patt_prefix = '^hard*'
patt_surfix = '.vcf.gz$'

setwd(input_dir)
getwd()

if (!dir.exists(output_dir_name)){
  dir.create(output_dir_name)
}


file_list = list.files(input_dir, pattern = patt_prefix) # hardFiltered ~ 
file_list = file_list[str_detect(file_list, pattern = patt_surfix)] # ~ vcf.gz

print(file_list)

name_vector = c()
path_vector = c()


for (f in file_list){
  spt = strsplit(f, split = '\\.')[[1]]
  spt.last = spt[length(spt)]
  
  if (spt.last == 'gz'){
    name_vector = c(name_vector, spt[1])
    path_vector = c(path_vector, paste0(input_dir, f))
  }
}



sample_vcf <- read.vcf(path_vector[1])
print(class(sample_vcf)) # list
print(str(sample_vcf))
sample_vcf$vcf

print(class(sample_vcf$header)) # list
print(str(sample_vcf$header))
print(class(sample_vcf$header$FILTER))

vcf_part = sample_vcf$vcf
print(class(vcf_part)) # df
print(str(vcf_part))

filters = select(vcf_part, FILTER)
print(filters)

print(class(vcf_part$INFO)) # vector
print(str(vcf_part$INFO))

vcf_part$INFO
str1 = strsplit(vcf_part$INFO, split = ";")[[1]][1]
str1

class(vcf_part$hESO14)
# [1~i][split :]
vcf_part$hESO14[1]


str2 = strsplit(vcf_part$hESO14[1], split = ':')[[1]][1] # GT
str2
str2 <- "2/1"

if(!(str2 == "0/1" || str2 == "1/1")){
  print("dd") # 여기다가 filter 메소드
}

mychr <- "CHROM"


vcf_part[1, 7]# filter
toString(vcf_part[1, 7])

vcf_part[, 10] # sample정보 컬럼
dim(vcf_part[, 10])[1]
class(vcf_part[, 10])
vcf_part[, 10][1]
vcf_part[1, 10]




















