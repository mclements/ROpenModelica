\name{defaultScriptWithParameter}
\alias{defaultScriptWithParameter}
\title{
Create a default script for loading and simulating a model with a
varying parameter.
}
\description{
Create a default script for loading and simulating a model with a
varying parameter.
  }
\usage{
defaultScriptWithParameter(modelName, parameter=stop("parameter name required"), startTime=0, \dots) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{modelName}{
    a string for the name of the model to be simulated. [required]
  }
  \item{parameter}{
    a string for the parameter to be varied [required]
  }
  \item{startTime}{
    OpenModelica \code{simulate} argument.
    }
\item{\dots}{
  additional arguments to be passed to the OpenModelica \code{simulate} call.
}
}
\value{
A list with two components. The first component "prefix" is a string for
the model loading etc. The second component "each" is for each
simulation, including a template string for the parameter value to be simulated.
}
\seealso{
See Also \code{\link{callOpenModelica}} and \code{\link{defaultScript}}.
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
