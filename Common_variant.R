
C_DIR = 'D:\\junmo\\wd\\WES\\data\\vcf\\hard\\WES1_210420\\commons\\subsets\\'

snp_teratoma_path_lst = list.files(path = T_DIR, 
                                   pattern = "subset_SNP_T*")

indel_teratoma_path_lst = list.files(path = T_DIR, 
                                     pattern = "subset_INDEL_T*")

snp_Origin_path_lst = list.files(path = O_DIR, 
                                 pattern = "subset_SNP_h*")

indel_Origin_path_lst = list.files(path = O_DIR, 
                                   pattern = "subset_INDEL_h*")


for (i in 1:range(length(snp_Origin_path_lst))){
  if (i == 1){
    print("## SNP_Origin-specific ##")
  }
  df = read.csv(paste0(C_DIR, snp_Origin_path_lst[i]), header = T)
  str1 = strsplit(snp_Origin_path_lst[i], split = "_")[[1]][3]
  name = strsplit(str1, split="\\.")[[1]][1]
  print(name)
  print(dim(df)[1])
}

for (i in 1:range(length(indel_Origin_path_lst))){
  if (i == 1){
    print("## IND_Origin-specific ##")
  }
  df = read.csv(paste0(C_DIR, indel_Origin_path_lst[i]), header = T)
  str1 = strsplit(indel_Origin_path_lst[i], split = "_")[[1]][3]
  name = strsplit(str1, split="\\.")[[1]][1]
  print(name)
  print(dim(df)[1])
}

