library(tidyverse)
library(ggpubr)
library(see)
library(ggbeeswarm)
library(forcats)
library(dplyr)
library(cowplot)
library(rstatix)
library(ggsci)
library(MASS)
library(lme4)


#####################################################
####################### PLOTS #######################
#####################################################


## Plot n nodes of kept  after 1/f thresh

data_conn = as_tibble(read.table('graph_table_nodes_kept_1f_only.csv', sep = ",", header = TRUE))
data_conn$frequencies = as.factor(data_conn$frequencies)

p <- data_conn %>%
  mutate(frequencies = fct_relevel(frequencies, "delta", "theta", "alpha", "beta", "gamma")) %>%
  ggplot(aes(x = frequencies, y = n_nodes_kept, fill = group))+
  scale_fill_manual(values=c("#884da7", "#b67823")) +
  #  geom_violin(alpha=0.9, position = position_dodge(width = .75),size=1,color=NA) +
  geom_boxplot(notch = F,  outlier.size = -1, color="black",lwd=0.5, alpha = 0.7,show.legend = T)+
  # geom_point( shape = 21,size=2, position = position_jitterdodge(), color="black",alpha=1)+
  ggbeeswarm::geom_quasirandom(shape = 21,size=2, dodge.width = .75, color="black",alpha=.5,show.legend = F)+
  theme_minimal()+
  ylab(  c("Number of kept nodes after 1/f correction")  )  +
  xlab(  c("Frequencies")  )  +
  theme(#panel.border = element_rect(colour = "black", fill=NA, size=2),
    axis.line = element_line(colour = "black",size=1),
    axis.ticks = element_line(size=1,color="black"),
    axis.text = element_text(color="black"),
    axis.ticks.length=unit(0.2,"cm"),
    legend.position = c(0.95, 0.85),
    plot.title = element_text(size = 20))+
  font("xylab",size=15)+  
  font("xy",size=15)+ 
  font("xy.text", size = 15) +  
  font("legend.text",size = 15)+
  guides(fill = guide_legend(override.aes = list(alpha = 1,color="black")))

p


## Plot percentage of kept connections after 1/f thresh

data_conn = as_tibble(read.table('graph_table_connexions_kept_1f_only.csv', sep = ",", header = TRUE))
data_conn$frequencies = as.factor(data_conn$frequencies)

p <- data_conn %>%
  mutate(frequencies = fct_relevel(frequencies, "delta", "theta", "alpha", "beta", "gamma")) %>%
  ggplot(aes(x = frequencies, y = pct_cx_kept_only1f, fill = group))+
  scale_fill_manual(values=c("#884da7", "#b67823")) +
  #  geom_violin(alpha=0.9, position = position_dodge(width = .75),size=1,color=NA) +
  geom_boxplot(notch = F,  outlier.size = -1, color="black",lwd=0.5, alpha = 0.7,show.legend = T)+
  # geom_point( shape = 21,size=2, position = position_jitterdodge(), color="black",alpha=1)+
  ggbeeswarm::geom_quasirandom(shape = 21,size=2, dodge.width = .75, color="black",alpha=.5,show.legend = F)+
  theme_minimal()+
  ylab(  c("% of kept connections 1/f only")  )  +
  xlab(  c("Frequencies")  )  +
  theme(#panel.border = element_rect(colour = "black", fill=NA, size=2),
    axis.line = element_line(colour = "black",size=1),
    axis.ticks = element_line(size=1,color="black"),
    axis.text = element_text(color="black"),
    axis.ticks.length=unit(0.2,"cm"),
    legend.position = c(0.95, 0.85),
    plot.title = element_text(size = 20))+
  font("xylab",size=15)+  
  font("xy",size=15)+ 
  font("xy.text", size = 15) +  
  font("legend.text",size = 15)+
  guides(fill = guide_legend(override.aes = list(alpha = 1,color="black")))

p


## Plot percentage of kept connections after 5% and 1/f thresh

data_conn = as_tibble(read.table('graph_table_connexions_kept_5pct_and_1f.csv', sep = ",", header = TRUE))
data_conn$frequencies = as.factor(data_conn$frequencies)
data_conn = data_conn[which(data_conn$fc_meth == "wpli"),]


