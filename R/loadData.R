
## Load the codes
GEM <- read.table("2018_I9gem.txt",
           colClasses = "character",
           col.names = c("ICD9", "ICD10", "flag"))

# Extracting flags 
colNames <- c('approximate','noMap','combination','scenario','choicelist')
for (i in 1:5){
  GEM[,i+3] <- as.integer(substring(GEM[,3],i,i))
  names(GEM)[i+3] <- colNames[i]
}

saveRDS(GEM, 'GEM.RDS')
