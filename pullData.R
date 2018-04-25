#packages
require(RODBC)
require(gridExtra)
require(htmlwidgets)
require(plotly)
require(plyr)
#connect to the database
con <- odbcConnect("CS445 ODBC data source", uid="saon", pwd="CS445project")
#returns the table as a data.frame with 11 variables/columns
testdf <- sqlQuery(con, "SELECT * FROM student")

# Grouped bar chart with average GPA per school/year
freshman<- testdf[testdf$year == "freshman",]
FRgpa<- aggregate(as.numeric(freshman$gpa), list(freshman$school), mean)
sophomore<- testdf[testdf$year == "sophomore",]
SOgpa<- aggregate(as.numeric(sophomore$gpa), list(sophomore$school), mean)
junior<- testdf[testdf$year == "junior",]
JUgpa<- aggregate(as.numeric(junior$gpa), list(junior$school), mean)
senior<- testdf[testdf$year == "senior",]
SEgpa<- aggregate(as.numeric(senior$gpa), list(senior$school), mean)

schools<- unique(testdf$school)
yeardf<- data.frame(schools, FRgpa$x, SOgpa$x, JUgpa$x, SEgpa$x)
groupbar <- plot_ly(yeardf, x = schools, y = ~FRgpa$x, type = 'bar', name = 'Freshman') %>%
  add_trace(y = ~SOgpa$x, name = 'Sophomore') %>%
  add_trace(y = ~JUgpa$x, name = 'Junior') %>%
  add_trace(y = ~SEgpa$x, name = 'Senior') %>%
  layout(yaxis = list(title = 'Average GPA'), barmode = 'group')

# Histogram using plotly
hist <- plot_ly(x = testdf$gpa, type = "histogram")

# Plot pie chart using plotly
pie <- plot_ly(testdf, labels = count(testdf$major)$x, values = count(testdf$major)$freq, type = 'pie') %>%
  layout(title = 'People with major filling out the survey',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

# Export a single widget to html
# htmlwidgets::saveWidget(as_widget(p), selfcontained = TRUE, file = "~/Google Drive/Studie/MBA 2 2017-2018/Computer Networks and Internetworking/SAoN/graph.html")

# Export multiple widgets to html
htmltools::save_html(list(as_widget(pie), as_widget(hist), as_widget(groupbar)), file = "~/Google Drive/Studie/MBA 2 2017-2018/Computer Networks and Internetworking/SAoN/graph.html")