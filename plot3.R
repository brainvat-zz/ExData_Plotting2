###########
# Exploratory Data Analysis
# -------
# Course Project 2: plot3.R
#
# Assignment Info:
# https://class.coursera.org/exdata-005/human_grading
# 
# Data File:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# 
# Question:
#   Of the four types of sources indicated by the type (point, nonpoint, 
#   onroad, nonroad) variable, which of these four sources have seen 
#   decreases in emissions from 1999–2008 for Baltimore City? Which have 
#   seen increases in emissions from 1999–2008? Use the ggplot2 plotting 
#   system to make a plot answer this question.#   Maryland (fips == "24510") 
#   from 1999 to 2008? Use the ggplot2 plotting system to make a plot answer 
#   this question. 
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
# 2. Source plot3.R into your R environment. The main() function will be
#    called automatically.  A file, plot3.png will be created in the working
#    directory, overwriting any previous version that may exist.
#
# 3. The data frame used to create the plot will be returned in the global
#    variable res
#
#######

if (!exists("NEI")) NEI <<- NULL
if (!exists("SCC")) SCC <<- NULL

main <- function(destfile = "plot3.png") {

    # input files
    file.NEI <- "summarySCC_PM25.rds"
    file.SCC <- "Source_Classification_Code.rds"
    
    # initialize results data frame
    res <- rnorm(1000)

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
            cat(paste("Loading ", file.SCC, ".\n", sep = ""))
            SCC <<- readRDS(file.SCC)                   
        } else {
            stop(paste("ABORT. ", file.SCC, " file is missing.  Check your current working directory.", sep = ""))
        }
    } else {
        cat(paste("Using ", file.SCC, " previously loaded into memory.\n", sep = ""))        
    }    
    
    # aggregate PM2.5 emissions by year and type and plot
    cat(paste("Generating plot, this may take a few seconds.\n", sep = ""))
    
    # install.packages("ggplot2", "gridExtra")
    library(ggplot2)
    library(gridExtra)
    
    png(filename = destfile, height = 480, width = 480 * 2)
    res <- aggregate(Emissions ~ year + type, NEI[(NEI$fips == "24510") & (NEI$year %in% c(1999, 2008)),], sum)
    plot1 <- ggplot(res[res$type %in% c("NON-ROAD", "NONPOINT", "ON-ROAD"),], aes(x = factor(year), y = Emissions)) +
        geom_bar(stat = "identity", aes(fill = factor(year))) +
        facet_grid(. ~ type) + scale_fill_discrete(name="Year") +
        ylab("PM2.5 Emitted (Tons)") + xlab("1999 vs 2008") +
        theme(legend.position = "none") +
        theme(plot.title = element_text(family = "Helvetica", face = "bold", size = 20)) +
        ggtitle("Most Source Types Show\nSignificant Emissions Decrease")
    
    plot2 <- ggplot(res[res$type %in% c("POINT"),], aes(x = factor(year), y = Emissions)) +
              geom_bar(stat = "identity", aes(fill = factor(year))) +
              facet_grid(. ~ type) + scale_fill_discrete(name="Year") +
              ylab("PM2.5 Emitted (Tons)") + xlab("1999 vs 2008") +
              theme(legend.position = "none") +
              theme(plot.title = element_text(family = "Helvetica", face = "bold", size = 20)) +
              ggtitle("\"Point\" Source Type Shows\nSmall Emissions Gain")
    
    grid.arrange(plot1, plot2, nrow=1, ncol=2)
    dev.off()
    cat(paste("Created file ", destfile, " in current working directory.\n", sep = ""))
    
    return(res)
}

res <- main()

