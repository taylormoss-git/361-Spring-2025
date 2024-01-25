## viz.ev.market.share.data.r
# in class notes T Jan 23 & Th Jan 25

# copied from CNBC article: 
# https://www.cnbc.com/2023/12/08/automakers-turn-to-hybrids-ev-transition.html

library(tidyverse)
library(pubtheme)

df <- data.frame(year = 2015:2023,
                ev = c(0.3, 0.4, 0.5, 1.2, 1.3, 1.6, 2.6, 5.2, 6.9),
                hev = c(1.8, 2, 2.1, 2.5, 3.5, 4, 5, 5.5, 8.3))

df$other <- 100 - df$ev - df$hev
df

# transform data to stacked bar chart
dg <- df %>%
  pivot_longer(cols = c(ev, hev, other)) %>%
  mutate(year = as.character(year))
dg

# in general, when using the pipe operators in tidyverse, the code assumes that the names are
# columns in a dataframe, instead of you having to c("ev", "hev", "other") to specify!

# dg <- pivot_longer(df, cols = c(ev, hev, other))
# dg <- df %>% pivot_longer(cols = c(ev, hev, other))
# these are equivalent, where the first arg of pivot_longer is df, but pipe operator strings together

# following imported from pubtheme > Bar Plot section

title = "EV, HEV, and Other Vehicle Market Share" 
g = ggplot(dg %>% filter(name != 'other'), ## equiv. to dg[dg$name != 'other']
           aes(x = value, 
               y = year, 
               label = round(value, 1),
               fill = name)) +
  geom_col(width = 0.8, 
           position = position_dodge(width = 0.8)) + 
  geom_text(vjust = -0.2,
            position = position_dodge(width = 0.8),
            size = 4) + ## must specify default width
  labs(title    = title,
       x        = 'Market Share',
       y        = 'Year') +
  scale_fill_manual(values = c('ev' = '#619CFF', 'hev' = '#F8766D', 'other' = 'grey'))

g

# or
g %>%
  pub(type = 'bar')

# flip the coords; and need to change hjust to vjust in geom_text()
# can also just flip x and y in the arguments of aes()
g +
  coord_flip()

------------------
## Save to a file using base_size = 36
gg = g %>%
  pub(type      = 'bar',
      base_size = 36)

ggsave(filename = paste0("img/", gsub("%", " Perc", title), ".jpg"), ## must have a subfolder called 'img'
       plot   = gg,
       width  = 20,   ## do not change
       height = 15,   ## can change from 20 if desired. We use 15 here b/c there are only 3 bars
       units  = 'in', ## do not change
       dpi    = 72)   ## do not change

## F-150 dataset

df2 = data.frame(date = c('2022-04-01',
                         '2022-08-01',
                         '2022-10-01',
                         '2022-12-01',
                         '2023-03-01',
                         '2023-07-01'),
                price = c(39974,
                          46974,
                          51974,
                          55974,
                          59974,
                          49995))

df2
df2$date = as.Date(df2$date)

g2 = ggplot(df2,
            aes(x = date,
                y = price,
                label = dollar(price))) +
  geom_line(linewidth = 1) + # show line
  geom_point(size = 3) + # show points
  geom_text(size = 5, hjust = -0.1) +
  scale_x_date(limits = c(as.Date('2022-03-01'), 
                          as.Date('2023-09-30'))) +
  scale_y_continuous(labels = dollar) # you can put a function as the argument too 
                                      # (apply function 'dollar' to the labels)
g2