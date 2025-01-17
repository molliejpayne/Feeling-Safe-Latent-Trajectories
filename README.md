
## Feeling Safe Latent Trajectories and Principal Trajectories Analysis


### Overview
This document outlines the procedures used to conduct both Latent Trajectories Analysis and Principal Trajectories Analysis for the Feeling Safe trial. It provides a step-by-step explanation of the coding and methodology used in each analysis.

### Latent Trajectory Modelling.do
The first file contains the code used to define the latent classes underlying the recovery trajectories observed within the Feeling Safe arm of the *Feeling Safe* trial (Jenner et al., 2024; Freeman et al., 2021). This Stata file details the steps required to identify the optimal latent trajectory model for the data by comparing different models, class solutions, and constraints.

### Principal Trajectories Procedure.do
The second document demonstrates how to perform a Principal Trajectories Analysis (Dunn et al., 2015). In this file, we run the optimal model derived from the first file and assign control arm participants to the latent class they would most likely have belonged to had they received Feeling Safe therapy. We then estimate the effect of randomization within these classes, as well as the potential mediators associated with each class.

#### References:
- Jenner L, Payne M, Waite F, Beckwith H, Diamond R, Isham L, Collett N, Emsley R, Freeman D. Theory-driven psychological therapy for persecutory delusions: trajectories of patient outcomes. Psychol Med. 2024;54:4173-81. doi:10.1017/S0033291724002113.
- Freeman D, Carr L, et al. Comparison of a theoretically driven cognitive therapy (the Feeling Safe Programme) with befriending for the treatment of persistent persecutory delusions: a parallel, single-blind, randomised controlled trial. Lancet Psychiatry. 2021;8(8):696-707.
- Dunn G, Emsley R, Liu H, et al. Evaluation and validation of social and psychological markers in randomised trials of complex interventions in mental health: a methodological research programme. Health Technol Assess (Winchester, Engl). 2015 Nov;19(93):1-115, v-vi. doi:10.3310/hta19930.
