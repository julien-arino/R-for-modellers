# USEFUL_FUNCTIONS.R
#
# Julien Arino
# May 2019 and onward
#
# This file contains several useful functions that I do not want to
# include in the main Rmd/Rnw files.

parse_command_line <- function(args) {
  OUT = list()
  # Parse command line
  for (arg in args) {
    tmp = strsplit(arg, "=")
    OUT[[tmp[[1]][1]]] = tmp[[1]][2]
  }
  return(OUT)
}

# MAKE_Y_AXIS
# Formats the y axis ticks and labels so that they are easier to read.
# Also returns a multiplicative factor for the plot so that the plot is on the right scale.
make_y_axis <- function(yrange) {
  y_max <- yrange[2]
  if (y_max < 1000) {
    # Do almost nothing
    factor <- 1
    ticks <- pretty(yrange)
    labels <- format(ticks, big.mark=",", scientific=FALSE)    
  } else if (y_max < 100000) {
    # Label with ab,cde
    factor <- 1
    ticks <- pretty(yrange)
    labels <- format(ticks, big.mark=",", scientific=FALSE)
  } else if (y_max < 1000000) {
    # Label with K
    factor <- 1/1000
    ticks <- pretty(yrange*factor)
    labels <- paste(ticks,"K",sep="")
  } else if (y_max < 1000000000) {
    # Label with M
    factor <- 1/1000000
    ticks <- pretty(yrange*factor)
    labels <- paste(ticks,"M",sep="")
  } else {
    # Label with B
    factor <- 1/1000000000
    ticks <- pretty(yrange*factor)
    labels <- paste(ticks,"B",sep="")
  }
  # Remove 0unit, just have 0
  if ("0K" %in% labels) {
    labels[which(labels=="0K")]="0"
  }
  if ("0M" %in% labels) {
    labels[which(labels=="0M")]="0"
  }
  if ("0B" %in% labels) {
    labels[which(labels=="0B")]="0"
  }
  y_axis <- list(factor=factor,ticks=ticks,labels=labels)
  return(y_axis)
}

# PLOT_HR_YAXIS
#
# Plot data using a human readable y-axis
plot_hr_yaxis <- function(x, y, y_range = NULL, ...) {
  if (is.null(y_range)) {
    y_range = range(y, na.rm = TRUE)
  }
  y_axis <- make_y_axis(y_range)
  plot(x,y*y_axis$factor,
       ylim = y_range,
       yaxt = "n", ...)
  axis(2, at = y_axis$ticks,
       labels = y_axis$labels,
       las = 1, cex.axis=0.8)
  return(y_axis)
}

# MAKE_X_AXIS_WEEK
# Formats the x axis ticks and labels so that they are easier to read.
make_x_axis_week = function(vec_dates) {
  l = length(vec_dates)
  vec_idx=1:l
  begin=vec_dates[1]
  end=vec_dates[l]
  if (l<8){
    # Labels using only weeks
    vec=seq.Date(as.Date(begin),as.Date(end),by="week")
    ticks <- seq(0,l,by=1)
    labels <- ticks
  } else if (l<54){
    # Labels using only month
    labels=seq.Date(as.Date(begin),as.Date(end),by="month")
    ticks = c()
    for(i in 1:length(labels)){
      dte = labels[i]
      indx = which.min(abs(as.Date(dte)-vec_dates))
      ticks = c(ticks,indx)
    }
    # labels <- vec
  } else {
    # Labels using only year
    labels=seq.Date(as.Date(begin),as.Date(end),by="year")
    print("labels")
    print(labels)
    ticks = c()
    for(i in 1:length(labels)){
      dte = labels[i]
      indx = which.min(abs(as.Date(dte)-vec_dates))
      ticks = c(ticks,indx)
    }
    print("ticks")
    print((ticks))
    # labels <- vec
  }
  return(list(ticks=ticks,labels=labels))
}

# CROP_FIGURE
#
# Crop an output pdf file. Requires to have pdfcrop installed
# in the system (for example, under linux)
crop_figure = function(fileFull) {
  fileName = tools::file_path_sans_ext(fileFull)
  fileExt = tools::file_ext(fileFull)
  if (fileExt == "pdf") {
    command_str = sprintf("pdfcrop %s",fileFull)
    system(command_str)
    command_str = sprintf("mv %s-crop.pdf %s.pdf",fileName,fileFull)
    system(command_str)
  }
  if (fileExt == "png") {
    command_str = sprintf("convert %s -trim %s-trim.png",fileFull,fileName)
    system(command_str)
    command_str = sprintf("mv %s-trim.png %s",fileName,fileFull)
    system(command_str)
  }
  if (fileExt == "tif") {
    command_str = sprintf("convert %s -trim %s-trim.tif",fileFull,fileName)
    system(command_str)
    command_str = sprintf("mv %s-trim.tif %s.tif",fileName,fileName)
    system(command_str)
  }
}

