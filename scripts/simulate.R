args<-commandArgs(TRUE)
wd<-args[1]
sap<-args[2]
sim.num<-args[3]

bed<-read.table("region_bed_w1_tri.bed")
tri.count<-read.table(paste0(sap,".w1_tri_count.txt"),row.names = 1)
tri.count.mut<-read.table(paste0(sap,".w1_tri_count_mut.txt"))
n<-nrow(tri.count)

final.result<-data.frame(V1=NA,V2=NA,V3=NA,V4=NA,V5=NA)
final.result<-final.result[-1,]
for(i in 1:n){
  context<-rownames(tri.count)[i]
  tmp<-subset(bed,V4==context)
  n1<-nrow(tmp)
  num<-sample(1:n1,tri.count[context,], replace=F)
  tmp1<-tmp[num,]
  tmp2<-tri.count.mut[grep(context,tri.count.mut$V1),]
  tmp1$mut<-c(rep(as.character(tmp2$V1),tmp2$V2))
  final.result<-rbind(tmp1,final.result)
}
write.table(final.result,paste0(wd,"/","simulate_",sim.num,".txt"),sep="\t",quote = F,row.names = F,col.names = F)
