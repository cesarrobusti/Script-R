# Instala o pacote bibliometrix a partir do console
install.packages("bibliometrix")

# Chama a biblioteca
library(bibliometrix)

# Inicia a aplicação web 
biblioshiny()

# Realiza as conversões e junta as diferentes bases
base1 <- convert2df("C:/Users/USUARIO/Downloads/pubmed-artificial-set.txt", dbsource = "pubmed", format = "PubMed export file")

base2 <- convert2df("C:/Users/USUARIO/Downloads/savedrecs.txt", dbsource = "wos", format = "plaintext")

base3 <- convert2df("C:/Users/USUARIO/Downloads/scopus.csv", dbsource = "scopus", format = "csv")

junta <- mergeDbSources(base2, base3, remove.duplicated = TRUE)

# GERA ARQUIVO XLSX
library(openxlsx)
write.xlsx(junta, file = "C:/Users/USUARIO/Downloads/dadosunificados2.xlsx")

# GERA ARQUIVO CSV 
write.table(junta, "C:/Users/USUARIO/Downloads/dadosunificados.csv", sep = ";", row.names = FALSE)