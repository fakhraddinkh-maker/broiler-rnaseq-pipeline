# 🧬 RNA-seq Analysis of Avilamycin-Induced Transcriptomic Changes in Broiler Chicken Cecum

![R](https://img.shields.io/badge/R-4.x-blue)
![DESeq2](https://img.shields.io/badge/DESeq2-RNAseq-orange)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-Transcriptomics-green)
![Status](https://img.shields.io/badge/Status-Reproducible-success)

---

## 📌 Project Overview

This repository contains a reproducible RNA-seq analysis workflow investigating the transcriptomic effects of **Avilamycin supplementation** in broiler chickens.

The study evaluates differential gene expression in cecal tissue and explores the biological pathways affected by Avilamycin treatment through Gene Ontology (GO) and KEGG enrichment analyses.

The workflow was implemented in R using Bioconductor packages and demonstrates a complete transcriptomic analysis pipeline from differential expression analysis to biological interpretation.

---

## 🧠 Biological Question

How does dietary Avilamycin supplementation alter gene expression patterns and biological pathways in the cecum of broiler chickens?

---

## 📊 Dataset

**Data Source:** GEO Series GSE135272

**Organism:** *Gallus gallus* (Chicken)

**Tissue:** Cecum

### Experimental Design

| Group | Samples |
|---------|---------:|
| Control | 10 |
| Avilamycin | 10 |
| Total | 20 |

RNA-seq count data were analyzed using the DESeq2 framework.

---

## 🔬 Differential Expression Analysis

Differential expression analysis was performed using DESeq2.

### Summary Statistics

| Metric | Value |
|---------|-------:|
| Genes analyzed | 18,986 |
| Significant DEGs (FDR < 0.05) | 1,647 |
| Upregulated in Control | 888 |
| Upregulated in Avilamycin | 759 |

A total of 18,986 genes were analyzed, and 1,647 genes were identified as significantly differentially expressed between experimental groups after multiple-testing correction (FDR < 0.05).

---

## 🧬 Functional Enrichment Analysis

To investigate the biological significance of differential expression, genes upregulated in each group were analyzed using Gene Ontology (GO) and KEGG pathway enrichment analyses.

### Genes Upregulated in Avilamycin-Treated Chickens

#### Top GO Terms

| GO Term | p-value |
|----------|---------:|
| Defense response | 2.01 × 10⁻¹¹ |
| Response to external stimulus | 2.33 × 10⁻¹⁰ |
| Response to bacterium | 8.37 × 10⁻⁹ |
| Extracellular space | 1.57 × 10⁻⁸ |
| Extracellular region | 2.06 × 10⁻⁸ |
| Response to other organism | 1.63 × 10⁻⁷ |

#### Top KEGG Pathways

| Pathway | p-value |
|----------|---------:|
| Cytokine-cytokine receptor interaction | 1.01 × 10⁻⁶ |
| NOD-like receptor signaling pathway | 4.42 × 10⁻³ |
| Influenza A | 5.97 × 10⁻³ |

**Interpretation**

Genes upregulated in the Avilamycin-treated group were strongly enriched for immune-related and host-defense processes, including responses to bacteria and external stimuli. KEGG analysis further highlighted activation of cytokine signaling and innate immune pathways, suggesting that Avilamycin supplementation may modulate immune activity within the cecal environment.

---

### Genes Upregulated in Control Chickens

#### Top GO Terms

| GO Term | p-value |
|----------|---------:|
| PPAR signaling pathway | 2.67 × 10⁻³ |
| Response to metal ions | 3.75 × 10⁻³ |
| Metallothioneins bind metals | 3.75 × 10⁻³ |
| Neuroactive ligand-receptor interaction | 4.29 × 10⁻³ |
| Retinol metabolism | 1.07 × 10⁻² |
| Stress response to copper ion | 4.16 × 10⁻² |

#### Top KEGG Pathways

| Pathway | p-value |
|----------|---------:|
| PPAR signaling pathway | 2.67 × 10⁻³ |
| Neuroactive ligand-receptor interaction | 4.29 × 10⁻³ |

**Interpretation**

Genes upregulated in the control group were associated primarily with metabolic regulation, lipid metabolism, metal ion homeostasis, and signaling pathways. Enrichment of the PPAR signaling pathway suggests a stronger representation of metabolic processes relative to the Avilamycin-treated group.

---

## 📈 Enrichment Visualization

Combined visualization of GO and KEGG enrichment analyses:

![GO and KEGG Enrichment Results](Figure_GO_KEGG_panel_1.png)

---

## 📁 Repository Structure

```text
.
├── README.md
├── LICENSE
│
├── code/
│   └── full_pipeline.R
│
├── results/
│   ├── DESeq2_significant_genes.csv
│   ├── GO_up.csv
│   ├── GO_down.csv
│   ├── KEGG_up.csv
│   └── KEGG_down.csv
│
├── Up_in_Control.csv
├── Up_in_Avilamycin.csv
│
└── Figure_GO_KEGG_panel_1.png
```

## 🛠 Software and Packages

- R
- DESeq2
- clusterProfiler
- gprofiler2
- ggplot2
- dplyr
- enrichplot
- patchwork
- rtracklayer

---

## 🚀 Reproducibility

Clone the repository and run:

```r
source("code/full_pipeline.R")
```

The pipeline performs:

1. Differential expression analysis
2. Identification of significant DEGs
3. Functional enrichment analysis
4. Generation of publication-quality figures
5. Export of enrichment and gene lists

---

## 📋 Main Outputs

### Differential Expression

- DESeq2_significant_genes.csv
- Up_in_Control.csv
- Up_in_Avilamycin.csv

### Functional Enrichment

- GO_up.csv
- GO_down.csv
- KEGG_up.csv
- KEGG_down.csv

### Figures

- Figure_GO_KEGG_panel_1.png

---

## 👨‍🔬 Author

**Fakhrain Khodayari**

Ph.D. in Animal Science (Biotechnology)

Research Interests:

- Bioinformatics
- Transcriptomics
- RNA-seq Analysis
- Functional Genomics
- Multi-omics Data Integration
- Animal Biotechnology

GitHub: https://github.com/fakhraddinkh-maker

---

## 📄 License

This project is licensed under the MIT License.
