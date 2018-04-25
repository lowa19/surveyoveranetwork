#use RODBC package
require(RODBC)
require(ggplot2)
require(reshape2)
#connect to the database
con <- odbcConnect("CS445 ODBC data source", uid="saon", pwd="CS445project")
#returns the table as a data.frame with 11 variables/columns
allData <- sqlQuery(con, "SELECT * FROM student")

#CREATE GRAPH AND EXPORT TO PNG
plot(allData$major, allData$gpa)
dev.copy(png, "graph.png")
dev.off()
