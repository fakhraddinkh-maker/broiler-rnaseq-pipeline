### ======================================================
### FULL RNA-seq GO + KEGG PIPELINE (FINAL STABLE VERSION)
### Fakhraddin Khodayari - PhD ready pipeline
### ======================================================

rm(list = ls())
gc()

### ===============================
### 1. LIBRARIES
### ===============================
library(dplyr)
library(ggplot2)
library(clusterProfiler)
library(enrichplot)
library(gprofiler2)
library(rtracklayer)
library(patchwork)

### ===============================
### 2. BASE PATH (FIXED)
### ===============================
base <- "phd_application_project/data/rnaseq"

### ===============================
### 3. LOAD GENE LISTS
### ===============================
load(file.path(base, "../gene_lists.RData"))

up_list   <- unique(up_list)
down_list <- unique(down_list)
sig_list  <- unique(sig_list)

### ===============================
### 4. GTF FILE
### ===============================
gtf_file <- file.path(base,
                      "Gallus_gallus_gca000002315v5.GRCg6a.116.gtf.gz")

stopifnot(file.exists(gtf_file))

gtf <- rtracklayer::import(gtf_file)
gtf_df <- as.data.frame(gtf)

gene_map <- gtf_df %>%
  dplyr::filter(type == "gene") %>%
  dplyr::select(gene_id, gene_name) %>%
  dplyr::distinct() %>%
  dplyr::filter(!is.na(gene_name))

map <- setNames(gene_map$gene_name, gene_map$gene_id)

up_symbol   <- unique(na.omit(map[up_list]))
down_symbol <- unique(na.omit(map[down_list]))
sig_symbol  <- unique(na.omit(map[sig_list]))

### ===============================
### 5. GO ENRICHMENT
### ===============================
go_up <- gost(query = up_symbol,
              organism = "ggallus",
              significant = FALSE)

go_down <- gost(query = down_symbol,
                organism = "ggallus",
                significant = FALSE)

go_up_clean <- go_up$result %>%
  dplyr::filter(significant == TRUE) %>%
  dplyr::arrange(p_value) %>%
  dplyr::select(term_name, p_value, intersection_size, term_size)

go_down_clean <- go_down$result %>%
  dplyr::filter(significant == TRUE) %>%
  dplyr::arrange(p_value) %>%
  dplyr::select(term_name, p_value, intersection_size, term_size)

### ===============================
### 6. KEGG ENRICHMENT
### ===============================
kegg_up <- gost(query = up_symbol,
                organism = "ggallus",
                sources = "KEGG",
                significant = FALSE)

kegg_down <- gost(query = down_symbol,
                  organism = "ggallus",
                  sources = "KEGG",
                  significant = FALSE)

kegg_up_clean <- kegg_up$result %>%
  dplyr::filter(significant == TRUE) %>%
  dplyr::arrange(p_value) %>%
  dplyr::select(term_name, p_value, intersection_size)

kegg_down_clean <- kegg_down$result %>%
  dplyr::filter(significant == TRUE) %>%
  dplyr::arrange(p_value) %>%
  dplyr::select(term_name, p_value, intersection_size)

### ===============================
### 7. SAVE RESULTS
### ===============================
dir.create("phd_application_project/results", showWarnings = FALSE, recursive = TRUE)
dir.create("phd_application_project/figures", showWarnings = FALSE, recursive = TRUE)

write.csv(go_up_clean,   "phd_application_project/results/GO_up.csv", row.names = FALSE)
write.csv(go_down_clean, "phd_application_project/results/GO_down.csv", row.names = FALSE)
write.csv(kegg_up_clean, "phd_application_project/results/KEGG_up.csv", row.names = FALSE)
write.csv(kegg_down_clean, "phd_application_project/results/KEGG_down.csv", row.names = FALSE)

### ===============================
### 8. PLOTS
### ===============================

p_go_up <- ggplot(head(go_up_clean, 15),
                  aes(x = -log10(p_value),
                      y = reorder(term_name, p_value))) +
  geom_point(size = 3, color = "steelblue") +
  labs(title = "GO Upregulated",
       x = "-log10(p-value)", y = NULL) +
  theme_minimal(base_size = 12)

p_go_down <- ggplot(head(go_down_clean, 15),
                    aes(x = -log10(p_value),
                        y = reorder(term_name, p_value))) +
  geom_point(size = 3, color = "firebrick") +
  labs(title = "GO Downregulated",
       x = "-log10(p-value)", y = NULL) +
  theme_minimal(base_size = 12)

p_kegg_up <- ggplot(head(kegg_up_clean, 15),
                    aes(x = -log10(p_value),
                        y = reorder(term_name, p_value))) +
  geom_point(size = 3, color = "darkgreen") +
  labs(title = "KEGG Upregulated",
       x = "-log10(p-value)", y = NULL) +
  theme_minimal(base_size = 12)

p_kegg_down <- ggplot(head(kegg_down_clean, 15),
                      aes(x = -log10(p_value),
                          y = reorder(term_name, p_value))) +
  geom_point(size = 3, color = "purple") +
  labs(title = "KEGG Downregulated",
       x = "-log10(p-value)", y = NULL) +
  theme_minimal(base_size = 12)

### ===============================
### 9. FINAL FIGURE
### ===============================
final_figure <- (p_go_up | p_go_down) /
  (p_kegg_up | p_kegg_down)

ggsave("phd_application_project/figures/Figure_GO_KEGG_panel.pdf",
       final_figure,
       width = 12, height = 8, dpi = 300)

print("PIPELINE COMPLETED SUCCESSFULLY")