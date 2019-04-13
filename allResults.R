library("edgeR")
library("DESeq2")
library("pheatmap")
# Load all counts generated using featureCounts to quanitify gene expression
load("allCounts.RData")

allDataDF<-data.frame(SRR6832917_Repcounts$annotation[,c("Chr","Start","End","Strand")],SRR6832917_Repcounts$counts, SRR6832919_Repcounts$counts, SRR6832920_Repcounts$counts, SRR6832923_Repcounts$counts, SRR6336932_Repcounts$counts, SRR6336933_Repcounts$counts,stringsAsFactors=FALSE)
sumExp <- makeSummarizedExperimentFromDataFrame(allDataDF)
colnames(sumExp) <- c("SRR6832917_1", "SRR6832917_2", "SRR6832917_3", "SRR6832917_4", "SRR6832919_1", "SRR6832919_2", "SRR6832919_3", "SRR6832919_4", "SRR6832920_1", "SRR6832920_2", "SRR6832920_3", "SRR6832920_4", "SRR6832923_1", "SRR6832923_2", "SRR6832923_3", "SRR6832923_4", "SRR6336932_1", "SRR6336932_2", "SRR6336932_3", "SRR6336932_4", "SRR6336933_1", "SRR6336933_2", "SRR6336933_3", "SRR6336933_4")

countdata <- assay(sumExp)
coldata = data.frame(sample_class=c("CNS","CNS","CNS","CNS", "Cephalic tentacle", "Cephalic tentacle", "Cephalic tentacle", "Cephalic tentacle", "Cephalic lobe", "Cephalic lobe", "Cephalic lobe", "Cephalic lobe","Buccal mass","Buccal mass","Buccal mass","Buccal mass", "Mantle proximal", "Mantle proximal", "Mantle proximal", "Mantle proximal", "Mantle edge","Mantle edge","Mantle edge","Mantle edge"))

ddsMat <- DESeqDataSetFromMatrix(countdata, coldata, design = ~sample_class)
dds <- DESeq(ddsMat)

genetable <- data.frame(gene.id=rownames(sumExp))
y <- DGEList(countdata,samples=coldata, genes=genetable)
names(y)

# Variance stabilizing transformation (VST) is carried out for count data to stabilize the variance across the mean
vsd <- vst(dds)

# Visualize sample-to-sample distances using PCA plot
plotPCA(vsd, intgroup=c("sample_class"))

# DESeq results
results <- results(dds)
mcols(results, use.names=TRUE)
summary(results)
results.05 <- results(dds, alpha=.05)
table(results.05$padj < .05)

mat.05 <- assay(vsd)[ head(order(results.05$padj),50), ]
mat.05 <- mat.05 - rowMeans(mat.05)
#plotMA(results, ylim=c(-5,5))
df <- as.data.frame(colData(vsd)[,c("sample_class")])
rownames(df) <- colnames(mat.05)
colnames(df) <- "Tissue"
pheatmap(mat.05,annotation_col=df)


test <- assay(vsd)[head(order(results.05$log2FoldChange),50),c(1:4,21:24)]
test <- assay(vsd)[c(229,4284,4280,2603,134,477,50,132431,259667,132812,183661,132813,183671) ,]
test <- test - rowMeans(test)
pheatmap(test,annotation_col=df)


mat.05m <- assay(vsd)[ head(order(results.05$padj),5000), ]
mat.05m <- mat.05m - rowMeans(mat.05m)
#plotMA(results, ylim=c(-5,5))
dfm <- as.data.frame(colData(vsd)[,c("sample_class")])
pheatmap(mat.05m,annotation_col=df)
