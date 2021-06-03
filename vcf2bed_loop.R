
# DP 30이상의 VCF record들을 bed, xlsx 파일로 변환


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

get_DP_over_30_idx <- function(vector_){
  # print("함수 안")
  idx_vec_ <- c()
  # txt = 1
  for (i in 1:range(length(vector_))){
    # DP_info_ = strsplit(vector_[i], split = ';')[[1]][5]
    info_vec_ = strsplit(vector_[i], split = ';')[[1]] # 문자열 벡터
    
    DP_count_ = 0
    for (info in info_vec_){
      if (strsplit(info, split = '=')[[1]][1] == "DP"){
        DP_count_ = strsplit(info, split = '=')[[1]][2]
        DP_count_ = as.numeric(DP_count_)
        break
      }
    }
    
    if (DP_count_ >= 30) {
      idx_vec_ = c(idx_vec_, i)
    }
    
    # print(DP_count_)
    # if (txt ==3){
    #   print('break!!')
    #   break
    # }
    # txt = txt + 1
    
  }
  
  return(idx_vec_)
}

for (i in 1:range(length(name_vector))){
  print(name_vector[i])
  setwd(bed_root_dir)
  if (!dir.exists(name_vector[i])){
    dir.create(name_vector[i])
  }
  vcf_path = path_vector[i]
  output_dir = paste0(bed_root_dir, name_vector[i], '\\')
  output_bed = paste0(name_vector[i], '.bed')
  output_xlsx = paste0(name_vector[i], '.xlsx')
  
  vcf_f <- read.vcf(vcf_path)
  # print(class(vcf_f)) # "list"
  # print(class(vcf_f$vcf)) # "data.table" "data.frame"
  # print(class(vcf_f$vcf$INFO)) # "character" << vector
  
  # print(vcf_f$vcf$INFO[1]) # info 스트링 나열. ;구분
  DP_info = strsplit(vcf_f$vcf$INFO[1], split = ';')[[1]][5]
  # print(DP_info) # "DP=20"
  DP_count = strsplit(DP_info, split = '=')[[1]][2]
  # print(DP_count) # "20"
  DP_count = as.numeric(DP_count)
  # print(DP_count) # 20
  # print(class(DP_count)) # "numeric"
  
  idx_vec = get_DP_over_30_idx(vcf_f$vcf$INFO)
  # print(idx_vec)
  print(length(idx_vec)) # 13734
  
  vcf_f$vcf <- vcf_f$vcf[idx_vec, ]
  print(dim(vcf_f$vcf)) # 13734    10
  
  # break
  
  bed_f <- vcf2bed(vcf_f, other = c('REF', 'ALT'))
  setwd(output_dir)

  write.table(bed_f, sep='\t', file=output_bed, quote = F,
              row.names = F, col.names = F)
  write.xlsx(bed_f, file = output_xlsx)
  
}


