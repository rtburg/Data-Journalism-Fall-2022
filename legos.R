#Get in pairs.

#Create a spreadsheet in which each Lego brick is a row. Each column is an attribute of the bricks. 

#import it into R
# create a script or markdown file called legos.R (or legos.rmd)


#HINT:color(char), width(num), thick(T/F), length(num)

#For each of the following questions, perform the task with your bricks and then translate what you've done into R so your computer can share in the fun.


#Group your Lego bricks by color

legos %>%
  group_by(color)
#If you don't summarize, the groups just sit there awaiting further interrogation.


#Get the number of bricks of each color.

legos %>%
  group_by(color) %>%
  summarize(n())

#Get the number of bricks of each color again. But this time give the column a useful name.
legos %>%
  group_by(color) %>%
  summarize(bricks=n())

#We can summarize our groups in many ways at once. For example, we can get the number of bricks in each group as well as the total width for each group.
legos %>% 
  group_by(color) %>%
  summarize(bricks = n(),
            total_width = sum(width))

#For each brick, create a new column that stores the total number of dots. Then group the bricks by color and get the total number of bricks and the total number of dots for each color.

legos %>% 
  mutate(brick_dots = width * length) %>%
  group_by(color) %>%
  summarize(bricks = n(),
            total_dots = sum(brick_dots))
#The easiest way to get the total number of dots on each brick is to multiply width * height. We need to do this for each BRICK, not each GROUP. We're doing the math across each row, and when we do that we use mutate(). Once we create a new column with mutate(), we can use that new column -- temporarily -- in summarize.




#Create a data frame called "legos_new" that includes and saves for re-use the "brick_dots" column, which stores the total number of dots on each brick
legos_new <- legos %>%
  mutate(brick_dots = width * length) 


legos <- legos_new
rm(legos_new)
#Once we're sure the new data frame is what we want, we can -- if we want to -- get rid of the old data frame.


#Let's look at only the thick blocks this time. Using only the thick blocks, how many total dots does each color group have?

legos %>%
  filter(thick = T) %>%
  group_by(color) %>%
  summarize(total_dots = sum(brick_dots))

#Why doesn't this work?
legos %>%
  group_by(color) %>%
  summarize(total_dots = sum(brick_dots)) %>%
  filter(thick = T)

#It doesn't work because you don't use the "thick" column in the grouping.


#Will this work?
legos %>%
  select(length) %>%
  group_by(color) %>% 
  summarize(bricks = n())

#No. Because once you've selected only the length column, you've totally wiped the color column from R's short-term memory. 


#Why won't this work?
legos %>%
  group_by(color) %>% 
  summarize(bricks = n()) %>%
  select(length)

# Because when you group by color, the values of the length column remain but the name of the length column is not accessible.

#Will this work?
legos %>%
  select(color) %>%
  group_by(color) %>% 
  summarize(bricks = n())

#Yes. Because you are grouping by the same column you selected.

#Will this work?
legos %>%
  group_by(color) %>% 
  summarize(bricks = n()) %>%
  select(legos)

#Yes. You can select the names of columns that you create when you summarize.

#Create groups by color AND thickness. Once you've done that, tell me how many bricks you have in each group.

legos %>% 
  group_by(color, thick) %>%
  summarize(bricks = n() )

#Will this work?
legos %>%
  group_by(length, width) %>%
  summarize(colors = sum(color))

#No. This won't work because you can't add colors. Colors are a categorical variable, not numerical.

#Will this work?
legos %>%
  group_by(length, width) %>%
  summarize(total_length = sum(length))

#Yes. Because length is a numerical value, you can add up all the values in the length column to get a total sum of that column.


#Create groups by color AND thickness. Once you've done that, tell me how many bricks you have in each group, the median number of dots of the bricks in the group, and the total number of dots on all the bricks in the group.

legos %>%
  group_by(color, thick) %>%
  summarize(bricks = n(),
            median(brick_dots),
            total_dots = sum(brick_dots))
#See how we have an ugly name for the median column? That's why we assign names to the values:
legos %>%
  group_by(color, thick) %>%
  summarize(bricks = n(),
            median_dots = median(brick_dots),
            total_dots = sum(brick_dots)) 


#Last one. Can you do exactly what you did for the last question, but this time use mutate to give me the average number of dots for the bricks in each group. (Yes, there's a better and easier way to do this... )

legos %>%
  group_by(color, thick) %>%
  summarize(bricks = n(),
            median_dots = median(brick_dots),
            total_dots = sum(brick_dots)) %>%
  mutate(average_dots = total_dots / bricks)



  

  
  