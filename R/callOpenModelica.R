callOpenModelica <-
function(modelName,
                         model,
                         script=defaultScript(modelName),
                         values=NULL,
                         omcCommand="omc",
                         omcArgs="",
                         omcModels="Modelica") {
    ## move to a temporary directory
    oldwd <- getwd()
    on.exit(setwd(oldwd))
    setwd(tempdir())
    ## If more than one value: call for each value and return a list
    ## set up file names
    moFile <- sprintf("%s.mo", modelName)
    mosFile <- sprintf("%s.mos", modelName)
    if (is.null(values)) {
        newscript <- script
    } else { ## for each simulation, rename the output csv file
        each <- sapply(1:length(values),
                       function(i)
                       sprintf(paste(c(script$each, "system(\"mv %s_res.csv %s_res-%i.csv\");"),
                                     collapse="\n"),
                               values[i], modelName, modelName, i))
        newscript <- paste(c(script$prefix, each, "\n"), collapse="\n")
    }
    ## write the model and script files
    cat(model, file=moFile)
    cat(newscript, file=mosFile)
    ## compile and run the simulation
    system(sprintf("%s %s %s %s", omcCommand, omcArgs, mosFile, omcModels))
    ## read in the results file(s)
    if (is.null(values)) {
        out <- read.csv(sprintf("%s_res.csv", modelName), header=TRUE)
    } else {
        out <- lapply(1:length(values),
                      function(i) 
                      data.frame(read.csv(sprintf("%s_res-%i.csv", modelName, i), header=TRUE),
                                 value=values[i]))
        out <- do.call("rbind", out)
    }
    structure(out, script=newscript, model=model)
}