p2 <- data_conn %>%
  mutate(frequencies = fct_relevel(frequencies, "delta", "theta", "alpha", "beta", "gamma")) %>%
  ggplot(aes(x = frequencies, y = pct_cx_kept, fill = group))+
  scale_fill_manual(values=c("#884da7", "#b67823")) +
#  geom_violin(alpha=0.9, position = position_dodge(width = .75),size=1,color=NA) +
  geom_boxplot(notch = F,  outlier.size = -1, color="black",lwd=0.5, alpha = 0.7,show.legend = F)+
  # geom_point( shape = 21,size=2, position = position_jitterdodge(), color="black",alpha=1)+
  ggbeeswarm::geom_quasirandom(shape = 21,size=2, dodge.width = .75, color="black",alpha=.5,show.legend = F)+
  theme_minimal()+
  ylab(  c("% of kept connections")  )  +
  xlab(  c("Frequencies")  )  +
  theme(#panel.border = element_rect(colour = "black", fill=NA, size=2),
    axis.line = element_line(colour = "black",size=1),
    axis.ticks = element_line(size=1,color="black"),
    axis.text = element_text(color="black"),
    axis.ticks.length=unit(0.2,"cm"),
    legend.position = c(0.95, 0.85),
    plot.title = element_text(size = 20))+
  font("xylab",size=15)+  
  font("xy",size=15)+ 
  font("xy.text", size = 15) +  
  font("legend.text",size = 15)+
  guides(fill = guide_legend(override.aes = list(alpha = 1,color="black")))+
  ggtitle("wPLI")

ggarrange(p1, p2, p3, p4, p5,
          ncol = 2, nrow = 3)


## Plot graph metrics

data = as_tibble(read.table('graph_table.csv', sep = ",", header = TRUE))
data$frequencies = as.factor(data$frequencies)
data = data[which(data$fc_meth == "oenv"),]
data = data[which(data$thresh_met == "node_1f"),]



p <- data %>%
  
  mutate(frequencies = fct_relevel(frequencies, "delta", "theta", "alpha", "beta", "gamma")) %>%
  ggplot(aes(x = frequencies, y = mean_betweenness, fill = group))+
  scale_fill_manual(values=c("#884da7", "#b67823")) +
  #  geom_violin(alpha=0.9, position = position_dodge(width = .75),size=1,color=NA) +
  geom_boxplot(notch = F,  outlier.size = -1, color="black",lwd=0.5, alpha = 0.7,show.legend = F)+
  # geom_point( shape = 21,size=2, position = position_jitterdodge(), color="black",alpha=1)+
  ggbeeswarm::geom_quasirandom(shape = 21,size=2, dodge.width = .75, color="black",alpha=.5,show.legend = F)+
  theme_minimal()+
  ylab(  c("Mean betweenness centrality")  )  +
  xlab(  c("Frequencies")  )  +
  theme(#panel.border = element_rect(colour = "black", fill=NA, size=2),
    axis.line = element_line(colour = "black",size=1),
    axis.ticks = element_line(size=1,color="black"),
    axis.text = element_text(color="black"),
    axis.ticks.length=unit(0.2,"cm"),
    legend.position = c(0.95, 1),
    plot.title = element_text(size = 20))+
  font("xylab",size=15)+  
  font("xy",size=15)+ 
  font("xy.text", size = 15) +  
  font("legend.text",size = 15)+
  guides(fill = guide_legend(override.aes = list(alpha = 1,color="black")))+
  ggtitle("5% proportional + 1/f")+
  ylim(0, 175)


#####################################################
####################### STATS #######################
#####################################################

########### STATS DATASET A

# GRAPH METRIC STATS - (gp x thresh_met) -------------------------------------

data = as_tibble(read.table('graph_table.csv', 
                            sep = ";", header = TRUE))

data$frequencies = as.factor(data$frequencies)
data$thresh_met = as.factor(data$thresh_met)
data$sub = as.factor(data$sub)
data = data[which(data$fc_meth == "plv"),]
data = data[which(data$frequencies == "alpha"),]

