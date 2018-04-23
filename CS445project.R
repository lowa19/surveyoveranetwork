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

plot(allData$major, allData$gpa)

#sample data frame
df <- data.frame("1725847", "computer science", "engineering", "junior", 18, 130, 3.2, .7, .6, .8, 1)
names(df) <- c("studentID", "major", "school_major", "year", "credits_current", "credits_taken", "gpa", "percentile_major", "percentile_school", "percentile_year", "athlete_status") 
#sqlSave(con, df, tablename = "student", append = TRUE, rownames = TRUE, colnames = FALSE, verbose = FALSE, safer = TRUE,  test = TRUE)
#sqlUpdate(con, df, tablename = "student", index = NULL, verbose = FALSE, test = FALSE, nastring = NULL, fast = TRUE)
