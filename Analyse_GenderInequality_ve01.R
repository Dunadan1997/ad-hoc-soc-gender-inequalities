# Title: Ideological differences between young men and women, part 02
# Author: Bruno Alves de Carvalho
# Status: ongoing
# Purpose of research: The purpose of my research is to explore the ideological differences between young men and women across the globe. In particular, I would like to test if differences exist with regards to traditional values associated with God, the family and nation. And if these differences persist when accounting for educational level. This is purely for my own interest and desire to have an informed opinion on such matters. 


# Exploratory Data Analysis -----------------------------------------------

# Young women feel more and more penalized, but not young men, despite unprecedented gender equality
merged_data_shp %>% 
  filter(`sex$$` %in% c(1,2) & `age$$` %in% c(18:29) & `p$$p21` >= 0) %>% 
  group_by(`sex$$`, year) %>% 
  mutate(mean = mean(`p$$p21`, na.rm = T)) %>% 
  select(`sex$$`, year, mean) %>% 
  ggplot(aes(year, mean, group = as.factor(`sex$$`), colour = as.factor(`sex$$`))) + 
  geom_point() + 
  geom_smooth()

# men do more work (productive and reproductive) than women
merged_data_shp %>% 
  filter(`sex$$` %in% c(1,2) & `p$$f08` >= 0 & `p$$w77` >= 0 & `p$$f63` >= 0) %>% 
  group_by(`sex$$`, year) %>% 
  summarise(
    n = n(), 
    sum1 = sum(`p$$f08`)/n, 
    sum2 = sum(`p$$w77`)/n,
    sum3 = sum(`p$$f63`)/n, 
    total_work = sum1 + sum2 + sum3, 
    total_reprod_work = sum1 + sum3) %>% 
  ggplot(aes(year, total_work, group = as.factor(`sex$$`), color = as.factor(`sex$$`))) + 
  geom_point() + 
  geom_smooth()





