############################################################
### Gaming and its Association with Anxiety,            ####
### Life Satisfaction and Social Phobia                 ####
### (Data Set) - Pre-processing                         ####
############################################################
############################################################
### Code by Marian Sauter, www.mariansauter.de          ####
### Licensed under CC-BY Attribution 4.0 International  ####
### https://creativecommons.org/licenses/by/4.0/        ####
############################################################

# load libraries
library(plyr)
library(ggplot2)
library(Hmisc)
library(openxlsx)
library(stringi)
library(countrycode)

# Set working directory to current directory of the script file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# read in data table
mydf <- read.xlsx("GamingStudy.xlsx", sheet = 1, startRow = 1, colNames = TRUE)

#################################
########## Recoding ############# 
#################################

# recode Age into numeric (if multiple numbers, choose the first one)
mydf$Age <- as.numeric(stri_extract_first_regex(mydf$Age, "[0-9]+"))
# recode played hours into numeric (if multiple numbers, choose the first one)
mydf$Hours <- as.numeric(stri_extract_first_regex(mydf$Hours, "[0-9]+"))
# recode streamed hours into numeric (if multiple numbers, choose the first one)
mydf$streams <- as.numeric(stri_extract_first_regex(mydf$streams, "[0-9]+"))
# recode narcisiim scale into numeric (if multiple numbers, choose the first one)
mydf$Narcissism <- as.numeric(stri_extract_first_regex(mydf$Narcissism, "[0-9]+"))

# Recode all GAD scale items to numbers
mydf$GAD1 <- gsub("Not at all sure","0",mydf$GAD1)
mydf$GAD1 <- gsub("Not at all","0",mydf$GAD1)
mydf$GAD1 <- gsub("Several days","1",mydf$GAD1)
mydf$GAD1 <- gsub("Over half the days","2",mydf$GAD1)
mydf$GAD1 <- gsub("Nearly every day","3",mydf$GAD1)

mydf$GAD2 <- gsub("Not at all sure","0",mydf$GAD2)
mydf$GAD2 <- gsub("Not at all","0",mydf$GAD2)
mydf$GAD2 <- gsub("Several days","1",mydf$GAD2)
mydf$GAD2 <- gsub("Over half the days","2",mydf$GAD2)
mydf$GAD2 <- gsub("Nearly every day","3",mydf$GAD2)

mydf$GAD3 <- gsub("Not at all sure","0",mydf$GAD3)
mydf$GAD3 <- gsub("Not at all","0",mydf$GAD3)
mydf$GAD3 <- gsub("Several days","1",mydf$GAD3)
mydf$GAD3 <- gsub("Over half the days","2",mydf$GAD3)
mydf$GAD3 <- gsub("Nearly every day","3",mydf$GAD3)

mydf$GAD4 <- gsub("Not at all sure","0",mydf$GAD4)
mydf$GAD4 <- gsub("Not at all","0",mydf$GAD4)
mydf$GAD4 <- gsub("Several days","1",mydf$GAD4)
mydf$GAD4 <- gsub("Over half the days","2",mydf$GAD4)
mydf$GAD4 <- gsub("Nearly every day","3",mydf$GAD4)

mydf$GAD5 <- gsub("Not at all sure","0",mydf$GAD5)
mydf$GAD5 <- gsub("Not at all","0",mydf$GAD5)
mydf$GAD5 <- gsub("Several days","1",mydf$GAD5)
mydf$GAD5 <- gsub("Over half the days","2",mydf$GAD5)
mydf$GAD5 <- gsub("Nearly every day","3",mydf$GAD5)

mydf$GAD6 <- gsub("Not at all sure","0",mydf$GAD6)
mydf$GAD6 <- gsub("Not at all","0",mydf$GAD6)
mydf$GAD6 <- gsub("Several days","1",mydf$GAD6)
mydf$GAD6 <- gsub("Over half the days","2",mydf$GAD6)
mydf$GAD6 <- gsub("Nearly every day","3",mydf$GAD6)

