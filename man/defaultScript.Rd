\name{defaultScript}
\alias{defaultScript}
\title{
Create a default script string for loading and simulating a model.
}
\description{
Create a default script for loading and simulating a model.
  }
\usage{
defaultScript(modelName, startTime=0, \dots)
}
\arguments{
  \item{modelName}{
    a string for the name of the model to be simulated. [required]
  }
  \item{startTime}{
    OpenModelica \code{simulate} argument
  }
  \item{\dots}{
    additional arguments to be passed to the OpenModelica \code{simulate} call.
  }
}
%% \details{
  
%% }
\value{
A string representation of the script.
}
\seealso{
See Also \code{\link{callOpenModelica}} and \code{\link{defaultScriptWithParameter}}.
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
