#' Lists the datasets to downloads
#' @returns c("parish110217popest")
#' 
datasets.to.download_f<-function(){c("parish110217popest")}


#' Downloads the file parish110217popest.zip from internet
#' 
#' @param directory a character string  indicating a file path (default: file.path(find.package("dataONS"),'data')) otherwise 
#' @param datasets.to.download a vector of character strings, (default:c("parish110217popest")). If null, the files parish110217popest.zip are downloaded.
#' 
#' @details this function is executed when loading the package for the first time.
#' @examples 
#' attach(dataONS::get_data_from_web(directory=NULL))# takes some time to dowload data
#' 
get_data_from_web<-function(directory=if(file.exists(try(file.path(find.package("dataONS"),'data')))){
  file.path(find.package("dataONS"),'data')}else{NULL},
  datasets.to.download=datasets.to.download_f()){
  L<-lapply(datasets.to.download,function(dataset.to.download){
    if(dataset.to.download=="parish110217popest"){
      parish110217popest<-get_parish110217popest.zip()
      if(!is.null(directory)){save(parish110217popest,file = file.path(directory,"parish110217popest.rda"))}
      if(is.null(directory)){parish110217popest}else{NULL}
    }})
  names(L)<-datasets.to.download
  L}
  


#' Download, unzip and read the file parish110217popest.zip from internet
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