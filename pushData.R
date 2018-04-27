#connect to the database
require(RODBC)
con <- odbcConnect("CS445 ODBC data source", uid="saon", pwd="CS445project")

#CODE TO READ FROM A CSV FILE
inputs <- read.csv(url("https://www.something.com"), header = TRUE, sep = ",") #need to change file path later
inputs <- data.frame(inputs) #convert to a data frame

#sample data frame
testdf <- data.frame(1111416, "psychology", "arts and sciences", "junior", 17, 100, 4.0, .5, .4, .3, 1)
names(testdf) <- c("studentID", "major", "school_major", "year", "credits_current", "credits_taken", "gpa", "percentile_major", "percentile_school", "percentile_year", "athlete_status") 

#PUSH NEW DATA TO THE DATABASE
sqlSave(con, testdf, tablename = "student", append = TRUE, rownames = FALSE) #change df later to the csv data frame