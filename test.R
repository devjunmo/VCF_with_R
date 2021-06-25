
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
    
# BiocManager::install(version = "3.13")

# BiocManager::install("DriverNet")

library(DriverNet)

data(samplePatientMutationMatrix)
data(samplePatientOutlierMatrix)
data(sampleInfluenceGraph)
data(sampleGeneNames)

sPMM = samplePatientMutationMatrix
sPOM = samplePatientOutlierMatrix
sIG = sampleInfluenceGraph
sGN = sampleGeneNames

head(sPMM)
head(sPOM)
head(sIG)
head(sGN)
