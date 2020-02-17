get_data_from_web<-function(directory=if(file.exists(try(file.path(find.package("dataONS"),'data')))){
  file.path(find.package("dataONS"),'data')}else{NULL}){
  webfile="https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/adhocs/009305populationestimatesforparishesinenglandandwalesmid2002tomid2017/parish110217popest.zip"
  tmpf  <-tempfile()
  xxxx=try(download.file(url=data.url,destfile = tmpf,method="wget",extra="--random-wait --retry-on-http-error=503"))
  Sys.sleep(sample(20, 1))
  while(is.element("try-error",class(xxxx))){
      warning(paste0("Have to try to download ",data.url," again, previous attempt failed"))
      download.file(url=data.url,destfile = tmpf,method="wget",extra="--random-wait --retry-on-http-error=503")
      Sys.sleep(sample(20, 1))
    }
    Sys.sleep(sample(10, 1))
    x=unzip(tmpf,exdir = tempdir())
    y<-read.fwf(x,width=format.table$length,
                header=FALSE,
                colClasses=c("character","numeric","numeric")[format.table$class],fill=TRUE)
    y<-y[format.table$variable!=""]
    names(y)<-format.table$variable[format.table$variable!=""]
    reformat(y)}
  L1<-lapply(c("07cempst.zip","09empst.zip","10empst.zip","11empst.zip","12cempst.zip"),get_data_from_webs,
         format.table=read.csv(system.file("extdata","data_format.csv",package="dataASPEP")))
  L2<-lapply(c("07cempid.zip","09empid.zip","10empid.zip","11empid.zip","12cempid.zip"),get_data_from_webs,
         format.table=read.csv(system.file("extdata","id_format.csv",package="dataASPEP")))
  names(L1)<-paste0("aspep",years)
  names(L2)<-paste0("aspep",years,"_gov")
  listofids<-unique(unlist(lapply(L1,function(x){x$id})))
  attach(L1);attach(L2)
  if(!is.null(directory)){
    cat(paste(paste0("aspep",outer(years,c("","_gov"),paste0)),collapse="\n"),file=file.path(directory,'datalist'))}
  for (x in c(names(L1),names(L2))){
    savetopackage=TRUE
    eval(parse(text=paste0(x,"$id=factor(",x,"$id,levels=listofids);if(savetopackage){save(",x,",file=file.path(directory,'/",x,".rda'))}")))}
  if(!savetopackage){return(c(L1,L2))}}