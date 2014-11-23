library(sqldf)
library(ggplot2)
library(scales)
library(GetoptLong)
library(Hmisc)

script_dir = function() {
  return(dirname(sys.frame(1)$ofile))
}

#
# Starts the correct platform-specific renderer
#

start_renderer = function() {
  if(Sys.info()['sysname'] == "Darwin") {
    quartz()
  } else {
    x11()
  }
}

#
# calls SQL on the correct database and returns data
#

execute_sql = function(query, database) {
  if(missing(database)) {
    database = file.path(script_dir(), "../../sql/data.sqlite")
  }
  data = sqldf(query, dbname=database)
  return(data)
}

get_pvalue = function(matrix, x, y) {

  if(x == y) {
    return(1)
  }

  value = tryCatch(matrix[x,y], error=function(e) NA)
  if(is.na(value)) {
    value = tryCatch(matrix[y,x], error=function(e) NA)
  }
  return(value)
}
