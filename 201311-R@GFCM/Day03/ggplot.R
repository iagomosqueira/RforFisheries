PLotting in GGPLOT

# Lookup the list of commands online here:
#   http://docs.ggplot2.org/current/



# let's use the ple4 that we already loaded in R
# for plotting the best format is normally a data frame, so data with a columns and rows with columns being variables

# to use the ple4 data we convert it to a data frame and create a new object

ple<-as.data.frame(ple4)
is(ple)
str(ple)

#plot catches all ages all years
ggplot(ple[ple$slot=="catch.n" & ple$age==1,], aes(x=year, y=data))+geom_point()

#plot all ages
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point()
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point(aes(size=data/mean(data)))+stat_smooth()



#change to lines
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_line()


# facet grid
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_line()+facet_grid(.~age)
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_line()+facet_grid(age~.)

# change the scaling on the y lab to get better representation
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_line()+facet_grid(age~., scales="free_y")

#facet wrap
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point()+facet_wrap(age~year, scales="free_y")

# use smoothers as a linear model fit
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point()+facet_grid(age~., scales="free_y")+ stat_smooth(method="lm")

# add a loess smoothers
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point()+facet_grid(age~., scales="free_y")+ stat_smooth(method="loess")

# explore color tuning, use semitransparency
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point(alpha=0.5)+facet_grid(age~., scales="free_y")+ stat_smooth(method="loess")

# color the smooter with unique color
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point(alpha=0.5)+facet_grid(age~., scales="free_y")+ stat_smooth(method="loess", color=1)


ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point(alpha=0.5)+facet_grid(age~., scales="free_y")+ stat_smooth(method="loess")+
scale_colour_brewer()

scale_colour_brewer(palette="Set1")

# remove the faceting
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point(alpha=0.5)+ stat_smooth(method="loess")

# Flip axes
ggplot(ple[ple$slot=="catch.n",], aes(x=year, y=data, color=age))+geom_point(alpha=0.5)+coord_flip()+stat_smooth()

#########################################################################################
# Assignment

# 1 create a ggplot of the discard numbers where each age has a different symbol 

# 2 redo the same with a smoother in each age class

# 3 plot using faceting so that each horizontal panel represents one age

# 4 


