#To execute : Rscript Analyse_Best.R project_name
#ex : if pdb files are named : NB2.B99990xxx.pdb
#run : Rscript Analyse_Best.R NB2

###################################################
########              FUNCTIONS            ########
###################################################
red=function(text){
  txt_r=paste("\033[31m",text,"\033[0m", sep="")
  return(txt_r)
}

scr_print=function(data,index_min,pdb_name){
  cat("\n **** Best model selector ****\n")
  cat(">> The best model is",red(pdb_name), "\n")
  cat(">> OBJECTIVE FUNCTION value : ",red(data[index_min,6]),"\n")
  
  dir.create("Best_Model", showWarnings=F)
  system(paste("cp ", pdb_name, "Best_Model/"))
  cat(">>", pdb_name, "was copied in",red("/Best_Model"),"folder\n")  
}

create_data=function(project_name){
  command=paste("grep 'OBJECTIVE' ", project_name,".B99990*.pdb > FunctionObj.data", sep="")
  system(command)
  #NB2.B99990001.pdb:REMARK   6 MODELLER OBJECTIVE FUNCTION:      4675.3364
  data=read.table("FunctionObj.data", sep="")
  data=as.matrix(data)
  index_min=which.min(data[,6])
  name=data[index_min, 1]
  pdb_name=strsplit(name, ":REMARK")[[1]]
  
  return(list(data, index_min, pdb_name))
}

Create_graph=function(data,index_min){
  num=as.numeric(data[,6])
  names(num)=1:length(num)
  ccol=rep("turquoise", length(num))
  ccol[index_min]="red"
  ymin=min(num)-sd(num)
  ymax=max(num)+sd(num)
  pdf("obj_graph.pdf", width=16, height=8)
  par(mfrow=c(1,2), pty = "s")
  barplot(num, col=ccol, ylim=c(ymin,ymax),
          ylab="Objective Function value", xlab="Model Number",
          main="Objective Function Value for each Modeller models", xpd=FALSE, cex.names=0.01)
  legend("topright", fill = c("red","turquoise"),
          legend=c("TOP model","Other models"))
  boxplot(num, main="Boxplot of Objective Function Value", ylab="Objectiv Function Value")
  
  dev.off()
  
  
  
  cat(">> Objective function value graph generated in",red("obj_graph.pdf"),"\n")
  
}

show_help=function(){
  cat("********************* HELP *********************\n")
  cat("To execute : Rscript Analyse_Best.R project_name\n")
  cat("ex : if pdb files are named :",red("NB2"),".B99990xxx.pdb\n", sep="")
  cat("run : Rscript Analyse_Best.R", red("NB2"),"\n")
}

##############################################
########              MAIN            ########
##############################################
args <- commandArgs(trailingOnly = TRUE)

if (is.element("-h",args)){
  show_help()
}else{
  data_list=create_data(args[1])
  scr_print(data_list[[1]], data_list[[2]], data_list[[3]])
  Create_graph(data_list[[1]], data_list[[2]])
}



