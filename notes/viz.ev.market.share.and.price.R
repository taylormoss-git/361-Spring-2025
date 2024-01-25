## viz.ev.market.share.data.r
library(tidyverse)
library(pubtheme)

## Manually create the data frame using data from those visualizations
df = data.frame(year = 2015:2023, 
                ev = c(0.3, 0.4, 0.5, 1.2, 1.3, 
                       1.6, 2.6, 5.2, 6.9), 
                hev = c(1.8, 2, 2.1, 2.5, 3.5, 
                        4, 5, 5.5, 8.3))
df$other = 100 - df$ev - df$hev
df

## stacked bar chart. First let's pivot longer
dg = df %>%
  pivot_longer(cols = c(ev, hev, other)) %>%
  mutate(year = as.character(year)) ## df$year = as.character(df$year)

## two equivalent ways to do same thing
pivot_longer(df, cols = c(ev, hev, other))

df %>%
  pivot_longer(cols = c(ev, hev, other))

dg

ggplot(dg, 
       aes(x = value, 
           y = year,
           fill = name)) +
  geom_col() 


## copy from pubtheme and edit
title = "EV, HEV, and Other Vehicle Market Share" 
g = ggplot(dg, 
           aes(x = value, 
               y = year, 
               label = round(value,1), 
               fill = name)) +
  geom_col(width = 0.8) + 
  #geom_text(hjust = -0.1) + ## optional numbers with reasonable number of digits
  labs(title    = title,
       x        = 'Market Share', ## Optional. 
       y        = 'Year')  ## Optional. Upper Lower.
g

g %>%
  pub(type = 'bar')


## Stacked bar chart without "other"
title = "EV, HEV, and Other Vehicle Market Share" 
g = ggplot(dg %>% filter(name != 'other'), ## same as dg[dg$name != 'other',]
           aes(x = value, 
               y = year, 
               label = round(value,1), 
               fill = name)) +
  geom_col(width = 0.8, ) + 
  #geom_text(hjust = -0.1) + ## optional numbers with reasonable number of digits
  labs(title    = title,
       x        = 'Market Share', ## Optional. 
       y        = 'Year')  ## Optional. Upper Lower.
g

g %>%
  pub(type = 'bar')


## What chatGPT suggested
ggplot(dg, aes(x = year, y = value, fill = name)) +
  geom_col(position = "stack") +
  scale_fill_manual(values = c("blue", "red", "grey")) +
  labs(x = "Year", y = "Market Share (%)", 
       title = "Market Share of EVs, HEVs, and Other Vehicles",
       subtitle = "Source: IEA, 2019") +
  theme_minimal() +
  theme(legend.position = "bottom")

