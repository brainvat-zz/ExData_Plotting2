ExData_Plotting2
================

Source files for Project 2 of Exploratory Data Analysis, a Coursera course in Data Science offered by John Hopkins University. https://class.coursera.org/exdata-005

Each of the questions below have an answer that is supported by the graph produced by the
corresponding R source file.

Requirements:

1. `install.packages("ggplot2")` and `install.packages("gridExtra")`
2. Set your current working directory to the folder where you have downloaded and decompressed the required data files
3. Source each of `plot1.R`, `plot2.R`, `plot3.R`, `plot4.R`, `plot5.R`, and `plot6.R` into your R environment
4. Locate `plot1.png`, `plot2.png`, `plot3.png`, `plot4.png`, `plot5.png`, and `plot6.png` in your current working directory

Scripts have been tested on MacOX Mavericks (10.9.4) using RStudio 0.98.953 and R version 3.1.1 (2014-07-10), x86_64-apple-darwin13.1.0 (64-bit).

## Question 1

Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

### plot1.png

![plot1.png](plot1.png)

## Question 2

Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

### plot2.png

![plot2.png](plot2.png)

## Question 3

Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

### plot3.png

![plot3.png](plot3.png)

## Question 4

Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

### plot4.png

![plot4.png](plot4.png)

## Question 5

How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

### plot5.png

![plot5.png](plot5.png)

## Question 6

Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

### plot6.png

![plot6.png](plot6.png)
