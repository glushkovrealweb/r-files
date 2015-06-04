# загрузка библиотеки
library(RGA)
library("sqldf")
library("reshape2")
library("gplots")
# авторизация

ga_token <- authorize(client.id = "44510395713-cngu0lhjk5rud2o8s3noj6qj17f7obng.apps.googleusercontent.com", client.secret = "FHsO_3tCeb4FgFXjw-GPbCTW")

hilding <- get_ga(profile.id = "82899357",
                    start.date = "2015-03-1", 
                    end.date = "2015-03-31", 
                    metrics = "ga:hits", 
                    dimensions = "ga:pagePath,ga:eventLabel",
                    filter = "ga:eventCategory=~scroll;ga:hits>1"
                    
)

khm <- dcast(hilding, page.path~event.label)
khm[is.na(khm)]<-0

khm[,2:5] <- round(khm[,2:5]*100/khm[,6], digits = 1)
khm <- khm[khm$Baseline>100,]

khm1 <- khm[,2:5]
rownames(khm1)<-khm$page.path
#Не красивый график
d <- dist(as.matrix(khm1))   # find distance matrix 
hc <- hclust(d)                # apply hirarchical clustering 
plot(hc)

#красивый график
colfunc <- colorRampPalette(c("white", "steelblue"))
heatmap.2(as.matrix(khm1),
          main = "Доли просмотренных страниц по источникам",
          xlab = "Весь трафик на лендинг",
          ylab = "Просмотренные страницы, кроме лендинга222",
          mar=c(10,18),
          scale="column",
          col=colfunc(15),
          cellnote = as.matrix(khm1),
          notecex=0.8,
          notecol="black",
          trace = "none",
          linecol = "#FF5454",
          tracecol = "#FF5454",
          cexCol=0.9,
          cexRow=0.8)


#приводим к рабочему виду
colnames(hilding) <- gsub("\\.","_",colnames(hilding))

data44<-sqldf("SELECT page_path,event_label,hits,(1.0 *hits/(select sum(hits) from hilding where page_path like '/krovati/' ))*100 as 'percent' 
              from hilding where page_path like '/krovati/' 
              order by hits desc");

data54<-sqldf("SELECT page_path,event_label,hits from hilding where  hits > 5 order by hits desc");

data55<-sqldf("SELECT page_path,sum(hits) as summHits from hilding where  hits > 5 group by page_path order by hits desc");






data66<-sqldf("SELECT page_path,event_label,hits,(1.0*hits/summHits)*100 as pecentHits from 
          (SELECT page_path,event_label,hits from hilding where  hits > 5) as t1 
              
              left join (SELECT page_path,max(hits) as summHits from hilding where  hits > 5 group by page_path)
              using(page_path)  where event_label not like 'Baseline' and hits > 25 and event_label like '%75%' order by pecentHits desc");


data77 <- dcast(data66, page_path~event_label)