
library(bedr)

wd = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Td30_Odx\\pass_only_Teratoma_specifics\\'
patt = '*.vcf.gz'

setwd(wd)
getwd()

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


for (i in 1:range(length(name_vector))){
  
  T_specific_vcf <- read.vcf(path_vector[i])
  T.bed <- vcf2bed(T_specific_vcf)
  output_path = paste0(name_vector[i],'.bed')
  
  write.table(T.bed, sep='\t', file=output_path, quote = F,
              row.names = F, col.names = F)
}




























