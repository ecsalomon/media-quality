# Date: 2015-05-19
# Author: Erika Salomon
# Email: ecsalomon@gmail.com
# Purpose: Takes a list of journals, a list of years, and an Altmetric API key (optionaL)
#          and returns a data frame of Altmertic data
# Packages used: plyr, rAltmetric
# Licence: CC BY-SA-NC

# Parameters:
# journals : a vector of journal names (e.g., "Psychological Science")
# years : a vector of years
# key : an Altmetric API key; default is NULL
# save : save the data as a new google spreadsheet?
# name : name for the google spreadsheet
# maxresults : maximum number of papers per journal per year to return
# browser : browser to use for obtaining pubmedids

makeDataFrame <- function (journals, years, key=NULL, google=FALSE, name, 
                           maxResults=1000, browser=c("firefox", "chrome", 
                                                      "safari", "opera", 
                                                      "internet explorer")) {
  ### Load packages ###
  suppressPackageStartupMessages(require("plyr"))
  
  pmidList <- mapply(pullPMIDs, journals, years) # get PMIDs
  pmidVector <- unlist(pmidList, use.names=FALSE) # convert list to vector
  altmetrics <- getAltmetrics(pmidVector, key) # build data frame of altmetrics
  
  if(google){
    suppressPackageStartupMessages(require("googlesheets"))
    googleAltmetric <- gs_new(name)
    edit_cells(googleAltmetric, input=altmetrics, header=TRUE)
  }
  
  return(altmetrics)
}