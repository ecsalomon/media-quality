# Date: 2015-05-19
# Author: Erika Salomon
# Email: ecsalomon@gmail.com
# Purpose: Creates a Google spreadsheet from a data frame containing Altmetric data
# Packages used: plyr, rAltmetric
# Licence: CC BY-SA-NC

# Parameters:
# pmids : a vector of PubMed IDs
# key : an Altmetric API key; default is NULL

makeDataFrame <- function (dat, key) {
  ### Load packages ###
  suppressPackageStartupMessages(require("plyr"))
  
  pmids <- llply(dat, function(x) pullPMIDs(journal=x$journals, year=x$years), .progress = 'text')
  altmetrics <- ldply(pmids, getAltmetrics)
}