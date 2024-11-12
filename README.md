
**PROJECT**
These scripts were used for the analyses described in the paper 'Functional connectivity is dominated by aperiodic, rather than oscillatory, coupling'. This project aims to evaluate the contribution of aperiodic activity in estimating 
functional connectivity. To address this, we tested whether and how aperiodic activity impacts the reconstruction of putative oscillatory functional networks in two independent human EEG databases (n = 59, n = 103) during resting-state. These scripts are tailored to the organization of the database from the SRM project (dataset B), downloaded and then imported into Brainstorm. Careful attention must be paid to the data structure if you are using a tool other than Brainstorm. Some comments are included in the scripts to help adapt them to the structure of our database (dataset A). 

**SCRIPTS**
The compute_avg_matrices.m script computes the epoch-averaged functional connectivity matrix for each subject and for each connectivity metric (PLV, ciPLV, wPLI, AEC and orthoAEC). This script is used for both approaches (classical pipeline and
our approach proposed in this paper). 

The make_mask_matrices.m script computes the matrix identifying functional connections between ROIs, based on aperiodicity -unbiased oscillations according to the specparam results. If an aperiodicity-unbiased oscillation between [1-45] Hz was 
reported by the specparam algorithm in ROIi and in ROIj, it implies the presence of unbiased oscillations in two regions of interest. The matrix is obtained for each subject and for each connectivity metric.

The threshold_fc_matrices_proportional.m script performs the proportional thresholding to retain the top 5% of the strongest connections. This script is used for the standard approach.

The threshold_fc_matrices_1f_proportional.m script permits to obtain matrices retaining only functional connectivity results in ROIs exhibiting connections based on aperiodicity-unbiased oscillations. Then, matrices are proportionnaly thresholded to keep the top 5% of the strongest connections.
This script is used in our approach only. 

The compute_graph_metrics.m script computes some graph metrics commonly used to describe the topological graph properties of cortical networks: clustering coefficient, characteristic path length, global efficiency and betweenness centrality. Graph 
metrics were computed using the Brain Connectivity Toolbox (Rubinov et al., 2009). This script is used for both approaches. 

The compute_avg_matrices_coded_participant.m computes the matrix exhibiting the number of participants or the percentage of participants exhibiting 
connections betwenn ROIs. This script is used for both approaches.

**LICENSE**
This project is licensed under the CC-BY-NC-ND 4.0 International license.

**ACKNOWLEDGMENTS**
Many thanks to Dr Joan Duprez, the primary contributor to these scripts, as well as to Dr Julien Modolo and Pr Bradley Voytek for their valuable feedback on the analyses conducted.

If errors were to occur or if you have question regarding the code, feel free to email me at : noemie.monchy.1@univ-rennes1.fr 
