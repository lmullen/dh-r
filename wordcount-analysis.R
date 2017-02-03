#!/usr/bin/env Rscript --vanilla

# Create charts of wordcounts

suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(ggplot2))

wc_files <- list.files("wordcounts", full.names = TRUE)

parse_filename_date <- function(x) {
  x %>%
    str_replace_all("wordcounts/wc-", "") %>%
    str_replace_all("\\.txt", "") %>%
    parse_datetime()
}

get_chapter <- function(x) {
  x %>%
    str_replace_all("_book/", "") %>%
    str_replace_all("\\.md", "")
}

parse_wc_files <- function(path) {
  path %>%
    read_lines() %>%
    str_trim() %>%
    str_split_fixed("\\s", 2) %>%
    as_data_frame() %>%
    rename(wordcount = V1, filename = V2) %>%
    mutate(wordcount = as.integer(wordcount),
           chapter = get_chapter(filename),
           datestamp = parse_filename_date(path)) %>%
    select(chapter, datestamp, wordcount)
}

wc <- map_df(wc_files, parse_wc_files)

wc_total <- wc %>%
  filter(chapter == "total")

wc <- wc %>%
  filter(chapter != "total")

dir.create("temp", showWarnings = FALSE)

total_plot <- ggplot(wc_total, aes(x = datestamp, y = wordcount)) +
  geom_line() +
  labs(title = "Total wordcount",
       subtitle = "Computational Historical Thinking",
       x = NULL,
       y = "words")
ggsave("temp/wordcount-total.png", total_plot, width = 8, height = 6)

chapter_plot <- ggplot(wc, aes(x = datestamp, y = wordcount, color = chapter)) +
  geom_line() +
  labs(title = "Wordcount by chapter",
       subtitle = "Computational Historical Thinking",
       x = NULL,
       y = "words",
       color = "Chapters")
ggsave("temp/wordcount-chapter.png", chapter_plot, width = 8, height = 6)
