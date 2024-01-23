## viz.ev.market.share.data.r
library(tidyverse)
library(pubtheme)

df = data.frame(year = 2015:2023,
                ev = c(0.3, 0.4, 0.5, 1.2, 1.3, 
                       1.6, 2.6, 5.2, 6.9),
                hev = c(1.8, 2, 2.1, 2.5, 3.5, 4,
                        5, 5.5, 8.3))

df$other = 100 - df$ev - df$hev
df

## stacked bar chart
dg = df %>%
  pivot_longer(cols = c(ev, hev, other)) %>%
  mutate(year = as.character(year)) # same as df$year = as.character(df$year)
dg

```
ggplot(dg,
       aes(x = value,
           y = year,
           fill = name)) + 
  geom_col()
```

title = "EV, HEV, and Other Vehicle Market Shares" 
g = ggplot(dg, 
           aes(x = value, 
               y = name, 
               label = round(value,1,),
               fill = name)) +
  geom_col(width = 0.8) + 
  geom_text(hjust = -0.1) + ## optional numbers with reasonable number of digits
 
   labs(title    = title,
       x        = 'Market Share',
       y        = 'Year')  ## Optional. Upper Lower.


## stacked bar chart without other
title = "EV, HEV, and Other Vehicle Market Shares" 
g = ggplot(dg |> (filter(name != 'other')),
           aes(x = value, 
               y = name, 
               label = round(value,1,),
               fill = name)) +
  geom_col(width = 0.8) + 
  geom_text(hjust = -0.1) + ## optional numbers with reasonable number of digits
  
  labs(title    = title,
       x        = 'Market Share',
       y        = 'Year')  ## Optional. Upper Lower.
