.onLoad<- function(libname, pkgname) {
  if(!all(is.element(paste0("aspep",outer(c(2007,2009:2012),c(".rda","_gov.rda"),paste0)),
                     list.files(file.path(find.package("dataASPEP"),"data"))))){
    packageStartupMessage(
"
###########################################################
# This is the first time the package dataONS is loaded.   #
# Or all the data has not been downloaded yet.            #
# The command :                                           #
#                                                         #
#       get_data_from_web()                               #
#                                                         #
# will be executed.                                       #
# Data is going to be downloaded from the  ONS Website.   #
# A connection to the web is needed.                      #
# This takes time (less than 10 minutes though).          #
###########################################################
")
  }}