#use RODBC package
require(RODBC)
require(ggplot2)
require(reshape2)
#connect to the database (use Microsoft ODBC administrator)
# https://www.youtube.com/watch?v=2xQX76nEdvo
con <- odbcConnect("CS445 ODBC data source", uid="saon", pwd="CS445project")
#currently pull all the data from the database TODO:create specific queries
#returns the table as a data.frame with 11 variables/columns
allData <- sqlQuery(con, "SELECT * FROM student")
#dim() displays the rows,cols of the dataframe
#str() displays the data type
#summary(allData)

#CREATE GRAPH AND EXPORT TO PNG
plot(allData$major, allData$gpa)
dev.copy(png, "graph.png")
dev.off()