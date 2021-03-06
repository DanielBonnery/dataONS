.onLoad<- function(libname, pkgname) {
  if(!all(is.element(datasets.to.download_f(),
                     list.files(file.path(find.package("dataONS")),recursive= T)))){
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
    get_data_from_web() 
  }}