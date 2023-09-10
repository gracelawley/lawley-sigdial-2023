library(topicmodels)
library(tidytext)
library(dplyr)
library(tidyr)
library(compositions) # ilr()

mod_input_dtm <- readRDS("data/mod-input_dtm.RDS")

# fit LDA model with k = 20
lda20_full <- LDA(mod_input_dtm, k = 20, method = "VEM",
                      control = list(seed = 1234))


# get document distributions and reshape
lda20_gamma <- tidy(lda20_full, matrix = "gamma") |>
  pivot_wider(names_from = topic, values_from = gamma) |>
  separate(document, into = c("label", "doc_id"), sep = "_") |>
  select(-doc_id)


# perform isometric log-ratio transformation
lda20_gamma_ilr <- lda20_gamma |>
  select(-label) |> # drop label col for now
  ilr() |>
  as.data.frame() |>
  mutate(label = lda20_gamma$label) # add label back in


saveRDS(lda20_full, "data/lda20_full.RDS")
saveRDS(lda20_gamma, "data/lda20_gamma.RDS")
saveRDS(lda20_gamma_ilr, "data/lda20_gamma_ilr.RDS")