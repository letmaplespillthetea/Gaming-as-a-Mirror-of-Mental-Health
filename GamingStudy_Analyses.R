############################################################
### Gaming and its Association with Anxiety,            ####
### Life Satisfaction and Social Phobia                 ####
### (Data Set) - Analysis                               ####
############################################################
############################################################
### Code by:                                            ####
###         Marian Sauter  www.mariansauter.de          ####
###          & Dejan Draschkow  www.draschkow.com       ####
### Licensed under CC-BY Attribution 4.0 International  ####
### https://creativecommons.org/licenses/by/4.0/        ####
############################################################
# The file which is loaded below still includes all variables.
# Game titles are normalized, top 10 games ranked, rest grouped as "Other".
# 
# VARIABLES OF INTEREST
# 
# VARIABLE[S]   TYPE      EXPLANATION
# ------------------------------------------------------
# Hours         num       Hours played
# streams       num       Additionnal hours dealing with the Game except playing
# Game          char      Which Game did the play the most?

# SPIN_T        num       total SPIN score
# SPIN_T[1-17]  num       individual SPIN item scores
# GAD_T         num       total GAD score 
# GAD[1-7]      num       individual GAD item scores
# SWL_T         num       total SWL score 
# SWL[1-5]      num       individual SWL item scores
# Narcissism    num       Score of the 1-item Narcissism scale
# 
# Birthplace    char      Country of Birth
# Residence     char      Country of Residence
# Age           num       Age
# Work          char      Occupation status (forced choice, no free-text field)
# Degree        char      Highest degree (forced choice, no free-text field)
# Gender        char      Gender

#################################
########## PREPARATION ########## 
#################################

# Set working directories
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load libraries
library(plyr)
library(dplyr)
library(ggplot2)
library(Hmisc)
library(lme4)
library(gtools)
library(rworldmap)

# read data - 13464 participants
data <- read.csv("GamingStudy_R_clean.csv",header = TRUE, sep = ",")

#################################
########## Descriptives ######### 
#################################

# Demographics
summary(data$Gender)
summary(data$Age)

# Display - Where are they from, ranked by frequency        
tResidence <- as.data.frame(table(data$Residence))
View(tResidence[order(tResidence$Freq, decreasing = TRUE), ])

# Which games are played, ranked by frequency                
tGames <- as.data.frame(table(data$Game))
View(tGames[order(tGames$Freq, decreasing = TRUE), ])

#Where were they born, ranked by frequency
tBirth <- as.data.frame(table(data$Birthplace))
View(tBirth[order(tBirth$Freq, decreasing = TRUE), ])

# Where do people come from?
freq <- ddply(data, ~ Residence_ISO3, .fun=summarise, Nt = length(Residence_ISO3))

# plot data with 3 digit number of participants
freq <- freq[freq$Nt > 99,]
mapDevice() #create world map shaped window
sPDF <- joinCountryData2Map(freq,joinCode = "ISO3",nameJoinColumn = "Residence_ISO3") 
mapCountryData(sPDF,nameColumnToPlot='Nt',
               mapRegion="world",
               catMethod = "logFixedWidth",
               colourPalette = "heat",
               oceanCol="skyblue",
               missingCountryCol = "white",
               mapTitle="Countries with over 100 participants") 
#labelCountries(nameCountryColumn = "ISO_A3",col="black")

# Where do people play the most Hours per week?
sPDF <- joinCountryData2Map(data,joinCode = "ISO3",nameJoinColumn = "Residence_ISO3") 
mapDevice() #create world map shaped window
mapCountryData(sPDF,nameColumnToPlot='Hours',
               mapRegion="world",
               catMethod = "logFixedWidth",
               colourPalette = "heat",
               oceanCol="skyblue",
               missingCountryCol = "white",
               mapTitle="Hours played per week") 

##################################################
### Working with the GAD, SPIN and SWL scale #####
##################################################

# Bin the GAD scores acording to scale-author instructions
data$GADbins[data$GAD_T < 8] <- "0 none"
data$GADbins[data$GAD_T >= 8] <- "1 probable anxiety disorder"