mydf$GAD7 <- gsub("Not at all sure","0",mydf$GAD7)
mydf$GAD7 <- gsub("Not at all","0",mydf$GAD7)
mydf$GAD7 <- gsub("Several days","1",mydf$GAD7)
mydf$GAD7 <- gsub("Over half the days","2",mydf$GAD7)
mydf$GAD7 <- gsub("Nearly every day","3",mydf$GAD7)

# Recode all SWL scale items to numbers
mydf$SWL1 <- gsub("Slightly Disagree","3",mydf$SWL1)
mydf$SWL1 <- gsub("Slightly Agree","5",mydf$SWL1)
mydf$SWL1 <- gsub("Strongly Agree","7",mydf$SWL1)
mydf$SWL1 <- gsub("Strongly Disagree","1",mydf$SWL1)
mydf$SWL1 <- gsub("Neither Agree or Disagree","4",mydf$SWL1)
mydf$SWL1 <- gsub("Agree","6",mydf$SWL1)
mydf$SWL1 <- gsub("Disagree","2",mydf$SWL1)

mydf$SWL2 <- gsub("Slightly Disagree","3",mydf$SWL2)
mydf$SWL2 <- gsub("Slightly Agree","5",mydf$SWL2)
mydf$SWL2 <- gsub("Strongly Agree","7",mydf$SWL2)
mydf$SWL2 <- gsub("Strongly Disagree","1",mydf$SWL2)
mydf$SWL2 <- gsub("Neither Agree or Disagree","4",mydf$SWL2)
mydf$SWL2 <- gsub("Agree","6",mydf$SWL2)
mydf$SWL2 <- gsub("Disagree","2",mydf$SWL2)

mydf$SWL3 <- gsub("Slightly Disagree","3",mydf$SWL3)
mydf$SWL3 <- gsub("Slightly Agree","5",mydf$SWL3)
mydf$SWL3 <- gsub("Strongly Agree","7",mydf$SWL3)
mydf$SWL3 <- gsub("Strongly Disagree","1",mydf$SWL3)
mydf$SWL3 <- gsub("Neither Agree or Disagree","4",mydf$SWL3)
mydf$SWL3 <- gsub("Agree","6",mydf$SWL3)
mydf$SWL3 <- gsub("Disagree","2",mydf$SWL3)

mydf$SWL4 <- gsub("Slightly Disagree","3",mydf$SWL4)
mydf$SWL4 <- gsub("Slightly Agree","5",mydf$SWL4)
mydf$SWL4 <- gsub("Strongly Agree","7",mydf$SWL4)
mydf$SWL4 <- gsub("Strongly Disagree","1",mydf$SWL4)
mydf$SWL4 <- gsub("Neither Agree or Disagree","4",mydf$SWL4)
mydf$SWL4 <- gsub("Agree","6",mydf$SWL4)
mydf$SWL4 <- gsub("Disagree","2",mydf$SWL4)

mydf$SWL5 <- gsub("Slightly Disagree","3",mydf$SWL5)
mydf$SWL5 <- gsub("Slightly Agree","5",mydf$SWL5)
mydf$SWL5 <- gsub("Strongly Agree","7",mydf$SWL5)
mydf$SWL5 <- gsub("Strongly Disagree","1",mydf$SWL5)
mydf$SWL5 <- gsub("Neither Agree or Disagree","4",mydf$SWL5)
mydf$SWL5 <- gsub("Agree","6",mydf$SWL5)
mydf$SWL5 <- gsub("Disagree","2",mydf$SWL5)

# Recode all SPIN scale items to numbers
mydf$SPIN1 <- gsub("Not at all","0",mydf$SPIN1)
mydf$SPIN1 <- gsub("A little bit","1",mydf$SPIN1)
mydf$SPIN1 <- gsub("Somewhat","2",mydf$SPIN1)
mydf$SPIN1 <- gsub("Very Much","3",mydf$SPIN1)
mydf$SPIN1 <- gsub("Extremely","4",mydf$SPIN1)

