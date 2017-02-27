## R Programming Quiz 1
getwd()
#Change to working directory ./IFG/Coursera
#Load quiz data
data <- read.csv("hw1_data.csv")

#In the dataset provided for this Quiz, what are the column names of the dataset?
data[1, ] OR
colnames(data)

#Extract the first 2 rows of the data frame and print them to the 
# console. What does the output look like?
FirstLines <- data[1:2,]
FirstLines

#How many observations (i.e. rows) are in this data frame?
nrow(data)

#Extract the last 2 rows of the data frame and print them 
# to the console. What does the output look like?
n = nrow(data)
m = n - 1
LastLines <- data[m:n,]
LastLines

#What is the value of Ozone in the 47th row?
data$Ozone[47]

#How many missing values are in the Ozone column of this data frame?
NaNum <- is.na(data$Ozone)
as.numeric(NaNum)
sum(NaNum)

#What is the mean of the Ozone column in this dataset? Exclude 
# missing values (coded as NA) from this calculation.
Ozone <- data$Ozone[!NaNum] OR Ozone <- na.omit(data$Ozone)
as.numeric(Ozone)
mean(Ozone)

#Extract the subset of rows of the data frame where Ozone values are above 31 and Temp 
# values are above 90. What is the mean of Solar.R in this subset?
data.Oz31 <- data[data$Ozone > 31, , drop = FALSE]
data.Temp90 <- data.Oz31[data.Oz31$Temp > 90, , drop = FALSE]
data.Sol <- na.omit(data.Temp90)
mean(data.Sol$Solar.R)

#What is the mean of "Temp" when "Month" is equal to 6?
data.June <- data[data$Month == 6, , drop = FALSE]
mean(data.June$Temp)

#What was the maximum ozone value in the month of May (i.e. Month = 5)?
data.May <- data[data$Month == 5, , drop = FALSE]
data.MayNa <- na.omit(data.May)
max(data.MayNa$Ozone)

Contact GitHub API Training Shop Blog About
© 2017 GitHub, Inc. Terms Privacy Security 