# Frequency of GAD
count(data, GADbins)

# Bin the SWL scores acording to scale-author instructions
data$SWLbins[data$SWL_T < 10] <- "1 extremely dissatisfied"
data$SWLbins[data$SWL_T >= 10 & data$SWL_T < 15] <- "2 dissatisfied"
data$SWLbins[data$SWL_T >= 15 & data$SWL_T < 20] <- "3 slightly below average"
data$SWLbins[data$SWL_T >= 20 & data$SWL_T < 25] <- "4 average"
data$SWLbins[data$SWL_T >= 25 & data$SWL_T < 30] <- "5 satisfied"
data$SWLbins[data$SWL_T >= 30] <- "6 highly satisfied"

# Frequency of SWL
count(data, SWLbins)

# Bin the SPIN scores acording to scale-author instructions
data$SPINbins[data$SPIN_T <= 20] <- "0 none"
data$SPINbins[data$SPIN_T > 20 & data$SPIN_T <= 30] <- "1 mild"
data$SPINbins[data$SPIN_T > 30 & data$SPIN_T <= 40] <- "2 moderate"
data$SPINbins[data$SPIN_T > 40 & data$SPIN_T <= 50] <- "3 severe"
data$SPINbins[data$SPIN_T > 50] <- "4 very severe"

# Frequency of SPIN
count(data, SPINbins)

#####################################################################
##### Exemplary Analysis: League of Legends ### 11314 participants ##
#####################################################################
# Select only people who play League of Legends, the most common game in the data set
data_lol <- subset(data, Game == "League of Legends")

# exclude subjects who indicated to play more than 112 hours a week (16 a day) 
# - 11286 participants remain
data_lol <- subset(data_lol, Hours <= 112)

# remove na's in hours played or the scales 
# - 10746 participants remain
data_lol <- data_lol[complete.cases(data_lol[ , c("Hours","GAD_T", "SPIN_T", "SWL_T")]),]

# Demographics
describe(data_lol$Age)
summary(data_lol$Gender)
summary(data_lol$Residence)

# Descriptives
hist(data_lol$Hours, breaks=10, col="gray", main="Distribution of hours played per week", xlab="Hours played per week")

# Correlation analyses - note that the GAD should not be used in this way
rcorr(data_lol$SWL_T, data_lol$Hours, type="pearson") 
rcorr(data_lol$SPIN_T, data_lol$Hours, type="pearson")

############################################ 
##########  Grouping Hours-played  ######### 
############################################

# create 10 bins from "Hours played in the last week" data
data_lol$Hours_G <- ntile(data_lol$Hours, 10)  

# calculate mean scores per bin
agg <- ddply(data_lol, ~ Game + Hours_G, .fun=summarise, SWL = mean(SWL_T), GAD = mean(GAD_T),SPIN = mean(SPIN_T))

# plot SPIN results
(Plot <- ggplot(agg, aes(x=Hours_G, y=SPIN)) + 
    geom_bar(stat="identity") +
    theme_bw() +
    labs(title = "", x="", y="Satisfaction With Life Score"))

############################################ 
########## Working with the scales: Bins ### 
############################################

# Working with the Scale Bins from above
# Plot: Satisfaction With Life score depending on Hours-played and 
#       the risk for generalied anxiety disorder
ggplot(data_lol, aes(x=Hours, y=SWL_T,colour=GADbins))+ ggtitle("Generalixed Anxiety Disorder") +
  geom_point(size = 3, shape=1, stat="identity")+ theme_bw() + 
  ylab("Satisfaction with Life score")+ xlab("Hours played") +
  stat_smooth(aes(colour=GADbins),method="lm",formula = y ~ poly(x, 1), size = 2, alpha = .25, fullrange = F) + 
  theme_set(theme_gray(base_size = 24)) +
  theme(plot.title = element_text(hjust = 0.5),
        panel.background = element_blank(),
        legend.position= c(.9, .85),
        legend.title = element_blank())