require(htmlwidgets)
require(plotly)
require(plyr)

# Some SQL code
# SELECT AVG(GPA) FROM student WHERE major = "computer science"

# Create fake DB
testdf <- data.frame(1725847, "computer science", "engineering", "freshman", 18, 130, 3.2, .7, .6, .8, 1, stringsAsFactors = FALSE)
names(testdf) <- c("studentID", "major", "school_major", "year", "credits_current", "credits_taken", "gpa", "percentile_major", "percentile_school", "percentile_year", "athlete_status") 
testdf<- rbind(testdf, c(1234561, "computer science", "engineering", "sophomore", 12, 100, 3.5, .5, .4, .8, 1),
                      c(1122111, "finance", "business", "junior", 17, 100, 2.1, .5, .4, .3, 1),
                      c(1114111, "biology", "arts and sciences", "freshman", 17, 100, 3.3, .5, .4, .75, 1),
                      c(1116111, "psychology", "arts and sciences", "sophomore", 17, 100, 3.5, .5, .4, .5, 1),
                      c(1111811, "mechanical engineering", "engineering", "junior", 17, 100, 3.6, .5, .4, 0.75, 1),
                      c(1111011, "finance", "business", "freshman", 17, 100, 3.2, .5, .4, .5, 1),
                      c(1111911, "finance", "business", "sophomore", 17, 100, 2.6, .5, .4, .75, 1),
                      c(1112311, "finance", "business", "senior", 17, 100, 3.3, .5, .4, .75, 1),
                      c(1111013, "electrical engineering", "engineering", "senior", 17, 100, 3.2, .5, .4, .75, 1),
                      c(1111914, "finance", "business", "junior", 17, 100, 2.6, .5, .4, .3, 1),
                      c(1112315, "biology", "arts and sciences", "senior", 17, 100, 3.5, .5, .4, 1, 1),
                      c(1111416, "psychology", "arts and sciences", "junior", 17, 100, 4.0, .5, .4, 1, 1)
)

# Plot pie chart using plotly
pie <- plot_ly(testdf, labels = count(testdf$major)$x, values = count(testdf$major)$freq, type = 'pie', textinfo = 'label') %>%
  layout(title = 'Distribution of majors filling out this survey',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

# Histogram using plotly
hist <- plot_ly(x = testdf$gpa, type = "histogram") %>%
  layout(title = 'GPA histogram',
         yaxis = list(title = 'GPA'))

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
  layout(title = 'Average GPA per school and year',
    yaxis = list(title = 'Average GPA'), barmode = 'group')

# Scatter on how smart people think they are
# seq(1,length(testdf[,1]),1)
scatter <- plot_ly(data = testdf, x = ~gpa, y = ~percentile_year, color = ~school_major, type = 'scatter' , mode = 'markers', marker = list(size = 10)) %>%
  layout(title = 'Scatter on GPA versus guessed percentile in year',
         yaxis = list(title = 'Percentile'),
         xaxis = list(title = 'GPA'))


# Export a single widget to html
# htmlwidgets::saveWidget(as_widget(p), selfcontained = TRUE, file = "~/Google Drive/Studie/MBA 2 2017-2018/Computer Networks and Internetworking/SAoN/graph.html")

# Export multiple widgets to html
widgetList<- list(as_widget(pie), as_widget(hist), as_widget(groupbar), as_widget(scatter))
htmltools::save_html( widgetList, file = "~/Google Drive/Studie/MBA 2 2017-2018/Computer Networks and Internetworking/SAoN/graphs.html")

