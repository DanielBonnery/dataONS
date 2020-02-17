#' Unzips and converts to R spatial data the external dataset Parishes_December_2011_Boundaries_EW_BFC.zip
#'
#' @details when the package dataONS is first loaded, the dataset  
#' 'Parishes_December_2011_Boundaries_EW_BFC.zip' is downloaded
#' from ONS website and saved in 
#' file.path(find.package("datagovuk"),'inst/extdata/Parishes_December_2011_Boundaries_EW_BFC.zip')
#' This function reads the file and converts it to an object of class
#'  - c("SpatialPolygonsDataFrame", "sp") if package="rgdal" option is used.
#'  @param package used to convert the ESRI .shp file contained in the zip file. (only "rgdal" available now.)
#'  @example 
#'  demo(map.uk.parish)
dataParishes_December_2011_Boundaries_EW_BFC<-function(package="rgdal"){

  x=file.path(find.package("dataONS"),'inst/extdata/Parishes_December_2011_Boundaries_EW_BFC.zip')
  unzip(x,exdir=tempdir())
  if(package=="rgdal"){
    library(sp)
    library(rgdal)
    shapeData <- rgdal::readOGR(file.path(tempdir(),"Parishes_December_2011_Boundaries_EW_BFC.shp"))
    shapeData <- sp::spTransform(shapeData, sp::CRS("+proj=longlat"))
  }
  shapeData}
