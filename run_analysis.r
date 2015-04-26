


# limpar memória do R / clear memory of R
rm(list=ls(all=TRUE))

# indicar diretório de trabalho / indicate working directory
setwd("C://Coursera")


#define arquivos / defines files
zipfile <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipdir <- "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# apaga arquivos se existentes / delete files if any
unlink(zipfile, recursive = FALSE, force = FALSE)
unlink(zipdir, recursive = TRUE, force = TRUE)

# efetuar o download do arquivo / download the file
download.file(fileUrl,destfile=zipfile, method="internal")

# extrair os arquivos (unzip) / extract files (unzip)
unzip (zipfile, exdir = ".", overwrite = TRUE)

#ler arquivos de treinamento / read training files
file_subject_train <-read.table(file="C:/Coursera/UCI HAR Dataset/train/subject_train.txt")
file_x_train <-read.table(file="C:/Coursera/UCI HAR Dataset/train/x_train.txt", sep="")
file_y_train <-read.table(file="C:/Coursera/UCI HAR Dataset/train/y_train.txt")

#ler arquivos de testes / read tests files
file_subject_test <- read.table(file="C:/Coursera/UCI HAR Dataset/test/subject_test.txt")
file_x_test <-read.table(file="C:/Coursera/UCI HAR Dataset/test/x_test.txt", sep="")
file_y_test <-read.table(file="C:/Coursera/UCI HAR Dataset/test/y_test.txt")

#obter descrição das atividades / get description of activities
file_activity <- read.table(file="C:/Coursera/UCI HAR Dataset/activity_labels.txt")
file_y_train$V1 <- file_activity$V2[file_y_train$V1]
file_y_test$V1 <-  file_activity$V2[file_y_test$V1]


#unificar dados de train e test / unify train and test data
new_subject <- rbind(file_subject_train, file_subject_test)
new_x <- rbind(file_x_train, file_x_test)
new_y <- rbind(file_y_train, file_y_test)


#identificar colunas / identify columns
file_features <-read.table(file="C:/Coursera/UCI HAR Dataset/features.txt", sep="")
col_features <- file_features$V2
names(new_x) <- col_features
names(new_y) <- "Activity"
names(new_subject) <- "subject"


#combinar arquivos / combine files
new_dataset <- cbind(new_subject, new_y)
new_dataset <- cbind(new_dataset, new_x)

#remover colunas / remove Columns
keeps <- c("subject", "Activity" )
keeps <- c( keeps, as.character(col_features[grep("mean",col_features,fixed=T)]))
keeps <- c( keeps, as.character(col_features[grep("std",col_features,fixed=T)]))
data_set <- new_dataset[,keeps]

#obter listas de assuntos e atividades / get lists of subject and activities
unique_subject <- unique(data_set$subject)
unique_activity <- unique(data_set$Activity)
 

#calcular médias / calculate averages
xx <- c()
attach(data_set)
for (u_subject in unique_subject) {
  for (u_activity in unique_activity) {
    partial_data_set <- data_set[ Activity == u_activity & subject == u_subject, ]
    x <- colMeans(partial_data_set[,3:(length(partial_data_set))])
    xx <- rbind(xx, c(u_subject, u_activity,x) )
  }
}

#Exporta dados para arquivo / Export data to file
colnames(xx) <- colnames(data_set)
write.table(xx, "data.txt", sep = ";", row.names=FALSE) 

