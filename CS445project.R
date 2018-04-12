#use RODBC package
require(RODBC)
#connect to the database (use Microsoft ODBC administrator)
# https://www.youtube.com/watch?v=2xQX76nEdvo
con <- odbcConnect("CS445 ODBC data source", uid="saon", pwd="CS445project")
#currently pull all the data from the database TODO:create specific queries
allData <- sqlQuery(con, "SELECT * FROM student")
allData
majors <- allData[2]
years <- allData[3]
gpas <- allData[4]
credits <- allData[5]