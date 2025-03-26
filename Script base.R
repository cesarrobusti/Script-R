# Chamar a biblioteca e iniciar a aplicação web
library(bibliometrix)
biblioshiny()

# Realizar as conversões e juntar as diferentes bases
base1 <- convert2df("C:/Users/cesar/Downloads/pubmed-artificial-set.txt", dbsource = "pubmed", format = "PubMed export file")

base2 <- convert2df("C:/Users/cesar/Downloads/savedrecs.txt", dbsource = "wos", format = "plaintext")

base3 <- convert2df("C:/Users/cesar/Downloads/scopus.csv", dbsource = "scopus", format = "csv")

junta <- mergeDbSources(base2, base3, remove.duplicated = TRUE)

# GERAR ARQUIVO CSV 
# write.table(junta, "C:/Users/cesar/Downloads/dadosunificados.csv", sep = ";", row.names = FALSE)
# GERAR ARQUIVO XLSX
library(openxlsx)
write.xlsx(junta, file = "C:/Users/cesar/Downloads/dadosunificados2.csv")

# Rodar análises
parcial <- junta[,c("DI", "PY", "AU", "TI", "SO", "DT", "DE", "TC", "CR")]

write.table(junta, "C:/Users/cesar/Downloads/Artigo IA SEMEAD/dadosparcial.xlsx", sep = ";", row.names = FALSE)

Res <- biblioAnalysis(base1)

DS <- summary(object = Res, k = 10)

plot(Res, k = 10)

# REDE DE COLABORAÇÃO ENTRE PAÍSES #

M <- metaTagExtraction(base1, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, n = dim(NetMatrix)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.7,cluster="none")

# Create a co-citation network

NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, n = 30, Title = "Co-Citation Network", type = "fruchterman", size=T, remove.multiple=FALSE, labelsize=0.7,edgesize = 5)
