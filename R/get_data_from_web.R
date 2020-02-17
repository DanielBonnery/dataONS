#' Lists the datasets to downloads
#' @returns c("parish110217popest")
#' 
datasets.to.download_f<-function(){c("data/parish110217popest","inst/extdata/Parishes_December_2011_Boundaries_EW_BFC.zip")}


#' Downloads the file parish110217popest.zip from internet
#' 
#' @param directory a character string  indicating a file path (default: file.path(find.package("dataONS"))) otherwise 
#' @param datasets.to.download a vector of character strings, (default: datasets.to.download_f()). If null, the files parish110217popest.zip are downloaded.
#' 
#' @details this function is executed when loading the package for the first time.
#' @examples 
#' attach(dataONS::get_data_from_web(directory=tempdir()))# takes some time to dowload data
#' 
get_data_from_web<-function(directory=find.package("dataONS"),
                            datasets.to.download=datasets.to.download_f()){
    datasets.to.download<-datasets.to.download[!is.element(datasets.to.download,list.files(directory,recursive = TRUE))]

  L<-lapply(datasets.to.download,function(dataset.to.download){
    dir2<-file.path(directory,dirname(dataset.to.download))
    if(!file.exists(dir2)){file.create(dir2,recursive=TRUE)}
    
    if(dataset.to.download=="data/parish110217popest.rda"){
      parish110217popest<-get_parish110217popest.zip()
      if(!is.null(directory)){save(parish110217popest,file = file.path(directory,"parish110217popest.rda"))}
      if(is.null(directory)){parish110217popest}else{NULL}}
    
    if(dataset.to.download=="inst/extdata/Parishes_December_2011_Boundaries_EW_BFC.zip"){
      Parishes_December_2011_Boundaries_EW_BFC<-get_Parishes_December_2011_Boundaries_EW_BFC.zip(dir2)}})

  names(L)<-datasets.to.download
L}



#' Download, unzip and read the file parish110217popest.zip
#' 
#' @details download, unzip and read the file "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/adhocs/009305populationestimatesforparishesinenglandandwalesmid2002tomid2017/parish110217popest.zip"
#' @example 
#' parish110217popest=get_parish110217popest.zip()
#' head(parish110217popest[parish110217popest$year=="mid_2002",c("PAR11NM","Population")])

get_parish110217popest.zip<-function(){
  webfile="https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/adhocs/009305populationestimatesforparishesinenglandandwalesmid2002tomid2017/parish110217popest.zip"
  tmpf  <-tempfile()
  xxxx=downloader::download(webfile,
                            destfile = tmpf,
                            extra="--random-wait --retry-on-http-error=503")
  x=unzip(tmpf,exdir = tempdir())
  openxlsx::read.xlsx(x,sheet = 4,colNames=TRUE)}



#' Download 
#' 
#' @details downloads the file "Parishes_December_2011_Boundaries_EW_BFC.zip"
#' @example 
#' x<-get_Parishes_December_2011_Boundaries_EW_BFC.zip()
#' y<-unzip(x,exdir=tempdir())
#' z<-grep(pattern = ".shp",y,value=TRUE)
#' shapedata=rgdal::readOGR(z)
#' shapedataE04000001=subset(shapedata,par11cd=="E04000001")
#' library(leaflet)
#' leaflet()%>%addTiles() %>% addPolygons(data=shapedataE04000001,stroke=TRUE,weight=1,color="black",fillOpacity=.5)
get_Parishes_December_2011_Boundaries_EW_BFC.zip<-function(directory=tempdir()){
  webfile="https://opendata.arcgis.com/datasets/137b5ea2c69e44dfbc87cf15a4022f8a_0.zip"
  destfile=file.path(directory,"Parishes_December_2011_Boundaries_EW_BFC.zip")
  downloader::download(webfile,
                            destfile = destfile,
                            extra="--random-wait --retry-on-http-error=503")
destfile  
}

