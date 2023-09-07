# Lawley et al. (2023)

This repository contains the code used for the *20Newsgroup* analysis in [A Statistical Approach for Quantifying Group Difference in Topic Distributions Using Clinical Discourse Samples]() (Lawley et al., SIGDIAL 2023). 

# Abstract

>Topic distribution matrices created by topic models are typically used for document classification or as features in a separate machine learning algorithm. Existing methods for evaluating these topic distributions include metrics such as coherence and perplexity; however, there is a lack of statistically grounded evaluation tools. We present a statistical method for investigating group difference in the document-topic distribution vectors created by latent Dirichlet allocation (LDA). After transforming the vectors using Aitchison geometry, we use multivariate analysis of variance (MANOVA) to compare sample means and calculate effect size using partial eta-squared. We report the results of validating this method on a subset of the *20Newsgroup* corpus. We also apply this method to a corpus of dialogues between Autistic and Typically Developing (TD) children and trained examiners. We found that the topic distributions of Autistic children differed from those of TD children when responding to questions about social difficulties. Furthermore, the examiners’ topic distributions differed between the Autistic and TD groups when discussing emotions and social difficulties. These results support the use of topic modeling in studying clinically relevant features of social communication such as topic maintenance.

# Scripts

- `00-get-data.py` -- retrieve *20Newsgroup* dataset using the `scikit-learn` and reshape
- `01-prep-model-input.R` -- select subset and preprocess text
- `02-fit-LDA-model.R` -- fit LDA model with $k=20$ and save output
- `03-analysis.Rmd` -- source code for the analysis
- `03-analysis.html` -- rendered analysis 

# Citation

To cite this paper, please use the following BiBTex entry (will be updated once conference papers are uploaded to the ACL anthology):

```
@inproceedings{lawley-sigdial-2023a,
  author = {Lawley, Grace O. and Heeman, Peter A. and Dolata, Jill K. and Fombonne, Eric and Bedrick, Steven},
  title = {{A Statistical Approach for Quantifying Group Difference in Topic Distributions Using Clinical Discourse Samples}},
  booktitle = {{Proceedings of the 24th Annual Meeting of the Special Interest Group on Discourse and Dialogue (SIGDIAL)}},
  publisher = "Association for Computational Linguistics",
  month = {09},
  year = {2023},
  location = {Prague, Czechia}
}
```
