# Overview
aou.bucket contains functions to read, write, copy, and remove files from the workspace bucket to the local workspace.

# Installation
In an R notebook on the AOU workbench:
```r
devtools::install_github("annisjs/aou.bucket,upgrade=F)
```

# Example
```r
library(aou.bucket)
write.csv(c(1,2,3),"mydata.csv")
cp_to_bucket("mydata.csv","mydata.csv")
ls_bucket()
file.remove("mydata.csv")
list.files() # mydata.csv is not listed
cp_from_bucket("mydata.csv",".")
list.files() # mydata.csv has been copied
rm_bucket("mydata.csv")
ls_bucket()