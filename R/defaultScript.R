defaultScript <-
function(modelName, startTime=0, ...) {
    args <- c(list(startTime=startTime),list(...))
    args <- paste(names(args),args,sep="=",collapse=",")
    sprintf("loadFile(\"%s.mo\");
simulate(%s,%s,outputFormat=\"csv\");",
            modelName,
            modelName, args)
}
