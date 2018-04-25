#connect to the database
require(RODBC)
con <- odbcConnect("CS445 ODBC data source", uid="saon", pwd="CS445project")

#CODE TO READ FROM A CSV FILE
inputs <- read.csv(file = "test.csv", header = TRUE, sep = ",") #need to change file path later
inputs <- data.frame(inputs) #convert to a data frame

#sample data frame
df <- data.frame(1725847, "computer science", "engineering", "junior", 18, 130, 3.2, .7, .6, .8, 1)
names(df) <- c("studentID", "major", "school_major", "year", "credits_current", "credits_taken", "gpa", "percentile_major", "percentile_school", "percentile_year", "athlete_status") 

#PUSH NEW DATA TO THE DATABASE
sqlSave(con, df, tablename = "student", append = TRUE, rownames = FALSE) #change df later to the csv data frame