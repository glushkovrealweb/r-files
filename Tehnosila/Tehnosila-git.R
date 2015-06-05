# загрузка библиотеки
library(RGA)
library("sqldf")
# авторизация

ga_token <- authorize(client.id = "44510395713-cngu0lhjk5rud2o8s3noj6qj17f7obng.apps.googleusercontent.com", client.secret = "FHsO_3tCeb4FgFXjw-GPbCTW")


dateStart <-"2015-04-23"
dateEnd <-"2015-04-26"
dates <- seq(as.Date(dateStart), as.Date(dateEnd), by = "days")

TSrawData <- do.call(
  rbind, lapply(dates, function(d) {
    tehnosila <- get_ga(profile.id = "100821824",
                        start.date = d, 
                        end.date = d, 
                        metrics = "ga:hits,ga:transactions,ga:productAddsToCart", 
                        dimensions = "ga:dimension1,ga:dimension2,ga:dimension3,ga:dimension4,ga:sourceMedium,ga:city,ga:pagePath"
                        
    )
  })
)