mydf$SPIN2 <- gsub("Not at all","0",mydf$SPIN2)
mydf$SPIN2 <- gsub("A little bit","1",mydf$SPIN2)
mydf$SPIN2 <- gsub("Somewhat","2",mydf$SPIN2)
mydf$SPIN2 <- gsub("Very Much","3",mydf$SPIN2)
mydf$SPIN2 <- gsub("Extremely","4",mydf$SPIN2)

mydf$SPIN3 <- gsub("Not at all","0",mydf$SPIN3)
mydf$SPIN3 <- gsub("A little bit","1",mydf$SPIN3)
mydf$SPIN3 <- gsub("Somewhat","2",mydf$SPIN3)
mydf$SPIN3 <- gsub("Very Much","3",mydf$SPIN3)
mydf$SPIN3 <- gsub("Extremely","4",mydf$SPIN3)

mydf$SPIN4 <- gsub("Not at all","0",mydf$SPIN4)
mydf$SPIN4 <- gsub("A little bit","1",mydf$SPIN4)
mydf$SPIN4 <- gsub("Somewhat","2",mydf$SPIN4)
mydf$SPIN4 <- gsub("Very Much","3",mydf$SPIN4)
mydf$SPIN4 <- gsub("Extremely","4",mydf$SPIN4)

mydf$SPIN5 <- gsub("Not at all","0",mydf$SPIN5)
mydf$SPIN5 <- gsub("A little bit","1",mydf$SPIN5)
mydf$SPIN5 <- gsub("Somewhat","2",mydf$SPIN5)
mydf$SPIN5 <- gsub("Very Much","3",mydf$SPIN5)
mydf$SPIN5 <- gsub("Extremely","4",mydf$SPIN5)

mydf$SPIN6 <- gsub("Not at all","0",mydf$SPIN6)
mydf$SPIN6 <- gsub("A little bit","1",mydf$SPIN6)
mydf$SPIN6 <- gsub("Somewhat","2",mydf$SPIN6)
mydf$SPIN6 <- gsub("Very Much","3",mydf$SPIN6)
mydf$SPIN6 <- gsub("Extremely","4",mydf$SPIN6)

mydf$SPIN7 <- gsub("Not at all","0",mydf$SPIN7)
mydf$SPIN7 <- gsub("A little bit","1",mydf$SPIN7)
mydf$SPIN7 <- gsub("Somewhat","2",mydf$SPIN7)
mydf$SPIN7 <- gsub("Very Much","3",mydf$SPIN7)
mydf$SPIN7 <- gsub("Extremely","4",mydf$SPIN7)

mydf$SPIN8 <- gsub("Not at all","0",mydf$SPIN8)
mydf$SPIN8 <- gsub("A little bit","1",mydf$SPIN8)
mydf$SPIN8 <- gsub("Somewhat","2",mydf$SPIN8)
mydf$SPIN8 <- gsub("Very Much","3",mydf$SPIN8)
mydf$SPIN8 <- gsub("Extremely","4",mydf$SPIN8)

mydf$SPIN9 <- gsub("Not at all","0",mydf$SPIN9)
mydf$SPIN9 <- gsub("A little bit","1",mydf$SPIN9)
mydf$SPIN9 <- gsub("Somewhat","2",mydf$SPIN9)
mydf$SPIN9 <- gsub("Very Much","3",mydf$SPIN9)
mydf$SPIN9 <- gsub("Extremely","4",mydf$SPIN9)

mydf$SPIN10 <- gsub("Not at all","0",mydf$SPIN10)
mydf$SPIN10 <- gsub("A little bit","1",mydf$SPIN10)
mydf$SPIN10 <- gsub("Somewhat","2",mydf$SPIN10)
mydf$SPIN10 <- gsub("Very Much","3",mydf$SPIN10)
mydf$SPIN10 <- gsub("Extremely","4",mydf$SPIN10)

mydf$SPIN11 <- gsub("Not at all","0",mydf$SPIN11)
mydf$SPIN11 <- gsub("A little bit","1",mydf$SPIN11)
mydf$SPIN11 <- gsub("Somewhat","2",mydf$SPIN11)
mydf$SPIN11 <- gsub("Very Much","3",mydf$SPIN11)
mydf$SPIN11 <- gsub("Extremely","4",mydf$SPIN11)

