# загрузка библиотеки
library(RGA)
library("sqldf")
# авторизация

ga_token <- authorize(client.id = "44510395713-cngu0lhjk5rud2o8s3noj6qj17f7obng.apps.googleusercontent.com", client.secret = "FHsO_3tCeb4FgFXjw-GPbCTW")

TS <- get_ga(profile.id = "44835839",
                    start.date = "2015-04-20", 
                    end.date = "2015-04-20", 
                    metrics = "ga:hits,ga:sessions,ga:goal6Completions", 
                    dimensions = "ga:dimension11,ga:dimension12,ga:dimension13,ga:sourceMedium,ga:city,ga:landingPagePath",
)