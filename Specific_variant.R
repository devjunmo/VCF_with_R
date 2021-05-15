# 데이터 불러오기


T_DIR = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Teratoma_specifics\\subsets\\'
O_DIR = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\Origin_specifics\\subsets\\'

snp_teratoma_path_lst = list.files(path = T_DIR, 
                                   pattern = "subset_SNP*")

indel_teratoma_path_lst = list.files(path = T_DIR, 
                                     pattern = "subset_INDEL*")

snp_Origin_path_lst = list.files(path = O_DIR, 
                                 pattern = "subset_SNP*")

indel_Origin_path_lst = list.files(path = O_DIR, 
                                   pattern = "subset_INDEL*")

length(snp_teratoma_path_lst)
length(indel_teratoma_path_lst)
length(snp_Origin_path_lst)
length(indel_Origin_path_lst)


for (i in 1:range(length(snp_teratoma_path_lst))){
  if (i == 1){
    print("## SNP_Teratoma-specific ##")
  }
  df = read.csv(paste0(T_DIR, snp_teratoma_path_lst[i]), header = T)
  str1 = strsplit(snp_teratoma_path_lst[i], split = "_")[[1]][3]
  name = strsplit(str1, split="\\.")[[1]][1]
  print(name)
  print(dim(df)[1])
}

for (i in 1:range(length(indel_teratoma_path_lst))){
  if (i == 1){
    print("## INDEL_Teratoma-specific ##")
  }
  df = read.csv(paste0(T_DIR, indel_teratoma_path_lst[i]), header = T)
  str1 = strsplit(indel_teratoma_path_lst[i], split = "_")[[1]][3]
  name = strsplit(str1, split="\\.")[[1]][1]
  print(name)
  print(dim(df)[1])
  
}

for (i in 1:range(length(snp_Origin_path_lst))){
  if (i == 1){
    print("## SNP_Origin-specific ##")
  }
  df = read.csv(paste0(O_DIR, snp_Origin_path_lst[i]), header = T)
  str1 = strsplit(snp_Origin_path_lst[i], split = "_")[[1]][3]
  name = strsplit(str1, split="\\.")[[1]][1]
  print(name)
  print(dim(df)[1])
}

for (i in 1:range(length(indel_Origin_path_lst))){
  if (i == 1){
    print("## SNP_Origin-specific ##")
  }
  df = read.csv(paste0(O_DIR, indel_Origin_path_lst[i]), header = T)
  str1 = strsplit(indel_Origin_path_lst[i], split = "_")[[1]][3]
  name = strsplit(str1, split="\\.")[[1]][1]
  print(name)
  print(dim(df)[1])
}
















