mydf$SPIN12 <- gsub("Not at all","0",mydf$SPIN12)
mydf$SPIN12 <- gsub("A little bit","1",mydf$SPIN12)
mydf$SPIN12 <- gsub("Somewhat","2",mydf$SPIN12)
mydf$SPIN12 <- gsub("Very Much","3",mydf$SPIN12)
mydf$SPIN12 <- gsub("Extremely","4",mydf$SPIN12)

mydf$SPIN13 <- gsub("Not at all","0",mydf$SPIN13)
mydf$SPIN13 <- gsub("A little bit","1",mydf$SPIN13)
mydf$SPIN13 <- gsub("Somewhat","2",mydf$SPIN13)
mydf$SPIN13 <- gsub("Very Much","3",mydf$SPIN13)
mydf$SPIN13 <- gsub("Extremely","4",mydf$SPIN13)

mydf$SPIN14 <- gsub("Not at all","0",mydf$SPIN14)
mydf$SPIN14 <- gsub("A little bit","1",mydf$SPIN14)
mydf$SPIN14 <- gsub("Somewhat","2",mydf$SPIN14)
mydf$SPIN14 <- gsub("Very Much","3",mydf$SPIN14)
mydf$SPIN14 <- gsub("Extremely","4",mydf$SPIN14)

mydf$SPIN15 <- gsub("Not at all","0",mydf$SPIN15)
mydf$SPIN15 <- gsub("A little bit","1",mydf$SPIN15)
mydf$SPIN15 <- gsub("Somewhat","2",mydf$SPIN15)
mydf$SPIN15 <- gsub("Very Much","3",mydf$SPIN15)
mydf$SPIN15 <- gsub("Extremely","4",mydf$SPIN15)

mydf$SPIN16 <- gsub("Not at all","0",mydf$SPIN16)
mydf$SPIN16 <- gsub("A little bit","1",mydf$SPIN16)
mydf$SPIN16 <- gsub("Somewhat","2",mydf$SPIN16)
mydf$SPIN16 <- gsub("Very Much","3",mydf$SPIN16)
mydf$SPIN16 <- gsub("Extremely","4",mydf$SPIN16)

mydf$SPIN17 <- gsub("Not at all","0",mydf$SPIN17)
mydf$SPIN17 <- gsub("A little bit","1",mydf$SPIN17)
mydf$SPIN17 <- gsub("Somewhat","2",mydf$SPIN17)
mydf$SPIN17 <- gsub("Very Much","3",mydf$SPIN17)
mydf$SPIN17 <- gsub("Extremely","4",mydf$SPIN17)

# Cast all previously re-coded items to numeric
mydf$SWL1 <- as.numeric(as.character(mydf$SWL1))
mydf$SWL2 <- as.numeric(as.character(mydf$SWL2))
mydf$SWL3 <- as.numeric(as.character(mydf$SWL3))
mydf$SWL4 <- as.numeric(as.character(mydf$SWL4))
mydf$SWL5 <- as.numeric(as.character(mydf$SWL5))
mydf$GAD1 <- as.numeric(as.character(mydf$GAD1))
mydf$GAD2 <- as.numeric(as.character(mydf$GAD2))
mydf$GAD3 <- as.numeric(as.character(mydf$GAD3))
mydf$GAD4 <- as.numeric(as.character(mydf$GAD4))
mydf$GAD5 <- as.numeric(as.character(mydf$GAD5))
mydf$GAD6 <- as.numeric(as.character(mydf$GAD6))
mydf$GAD7 <- as.numeric(as.character(mydf$GAD7))
mydf$SPIN1 <- as.numeric(as.character(mydf$SPIN1))
mydf$SPIN2 <- as.numeric(as.character(mydf$SPIN2))
mydf$SPIN3 <- as.numeric(as.character(mydf$SPIN3))
mydf$SPIN4 <- as.numeric(as.character(mydf$SPIN4))
mydf$SPIN5 <- as.numeric(as.character(mydf$SPIN5))
mydf$SPIN6 <- as.numeric(as.character(mydf$SPIN6))
mydf$SPIN7 <- as.numeric(as.character(mydf$SPIN7))
mydf$SPIN8 <- as.numeric(as.character(mydf$SPIN8))
mydf$SPIN9 <- as.numeric(as.character(mydf$SPIN9))
mydf$SPIN10 <- as.numeric(as.character(mydf$SPIN10))
mydf$SPIN11 <- as.numeric(as.character(mydf$SPIN11))
mydf$SPIN12 <- as.numeric(as.character(mydf$SPIN12))
mydf$SPIN13 <- as.numeric(as.character(mydf$SPIN13))
mydf$SPIN14 <- as.numeric(as.character(mydf$SPIN14))
mydf$SPIN15 <- as.numeric(as.character(mydf$SPIN15))
mydf$SPIN16 <- as.numeric(as.character(mydf$SPIN16))
mydf$SPIN17 <- as.numeric(as.character(mydf$SPIN17))                                             
      
