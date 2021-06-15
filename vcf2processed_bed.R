
# vcf파일에서 특정 조건으로 행 컷하기
# PASS / DP / GT
# GT, PASS 코딩

#install.packages('stringr')

library(bedr)
library(dplyr)
library(stringr)


# input_dir = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\'
# input_dir = '/data_244/WES/no_DP_filter_samples/pass_only_Teratoma_specifics/'
# input_dir = '/data_244/WES/T_DP_O_NDP_samples/'
input_dir = '/data_244/WES/Tsp_annotation_210608/no_DP_filter/'
output_dir_name = 'teratoma_specific_processed_bed_210609/'
output_dir = paste0(input_dir, output_dir_name)
# patt_prefix = '^hard*'
# patt_surfix = '.vcf.gz$'
patt_surfix = '.vcf.gz$'

old.wd <- setwd(input_dir)
# getwd()

if (!dir.exists(output_dir_name)){
  dir.create(output_dir_name)
}


# file_list = list.files(input_dir, pattern = patt_prefix) # hardFiltered ~ 
# file_list = file_list[str_detect(file_list, pattern = patt_surfix)] # ~ vcf.gz

file_list = list.files(input_dir, pattern = patt_surfix) 

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

name_vector
path_vector
length(name_vector)

rm_idx = c()


for (i in 1:range(length(name_vector))){
  
  sample_vcf <- read.vcf(path_vector[i])
  sample_vcf$header <- c(sample_vcf$header, NOTE="vcf processed by bedr")
  print(name_vector[i])
  vcf_part = sample_vcf$vcf
  print(dim(vcf_part))
  # vcf_part[, 10]
  
  for (j in 1:range(dim(vcf_part[, 10])[1])){
    gt = strsplit(toString(vcf_part[j, 10]), split = ':')[[1]][1]
    
    if(!(gt == "0/1" || gt == "1/1")){
      rm_idx <- c(rm_idx, j)
    }
    
    filter_info = toString(vcf_part[j, 7])
    
    if(!(filter_info == "PASS")){
      rm_idx <- c(rm_idx, j)
    }
  }
  
  rm_idx <- unique(rm_idx)
  
  vcf_part <- vcf_part[-rm_idx, ]
  
  print(dim(vcf_part))
  
  sample_vcf$vcf <- vcf_part
  
  T.bed <- vcf2bed(sample_vcf, other = c('REF', 'ALT'))

  output_name = paste0(output_dir_name, name_vector[i],'.bed')
  
  write.table(T.bed, sep='\t', file=output_name, quote = F,
              row.names = F, col.names = F)
  
  rm_idx <- c()

}

setwd(old.wd)


#?bedr
#?read.vcf
#?write.vcf
#?write.table

























