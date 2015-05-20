# Date: 2015-05-19
# Author: Erika Salomon
# Email: ecsalomon@gmail.com
# Purpose: Takes a vector of PubMed IDs and an Altmetric API key and returns a data frame 
#          of Altmetrics data for those PMIDs
# Packages used: plyr, rAltmetric
# Licence: CC BY-SA-NC

# Parameters:
# pmids : a vector of PubMed IDs
# key : an Altmetric API key; default is NULL

getAltmetrics <- function(pmids, key = NULL){
  ### Load Packages ### 
  suppressPackageStartupMessages(require("plyr"))
  suppressPackageStartupMessages(require("rAltmetric"))
  
  ### Get the Altmetrics data ###
  raw_metrics <- llply(pmids, function(x) altmetrics(pmid = as.character(x), apikey=key), .progress = 'text')
  metric_data <- ldply(raw_metrics, altmetric_data)
  return(metric_data)
}

