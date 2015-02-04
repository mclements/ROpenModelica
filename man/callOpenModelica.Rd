\name{callOpenModelica}
\alias{callOpenModelica}
\title{
Call OpenModelica to simulate a model
}
\description{
Call OpenModelica to simulate a model. Includes the facility to run
multiple simulations for different parameter values.
}
\usage{
callOpenModelica(modelName, model, script=defaultScript(modelName),
values=NULL, omcCommand="omc",omcArgs="",omcModels="Modelica")}
\arguments{
  \item{modelName}{
    a string for the name of the model to be simulated. [required]
  }
  \item{model}{
    a string representation of the model to be simulated. [required]
  }
  \item{script}{
    either (i) a string representation of the simulation script (see \code{\link{defaultScript}}) or (ii) a
    list with a component for the "prefix" for the start of the script and a
    component for "each" simulation for different parameter values (see \code{\link{defaultScriptWithParameter}}).
  }
  \item{values}{
    vector of numeric values to  be passed for the parameter.
  }
  \item{omcCommand}{
    string representing the command to call omc.}
  \item{omcArgs}{
    string representing the arguments to omc that precedes the script
    and library arguments.}
  \item{omcModels}{
    string representing the other Modelica libraries required.}
}
\value{
A \code{data.frame} object from the simulation output with column names
"time" and other columns as per the simulation.
}
%% \references{
%% %% ~put references to the literature/web site here ~
%% }
%% \author{
%% %%  ~~who you are~~
%% }
%% \note{
%% %%  ~~further notes~~
%% }
%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{
See Also \code{\link{defaultScript}}, \code{\link{defaultScriptWithParameter}}
}
\examples{
\dontrun{
model <- "
model CalledbyR
  Real x(start=1.0),y(start=2.0);
  parameter Real b = 2.0;
equation
  der(x) = -b*y;
  der(y) = x;
end CalledbyR;"

out <- callOpenModelica("CalledbyR", model)
plot(y~time, data=out, type="l")

out <- callOpenModelica("CalledbyR", model, script=defaultScript("CalledbyR",stopTime=10))
plot(y~time, data=out, type="l")

out <-  callOpenModelica("CalledbyR",
                     model,
                     script=defaultScriptWithParameter("CalledbyR", "b", stopTime=10),
                     values=c(0.5,1,2))
if (require(ggplot2))
    qplot(x=time, y=y, data=transform(out, value=factor(value)), color=value, geom="line")

}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%%\keyword{ ~kwd1 }
%%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
