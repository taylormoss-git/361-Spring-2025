## viz.ev.market.share.data.r
# in class notes T Jan 23

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

ggplot(dg,
       aes(x = value, y = year, fill = name)) +
  geom_col(position = "stack") +
  scale_fill_manual(values = c("ev" = "#00BFFF", "hev" = "#FFA500", "other" = "#808080")) +
  labs(title = "Global EV Market Share",
       subtitle = "Source: CNBC")

