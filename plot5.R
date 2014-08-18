###########
# Exploratory Data Analysis
# -------
# Course Project 2: plot5.R
#
# Assignment Info:
# https://class.coursera.org/exdata-005/human_grading
# 
# Data File:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# 
# Question:
#   How have emissions from motor vehicle sources changed from 1999–2008
#   in Baltimore City?
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
# 2. Source plot5.R into your R environment. The main() function will be
#    called automatically.  A file, plot5.png will be created in the working
#    directory, overwriting any previous version that may exist.
#
# 3. The data frame used to create the plot will be returned in the global
#    variable res
#
#######

if (!exists("NEI")) NEI <<- NULL
if (!exists("SCC")) SCC <<- NULL

main <- function(destfile = "plot5.png") {

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
            cat(paste("Loading ", file.SCC, ".\n", sep = ""))
            SCC <<- readRDS(file.SCC)                   
        } else {
            stop(paste("ABORT. ", file.SCC, " file is missing.  Check your current working directory.", sep = ""))
        }
    } else {
        cat(paste("Using ", file.SCC, " previously loaded into memory.\n", sep = ""))        
    }    
    
    # install.packages("ggplot2", "gridExtra", "scales")
    library(ggplot2)
    library(gridExtra)
    library(scales)
    
    motor.comb <- SCC[grep(SCC$EI.Sector, pattern = "mobile \\- on\\-road", ignore.case = TRUE), names(SCC)[1:4]]
    my.NEI <<- merge(x = NEI[(NEI$fips == "24510") & (NEI$SCC %in% motor.comb$SCC) & (NEI$year %in% c(1999, 2002, 2005, 2008)),], y = motor.comb, by = "SCC", all.x = TRUE)
    res <- aggregate(Emissions ~ year + EI.Sector, my.NEI, sum)
    png(filename = destfile, height = 300 * 2, width = 300 * 2)
    
    plot <- ggplot(res, aes(x = factor(year), y = Emissions)) +
        geom_bar(stat = "identity", aes(fill = factor(year))) +
        facet_grid(. ~ EI.Sector) + facet_wrap( ~ EI.Sector, ncol = 2) +
        theme(strip.text.x = element_text(size = 10)) +
        scale_fill_discrete(name = "Year") +
        theme(plot.margin = unit(c(1, 1, 0.5, 0.5), "cm")) +
        ylab("PM2.5 Emitted (Tons)") + xlab("") +
        theme(legend.position = "none") +
        theme(plot.title = element_text(family = "Helvetica", face = "bold", size = 13, lineheight = 1.2, vjust = 2)) +
        ggtitle(paste("All Mobile On-Road Motor Vehicles See Steady Emission Reductions Between 1999-2008",
                      "Heavy Duty Diesel and Light Duty Gasoline Vehicles Make Biggest Reductions", sep = "\n")) +
        geom_text(aes(x = factor(year), y = Emissions, 
                      label = round(Emissions, 0), 
                      ymax = Emissions, vjust = -0.5), position = position_dodge(width=1))
    
    print(plot)
    dev.off()
    cat(paste("Created file ", destfile, " in current working directory.\n", sep = ""))
    
    return(res)
}

res <- main()

