###########
# Exploratory Data Analysis
# -------
# Course Project 2: plot1.R
#
# Assignment Info:
# https://class.coursera.org/exdata-005/human_grading
# 
# Data File:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
# Question:
#   Have total emissions from PM2.5 decreased in the United States from 1999 
#   to 2008? Using the base plotting system, make a plot showing the total 
#   PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
#   and 2008.
#
# Work by: Allen Hammock
#  Github: brainvat
# Project: https://github.com/brainvat/ExData_Plotting2/
#
# Usage:
#
# 1. Use setcwd() to the folder on your system where you have downloaded
#    and decompressed the data file indicated above.  If your directory
#    does not contain the following two files, the script will abort with
#    a warning.
#
#    Source_Classification_Code.rds
#    summarySCC_PM25.rds
#
# 2. Source plot1.R into your R environment. The main() function will be
#    called automatically.  A file, plot1.png will be created in the working
#    directory, overwriting any previous version that may exist.
#
# 3. The data frame used to create the plot will be returned in the global
#    variable res
#
#######

if (!exists("NEI")) NEI <<- NULL
if (!exists("SCC")) SCC <<- NULL

main <- function(destfile = "plot1.png") {

    # input files
    file.NEI <- "summarySCC_PM25.rds"
    file.SCC <- "Source_Classification_Code.rds"
    
    # initialize results data frame
    res <- NULL

    # fetch emissions data and classification table
    # looks for global scope variable to save time building data frame
    # on repeat function calls
    if (!sum(dim(NEI) == c(6497651, 6)) == 2) {
        if (file.exists(file.NEI)) {
            cat(paste("Loading ", file.NEI, " please be patient.\n", sep = ""))
            NEI <<- readRDS(file.NEI)                     
        } else {
            stop(paste("ABORT. ", file.NEI, " file is missing.  Check your current working directory.", sep = ""))
        }
    } else {
        cat(paste("Using ", file.NEI, " previously loaded into memory.\n", sep = ""))        
    }
    
    if (!sum(dim(SCC) == c(11717, 15)) == 2) {
        if (file.exists(file.SCC)) {
            cat(paste("Loading ", file.SCC, " please be patient.\n", sep = ""))
            SCC <<- readRDS(file.SCC)                   
        } else {
            stop(paste("ABORT. ", file.SCC, " file is missing.  Check your current working directory.", sep = ""))
        }
    } else {
        cat(paste("Using ", file.SCC, " previously loaded into memory.\n", sep = ""))        
    }    
    
    # aggregate PM2.5 emissions by year and plot
    res <- aggregate(Emissions ~ year, NEI[NEI$year %in% c(1999, 2002, 2005, 2008),], sum)
    png(filename = destfile, height = 480, width = 480)
    par(mfrow = c(1,1))
    barplot(res$Emissions / 1000000, names.arg=res$year, main = "Total Emissions Declining Year Over Year", horiz = FALSE, xlab = destfile, ylab = "PM2.5 Emitted (Millions of Tons)")
    dev.off()
    cat(paste("Created file ", destfile, " in current working directory.\n", sep = ""))
    
    return(res)
}

res <- main()

