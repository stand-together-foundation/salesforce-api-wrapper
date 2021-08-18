library(dplyr, warn.conflicts = FALSE)
library(salesforcer)
library(dotenv)
library(stringr)

dotenv::load_dot_env()

sf_auth(username = Sys.getenv('SF_USER'), 
        password = Sys.getenv('SF_PASSWORD'), 
        security_token = Sys.getenv('SF_TOKEN'))

`%notin%` <- Negate(`%in%`)

get_concept_tibble <- function(concept = NULL) {
  compound_fields <- sf_describe_object_fields(concept) %>% 
    .$compoundFieldName %>%
    unique() %>%
    na.omit()
  all_fields <- sf_describe_object_fields(concept) %>% 
    .$name
  get_fields <- all_fields[all_fields %notin% compound_fields]
  get_fields_txt <- paste(get_fields, collapse=", ")
  query_string <- paste0('SELECT ', get_fields_txt, ' FROM ', concept)
  tib <- sf_query_bulk(soql = query_string, guess_types = FALSE)
  return(tib)
}

dedup_concept_tibble <- function(tib = NULL, grouper = 'Organization__c') {
  tib_full <- tib %>% 
    mutate(
      updated_at = lubridate::as_datetime(SystemModstamp)
    )
  
  tib_current <- inner_join(
    tib_full %>% 
      group_by(across(starts_with(grouper))) %>% 
      summarise(
        latest_updated_at = max(updated_at)
      ), 
    tib_full, 
    by = c(grouper, 'latest_updated_at' = 'updated_at')
  )
  
  return(tib_current)
}

organizations <- get_concept_tibble(concept = 'Account')
evaluations <- get_concept_tibble(concept = 'Evaluation__c')
referrals <- get_concept_tibble(concept = 'Referral__c')
opportunities <- get_concept_tibble(concept = 'Opportunity') 
assessments <- get_concept_tibble(concept = 'Assessment__c')