### STATS -------------------------------------------------------------------

# Stats
data2 <- data %>%
  group_by(sub, group, thresh_met) %>% 
  convert_as_factor(sub, thresh_met, group)

# Descriptive stats
data2 %>%
  group_by(thresh_met, group) %>%
  get_summary_stats(path, type = "mean_sd")

# Identify outliers
data2 %>%
  group_by(thresh_met, group) %>%
  identify_outliers(path)

######## 2 assumptions for repeated measures ANOVA ####################
# 1st one : the data at each time point are approximately normally distributed

# Normality check
data2 %>%
  group_by(thresh_met, group) %>%
  shapiro_test(path)

ggqqplot(data2, "path", ggtheme = theme_bw()) +
  facet_grid(thresh_met ~ group, labeller = "label_both")

# 2nd point : sphericity = the variances of the differences between all combinations
# of the related conditions points are equal 

# Calculate anova
data2 = as.data.frame(data2)
res.aov <- anova_test(
  data = data2, dv = path, wid = sub,
  between = group, within = thresh_met
)
res.aov

get_anova_table(res.aov, correction = c("auto"))


metric_results = matrix(nrow=1, ncol=6, byrow=TRUE)

# specify the column names and row names of matrix
colnames(metric_results) = c('F_group','F_threshmet', 'F_interaction','p_group','p_threshmet','p_inter')

# # assign to table
#expo_results = as.table(expo_results)

metric_results[1,1] = res.aov$F[1]
metric_results[1,2] = res.aov$F[2]
metric_results[1,3] = res.aov$F[3]
metric_results[1,4] = res.aov$p[1]
metric_results[1,5] = res.aov$p[2]
metric_results[1,6] = res.aov$p[3]

# import the table with all p-values for each method in order to apply the FDR correction 

p = read.table("pval_plv_graph.csv", sep=";",header=F)
p1 = p[,1]
p = as.numeric(unlist(p))
a = p.adjust(p,method="fdr",n=length(p))

########### STATS DATASET B

# GRAPH METRIC STATS - (thresholding effect) -------------------------------------

data = as_tibble(read.table('graph_table_SRM.csv', 
                            sep = ",", header = TRUE))

data$frequencies = as.factor(data$frequencies)
data$thresh_met = as.factor(data$thresh_met)
data$sub = as.factor(data$sub)
data = data[which(data$fc_meth == "plv"),]
data = data[which(data$frequencies == "alpha"),]

### STATS -------------------------------------------------------------------

# Stats
data2 <- data %>%
  group_by(sub, thresh_met) %>% 
  convert_as_factor(sub, thresh_met)

# Descriptive stats
data2 %>%
  group_by(thresh_met) %>%
  get_summary_stats(mean_clustering, type = "mean_sd")

# Identify outliers
data2 %>%
  group_by(thresh_met) %>%
  identify_outliers(mean_clustering)

### PAIRED T-TEST STUDENT

stat.test <- data2  %>% 
  t_test(mean_clustering ~ thresh_met, paired = TRUE) %>%
  add_significance()
stat.test

size =  data2  %>% cohens_d(mean_clustering ~ thresh_met, paired = TRUE)

metric_results = matrix(nrow=1, ncol=5, byrow=TRUE)

# specify the column names and row names of matrix
colnames(metric_results) = c('T','df', 'p_threshmet','effsize','magnitude')

# # assign to table
#expo_results = as.table(expo_results)

metric_results[1,1] = stat.test$statistic
metric_results[1,2] = stat.test$df
metric_results[1,3] = stat.test$p
metric_results[1,4] = size$effsize
metric_results[1,5] = size$magnitude

write.csv(metric_results, "mean_clustering_alpha_SRM.csv", row.names=TRUE)

# import the table with all p-values for each method in order to apply the FDR correction 
p = read.table("pval_SRM_PLV_r.csv", sep=",",header=F)

p1 = p[,1]

p = as.numeric(unlist(p))
a = p.adjust(p,method="fdr",n=length(p))


write.csv(a, "pvalc_PLV_graph_metrics_SRM.csv", row.names=TRUE)






