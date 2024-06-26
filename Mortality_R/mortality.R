library(tidyverse)
library(openair)


Mortality = read.csv("Data/Mortality.csv", header = T, sep = ";") 
head(Mortality)

Mortality <- Mortality %>% 
 mutate(DeathDate = as.Date(DeathDate, format = "%m/%d/%Y"))



### Gert sibande

### Cardiovacular
GertCardmort <- Mortality %>% 
  filter(death_district == 'Gert Sibande') %>% 
  filter(Underlying_Main_Grp == 'J00_J99')  
  
GertAllcard_counts <-  GertCardmort %>%
  group_by(DeathDate) %>%
  summarize(death_count = n())%>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)

GertSexcard_counts <- GertCardmort %>%
  group_by(DeathDate, Sex) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = Sex, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate,
         Female = "2",
         Male = "1") %>% 
  select(-"9")


GertCardmort <- GertCardmort %>%
  mutate(age_category = case_when(
    AGEYEAR < 10 ~ "BelowTen",
    AGEYEAR >= 10 & AGEYEAR <= 64 ~ "TenToSixtyFour",
    AGEYEAR >= 65 ~ "SixtyFivePlus"
  ))

# Group by death_date and age_category and count deaths
GertAgecard_counts <- GertCardmort %>%
  group_by(DeathDate, age_category) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = age_category, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)


air_pollution_data = read.csv("Data/GertsDaily.csv", header = T, sep = ";")


air_pollution_data <- air_pollution_data %>%
  mutate(date = as.Date(date, format = "%Y/%m/%d"))


GertPollMort <- air_pollution_data %>%
  left_join(GertAllcard_counts, by = "date")

GertPollMort <- GertPollMort %>%
  left_join(GertSexcard_counts, by = "date")

GertPollMort <- GertPollMort %>%
  left_join(GertAgecard_counts , by = "date")

write.csv(GertPollMort, "Data/GertPollCardMort.csv", row.names = TRUE)




### Pulmonary

GertPulmort <- Mortality %>% 
  filter(death_district == 'Gert Sibande') %>% 
  filter(Underlying_Main_Grp == 'I00_I99')  

GertAllPul_counts <-  GertPulmort %>%
  group_by(DeathDate) %>%
  summarize(death_count = n())%>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)

GertSexPul_counts <- GertPulmort %>%
  group_by(DeathDate, Sex) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = Sex, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate,
         Female = "2",
         Male = "1") %>% 
  select(-"9")


GertPulmort <- GertPulmort %>%
  mutate(age_category = case_when(
    AGEYEAR < 10 ~ "BelowTen",
    AGEYEAR >= 10 & AGEYEAR <= 64 ~ "TenToSixtyFour",
    AGEYEAR >= 65 ~ "SixtyFivePlus"
  ))

# Group by death_date and age_category and count deaths
GertAgePul_counts <- GertPulmort %>%
  group_by(DeathDate, age_category) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = age_category, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)


GertPollMort <- air_pollution_data %>%
  left_join(GertAllPul_counts, by = "date")

GertPollMort <- GertPollMort %>%
  left_join(GertSexPul_counts, by = "date")

GertPollMort <- GertPollMort %>%
  left_join(GertAgePul_counts , by = "date")

write.csv(GertPollMort, "Data/GertPollPulMort.csv", row.names = TRUE)



### Nkangala

### Cardiovacular

NkaCardmort <- Mortality %>% 
  filter(death_district == 'Nkangala') %>% 
  filter(Underlying_Main_Grp == 'J00_J99')  

NkaAllcard_counts <-  NkaCardmort %>%
  group_by(DeathDate) %>%
  summarize(death_count = n())%>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)

NkaSexcard_counts <- NkaCardmort %>%
  group_by(DeathDate, Sex) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = Sex, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate,
         Female = "2",
         Male = "1") %>% 
  select(-"8", -"9")


NkaCardmort <- NkaCardmort %>%
  mutate(age_category = case_when(
    AGEYEAR < 10 ~ "BelowTen",
    AGEYEAR >= 10 & AGEYEAR <= 64 ~ "TenToSixtyFour",
    AGEYEAR >= 65 ~ "SixtyFivePlus"
  ))

# Group by death_date and age_category and count deaths
NkaAgecard_counts <- NkaCardmort %>%
  group_by(DeathDate, age_category) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = age_category, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)


air_pollution_data = read.csv("Data/NkaDaily.csv", header = T, sep = ";")


air_pollution_data <- air_pollution_data %>%
  mutate(date = as.Date(date, format = "%Y/%m/%d"))


NkaPollMort <- air_pollution_data %>%
  left_join(NkaAllcard_counts, by = "date")

NkaPollMort <- NkaPollMort %>%
  left_join(NkaSexcard_counts, by = "date")

NkaPollMort <- NkaPollMort %>%
  left_join(NkaAgecard_counts , by = "date")

write.csv(NkaPollMort, "Data/NkaPollCardMort.csv", row.names = TRUE)




### Pulmonary

NkaPulmort <- Mortality %>% 
  filter(death_district == 'Nkangala') %>% 
  filter(Underlying_Main_Grp == 'I00_I99')  

NkaAllPul_counts <-  NkaPulmort %>%
  group_by(DeathDate) %>%
  summarize(death_count = n())%>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)

NkaSexPul_counts <- NkaPulmort %>%
  group_by(DeathDate, Sex) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = Sex, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate,
         Female = "2",
         Male = "1") %>% 
  select(- "8", -"9")


NkaPulmort <- NkaPulmort %>%
  mutate(age_category = case_when(
    AGEYEAR < 10 ~ "BelowTen",
    AGEYEAR >= 10 & AGEYEAR <= 64 ~ "TenToSixtyFour",
    AGEYEAR >= 65 ~ "SixtyFivePlus"
  ))

# Group by death_date and age_category and count deaths
NkaAgePul_counts <- NkaPulmort %>%
  group_by(DeathDate, age_category) %>%
  summarize(death_count = n(), .groups = 'drop') %>%
  pivot_wider(names_from = age_category, values_from = death_count, values_fill = list(death_count = 0)) %>% 
  mutate(DeathDate = as.Date(DeathDate, format = "%d-%m-%Y")) %>%
  rename(date = DeathDate)


NkaPollMort <- air_pollution_data %>%
  left_join(NkaAllPul_counts, by = "date")

NkaPollMort <- NkaPollMort %>%
  left_join(NkaSexPul_counts, by = "date")

NkaPollMort <- NkaPollMort %>%
  left_join(NkaAgePul_counts , by = "date")

write.csv(NkaPollMort, "Data/NkaPollPulMort.csv", row.names = TRUE)