# Calculate overall GAD, SWL and SPIN scores, as per the questionnaire instructions                                            
mydf$GAD_T <- mydf$GAD1 + mydf$GAD2 + mydf$GAD3 + mydf$GAD4 + mydf$GAD5 + mydf$GAD6 + mydf$GAD7
mydf$SWL_T <- mydf$SWL1 + mydf$SWL2 + mydf$SWL3 + mydf$SWL4 + mydf$SWL5
mydf$SPIN_T <- mydf$SPIN1 + mydf$SPIN2 + mydf$SPIN3 + mydf$SPIN4 + mydf$SPIN5 + mydf$SPIN6 + mydf$SPIN7 + mydf$SPIN8 + mydf$SPIN9 + mydf$SPIN10 + mydf$SPIN11 + mydf$SPIN12 + mydf$SPIN13 + mydf$SPIN14 + mydf$SPIN15 + mydf$SPIN16 + mydf$SPIN17

# Copy data to new variable data_main
data_main <- mydf

#################################################
######### CATEGORIZATION OF GAME TITLES #########
#################################################

# Sometimes, participants have listed more than one game (against instructions)
# We select the first listed game based on 3 separators
data_main$Game <- gsub(",.*$", "", data_main$Game)
data_main$Game <- gsub("/.*$", "", data_main$Game)
data_main$Game <- gsub("&.*$", "", data_main$Game)

# Addtionally, we listed all different spellings for the most popular games:
#     League of Legends, Starcraft 2, Dota 2, Counter Strike, Hearthstone, 
#     Heroes of the Storm, Diabo 3, Guild Wars 2 and Skyrim
# Those spellings were then merged.

# merge all derivates of --- "League of Legends"
spellings_lol <- list("\"League of Legends","leage of legends","\"League of Legends\"","\"League of legends\"","League of Legends ","League of Legends","league of legends","League of legends","League Of Legends",
"LoL","League of Legends ","lol","League of legends ","league of legends ","LOL","League","Leauge of Legends",
"League of Legends","league","Lol","League of Legends, CS:GO","League of Legend","league of Legends","Leage of Legends",
"Leauge of legends","League of LEgends","League of Legends, World of Warcraft","League of Legends, Hearthstone","Smite",
"League ","League of Legens","League of Legneds","league of legend","League of Legenda","League of Legends, Diablo 3",
'League of Legends"',"League oft Legends","League og Legends","leauge of legends","league ","League if Legends",
"League Of Legends ","League of Legends, Guild Wars 2","League of Lengends","Legue of Legends","League of legends",
"League of Legends, Starcraft 2","League of Legnds","Leage of legends","League of legend","League of Legendes","League Of legends",
"LEague of Legends","LEAGUE OF LEGENDS","league of Legends ","League of Legends ; CS:GO","League of Legends and CS:GO","League of Legends, Osu",
"Leauge of legends ","\"League of Legends  2","27	53	League of Legends\"", "\"Skyrim\"\"\"","Lague of Legends","leafue of legends","League of Ledgends",
"League of Legeds","League of Legemds","League of Legend ","League Of LEgends","league of legends cs:go","League of Legends CS:GO","league of legends, cs go",
"League Of Legends, CS:GO","League of Legends, CS:GO, Hearthstone","league of legends, csgo","League of Legends, Dark Souls 2","League of Legends, FIFA",
"League of legends, Hearthstone","League of Legends, Minecraft","League of Legends, Monster Hunter","League of Legends, osu!","League of Legends, Runescape",
"League of legends.","League of Legends.","League of Lgends","league oft legends","League pf Legends","leagueoflegends","leagueoflegends ","Leauge Of Legends",
"Lol ","LoL ","lol csgo","LoL, Minecraft, Skyrim, Hearthston, CS:GO","LoL, WoW",'"league of legends"',"League of Legends",'"Leauge of Legends"')