# Create a set of tables and lists, each of which has the firings of
# a certain type. 
# Return 
# - a table with firings at each time unit (each day, each week, whatever)
# - a list with all the firings of the specified type for simulation (pruned to only keep times of firings of the requested type)
tables_for_selected_firings = function(t_f = 1000, 
                                       SIM, 
                                       list_firings) {
  # We return all results in a list
  OUT = list()
  # Go through the requested firings
  for (firing in list_firings) {
    # Make the table with time units as rows and individual sims in columns,
    # grouped by time units (so there can be zero or more than 1 activation 
    # per time unit)
    OUT[[firing]] = mat.or.vec(nr = length(0:(t_f-1)), nc = 1)
    # Two steps: 
    # 1. get list of firings of the specified type, get rid of all times of 
    # firings not involving the specified type
    # 2. aggregate per day to fill in corresponding column in the table
    details = vector("list", 1)
    # Step 1: get the raw firings
    details = data.frame(time = SIM$time,
                         time_unit = floor(SIM$time),
                         value = SIM[,firing])
    details = details %>%
      filter(value > 0) %>%
      filter(time < t_f)
    if (dim(details)[1]>0) {
      tmp = details %>%
        group_by(time_unit) %>%       # Group by time unit
        summarise(value_sum = sum(value))  # Calculate the sum of value per group
      tmp[,1] = tmp[,1]+1
      OUT[[firing]] = tmp
    }
  }
  # Return result
  return(OUT)
}
# Return some summary information about the tables in the list passed as argument
make_summary_tables = function(list_tables) {
  OUT = list()
  for (n in names(list_tables)) {
    OUT[[n]] = mat.or.vec(nr = dim(list_tables[[n]])[1],
                          nc = 11)
    colnames(OUT[[n]]) = c("mean", "std", "0%", 
                           "2.5%", "5%", "25%", 
                           "50%", "75%", "95%", 
                           "97.5%", "100%")
    OUT[[n]][, "mean"] = rowMeans(list_tables[[n]], 
                                  na.rm = TRUE)
    OUT[[n]][, "std"] = apply(list_tables[[n]], 1, sd)
    pctiles = apply(list_tables[[n]], 1, 
                    function(x) 
                      quantile(x, 
                               probs = c(0, 0.025, 0.05, 
                                         0.25, 0.5, 0.75, 
                                         0.95, 0.975, 1),
                               na.rm = TRUE))
    OUT[[n]][, 3:11] = t(pctiles)
  }
  return(OUT)
}
# Transform a list in which each matrix has times and number of events per time
# into a line list, i.e., a matrix with dates as first column, then numbers of 
# events, then type of events.
# It is expected that the input list has element names the event names
make_line_list_from_matrices = function(L) {
  OUT = data.frame(date = rep(0, 0),
                   value = rep(0, 0),
                   event = rep("", 0))
  for (n in names(L)) {
    tmp = data.frame(date = L[[n]]$time_unit,
                     value = L[[n]]$value_sum,
                     event = rep(n, dim(L[[n]])[1]))
    OUT = rbind(OUT, tmp)
  }
  return(OUT)
}
# Plot as incidence plots with multiple factor.
# Receive a line list matrix.
plot_as_incidence_from_line_list = function(M) {
  library(incidence2)
  library(lubridate)
  library(ggplot2)
  M$date = as_date(M$date)
  incid = incidence(M, 
                    date_index = "date", 
                    counts = "value",
                    groups = "event")
  p = plot(incid, fill = "event") +
    labs(fill = "Type of event") +
    xlab("Date") +
    ylab("Number of events") 
  return(p)
}
# Plot as incidence plots with multiple factor.
# Receive a matrix M with some factors as named columns and rows
# as the days. Transform into a line list, i.e., a matrix with dates
# as first column, then numbers as second column and event type (original
# column in the matrix) as third column
plot_as_incidence_from_matrix = function(M) {
  tmp = data.frame(date = as_date(rep(0, dim(M)[1]*dim(M)[2])),
                   value = rep(0, dim(M)[1]*dim(M)[2]),
                   event = rep(0, dim(M)[1]*dim(M)[2]))
  for (i in 1:dim(M)[1]) {
    for (j in 1:dim(M)[2]) {
      idx = (i-1)*dim(M)[2]+j
      tmp$date[idx] = as_date(i)
      tmp$event[idx] = colnames(M)[j]
      if (M[i,j]>0) {
        tmp$value[idx] = M[i,j]
      }
    }
  }
  incid = incidence(tmp, 
                    date_index = "date", 
                    counts = "value",
                    groups = "event")
  p = plot(incid, fill = "event") +
    labs(fill = "Type")
  return(p)
}
