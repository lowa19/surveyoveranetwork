#connect to the database
require(RODBC)
con <- odbcConnect("CS445 ODBC data source", uid="saon", pwd="CS445project")

#CODE TO READ FROM A CSV FILE
myUrl <- 'http://ec2-52-26-167-184.us-west-2.compute.amazonaws.com/efs-mount-point/SAoN/results/surveyResults1.csv'
download.file(myUrl, destfile = 'C:\\Users\\Kaleo\\Documents\\GitHub\\surveyoveranetwork\\test.csv')
inputs <- read.csv('C:\\Users\\Kaleo\\Documents\\GitHub\\surveyoveranetwork\\test.csv', header = TRUE, sep = ",") #need to change file path later
inputs <- data.frame(inputs) #convert to a data frame

#PUSH NEW DATA TO THE DATABASE
sqlSave(con, inputs, tablename = "student", append = TRUE, rownames = FALSE)