for (i in spellings_lol){
  data_main$Game[data_main$Game == i] <- "League of Legends"
}

# merge all derivates of SC2
spellings_sc2 <- list("Starcraft 2","Starcraft 2","starcraft 2","StarCraft 2","Starcraft 2 ","SC2","starcraft2","Starcraft2","sc2","Starcraft","Starcraft II")

for (i in spellings_sc2){
  data_main$Game[data_main$Game == i] <- "Starcraft 2"
}

# merge all derivates of CS:GO
spellings_cs <- list("CS:GO","CS:GO","CS GO","CSGO","CS:GO, League of Legends","CS:GO","cs:go","cs go","Cs:go","CS:GO League of Legends","CS:GO and League of Legends","csgo","CS:GO, LoL","cs.go","cs go and lol","CS:GO ","cs:go, league of legends","CS:GO, League of legends","CS:GO; LoL","CS.GO")

for (i in spellings_cs){
  data_main$Game[data_main$Game == i] <- "Counter Strike"
}

# merge all derivates of WoW
spellings_wow <-list("World of Warcraft","World of Warcraft","WoW","World of warcraft","World of Warcraft, League of Legends","Wow","WOW","wow","WoW, League of Legends","world of warcraft","World of Warcraft and League of Legends","WoW, LoL")

for (i in spellings_wow){
  data_main$Game[data_main$Game == i] <- "World of Warcraft"
}

spellings_hearth <- list("Hearthstone","hearthstone","Heartstone")
for (i in spellings_hearth){
  data_main$Game[data_main$Game == i] <- "Hearthstone"
}

spellings_heroes <- list("Heroes of the Storm","Heroes of the storm","heroes of the storm")
for (i in spellings_heroes){
  data_main$Game[data_main$Game == i] <- "Heroes of the Storm"
}

spellings_d3 <- list("Diablo","diablo3","Diablo III","Diablo3", "diablo 3")
for (i in spellings_d3){
  data_main$Game[data_main$Game == i] <- "Diablo 3"
}

spellings_gw2 <- list("Guild Wars 2","Guild Wars 2","guild wars 2","Guild Wars 2, League of Legends","gw2")
for (i in spellings_gw2){
  data_main$Game[data_main$Game == i] <- "Guild Wars 2"
}

spellings_skyrim <- list("skyrim","Skyrim")
for (i in spellings_skyrim){
  data_main$Game[data_main$Game == i] <- "Skyrim"
}

spellings_dota <- list("dota 2","DotA 2","Dota2","DOTA 2","dota")
for (i in spellings_dota){
  data_main$Game[data_main$Game == i] <- "Dota 2"
}

