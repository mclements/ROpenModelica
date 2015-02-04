defaultScriptWithParameter <-
function(modelName,
             parameter=stop("parameter name required"),
             startTime=0, ...) {
    args <- c(list(startTime=startTime),list(...))
    args <- paste(names(args),args,sep="=",collapse=",")
    list(prefix=sprintf("loadFile(\"%s.mo\");",modelName),
         each=sprintf("setComponentModifierValue(%s, %s, $Code(=%%f));
simulate(%s,%s,outputFormat=\"csv\");",
            modelName, parameter,
            modelName, args))
}
