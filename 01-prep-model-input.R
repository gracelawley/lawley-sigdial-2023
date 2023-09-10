library(readr)
library(dplyr)
library(stringr)
library(tidytext)
library(textstem) # lemmatize_words()

set.seed(1234)

df_0 <- read_csv("data/20newsgroups.csv")

labels_to_keep <- c("comp.sys.ibm.pc.hardware", "comp.sys.mac.hardware",
                    "rec.sport.baseball", "rec.sport.hockey")

fillers <- c("uhhuh", "mmhmm", "hmm", "ah", "yep", "wow", "huh",
             "mm", "alright")


mod_input_utts <- df_0 |>
  # drop any empty docs
  mutate(text = str_trim(text)) |>
  filter(!is.na(text)) |>
  filter(text != "") |>

  # extract category from label - e.g., "rec", "comp"
  mutate(category = str_extract(label, "[a-z]+")) |>

  # create a doc_id - e.g., "rec_doc-1"
  group_by(category) |>
  mutate(doc_id = paste0(label, "_doc-", row_number())) |>
  ungroup() |>

  # select sample
  filter(nchar(text) >= 500) |> # drop docs with length less than 500 chars
  filter(label %in% labels_to_keep) # only keep docs w/ these labels


mod_input_words <- mod_input_utts |>
  # unnest into tokens
  group_by(doc_id) |>
  unnest_tokens(word, text) |>
  ungroup() |>

  # process words -------------------
  # - initialize new col for processed words (passed to LDA later)
  mutate(word_proc = word) |>
  # - lemmatize words -- e.g., troubling/troubles -> trouble
  mutate(word_proc = lemmatize_words(word_proc)) |>
  # - drop numbers
  mutate(word_proc = if_else(str_detect(word_proc, "[:digit:]"),
                             NA_character_,
                             word_proc)) |>
  # - drop stop words
  mutate(word_proc = if_else(word_proc %in% stop_words$word,
                             NA_character_,
                             word_proc)) |>
  # drop other fillers
  mutate(word_proc = if_else(word_proc %in% fillers,
                             NA_character_,
                             word_proc))



# create document-term matrix
mod_input_dtm <- mod_input_words |>
  filter(!is.na(word_proc)) |>
  count(doc_id, word_proc) |>
  cast_dtm(document = doc_id,
           term = word_proc,
           value = n)



saveRDS(mod_input_utts, "data/mod-input_utts.RDS")
saveRDS(mod_input_words, "data/mod-input_words.RDS")
saveRDS(mod_input_dtm, "data/mod-input_dtm.RDS")