# We manually selected all spelling entries that were listed
# by at least two particopants and grouped them into 'Other'
spellings_other <- list("Runescape","Path of Exile","Minecraft","Osu!","Battlefield 4","Evolve","FIFA","H1Z1","osu!","Warframe","Dark Souls","Payday 2","Europa Universalis 4","Europa Universalis IV","FFXIV","Final Fantasy XIV","Monster Hunter 4 Ultimate","Team Fortress 2","World of Tanks","Borderlands 2","Darkest Dungeon","Call of Duty","Osu","Civilization 5","Dragon Age","Monster Hunter","Planetside 2","Sunless Sea","SWTOR","Terraria","BF4","Dark Souls 2","Dying Light","Far Cry 4","fifa","Fifa","FIFA 15","Kerbal Space Program","Mount and Blade: Warband","None","Pokemon","Super Smash Bros.","The Binding of Isaac: Rebirth","Town of Salem","ARMA 3","Battlefield 3","Binding of Isaac","Binding of Isaac: Rebirth","Borderlands","Brave Frontier","Civ 5","Civilization V","Dark souls","Dark Souls ","DESTINY","Dragon Age : Inquisition","Dragon Age Inquisition","Dragon Age: Inquisition","Dragon Nest","Dying light","Elder Scrolls Online","Elsword","Eve","Eve Online","EVE Online","Fallout New Vegas","Fallout: New Vegas","faster than light","ffxiv","Firefall","Lineage 2","Majora's Mask 3D","Mass Effect 3","Mechwarrior Online","minecraft","Monster Hunter 4","Monster hunter 4 ultimate","Monster Hunter 4U","NBA 2K15","Neverwinter","osu","Persona 3","Pokemon Omega Ruby","Robocraft","RuneScape","Smash 4","SMITE","SSB4","SSBM","Star Trek Online","Starbound","Summoners War","Super Smash Bros","Super Smash Bros Melee","TagPro","Tera","Vindictus","War Thunder","warframe","Warthunder")
for (i in spellings_other){
  data_main$Game[data_main$Game == i] <- "Other"
}

# For efficiancy reasons and since games that are only palyed by < 10 people 
# will not be relevant in this dataset, we added the remaining entries to 'Other'

# If the entered game title is not one of the top 10 games, group to "Other"
data_main$Game[data_main$Game != "League of Legends" &
                 data_main$Game != "Starcraft 2" &
                 data_main$Game != "Counter Strike" &
                 data_main$Game != "World of Warcraft" &
                 data_main$Game != "Hearthstone" &
                 data_main$Game != "Diablo 3" &
                 data_main$Game != "Heroes of the Storm" &
                 data_main$Game != "Guild Wars 2" &
                 data_main$Game != "Destiny" &
                 data_main$Game != "Skyrim"] <- "Other"

# Display and rank games by frequency
tGames <- as.data.frame(table(data_main$Game))
View(tGames[order(tGames$Freq, decreasing = TRUE), ])

#################################################
######### CATEGORIZATION OF COUNTRIES ###########
#################################################
# read in all different spelligns of the countries (pre-prepared table)
countries <- read.xlsx("List_of_Countries2.xlsx", sheet = 1, startRow = 1, colNames = TRUE)

# Match spellings, merge into database
data_main$Birthplace <- countries$norm_birthplace[match(data_main$Birthplace, countries$birthplace)]
data_main$Residence <- countries$norm_residence[match(data_main$Residence, countries$residence)]

# Recode remaining NA-entries to 'Unknown', 60 participants affected
data_main$Residence[is.na(data_main$Residence)] <- "Unknown"
data_main$Birthplace[is.na(data_main$Birthplace)] <- "Unknown"

# Add new country variables in ISO3 
data_main$Residence_ISO3 <- countrycode(data_main$Residence, 'country.name', 'iso3c')
data_main$Birthplace_ISO3 <- countrycode(data_main$Birthplace, 'country.name', 'iso3c')

# Display and rank residence country by frequency
tResidence <- as.data.frame(table(data_main$Residence))
View(tResidence[order(tResidence$Freq, decreasing = TRUE), ])

# Display and rank country of birth by frequency
tBirth <- as.data.frame(table(data_main$Birthplace))
View(tBirth[order(tBirth$Freq, decreasing = TRUE), ])

#################################################
# Remove NA's and minors accoding to Age field
#################################################
fulln <- nrow(data_main)

# remove anyone who is below 18 (Age of Majority in Germany) - 786 removed
data_main <- subset(data_main, data_main$Age >= 18 & data_main$Age < 66)
lessn <- nrow(data_main)
# % excluded
100-lessn/fulln*100

#################################################
######### SAVE DATA #############################
#################################################

# Write CSV file for analysis
write.csv(data_main, "GamingStudy_R_clean.csv")