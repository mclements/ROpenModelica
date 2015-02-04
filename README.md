## ROpenModelica: an R package to script OpenModelica.

This is a small R package for scripting OpenModelica.

One can define a model using a string:

```c++
model <- "
model CalledbyR
Real x(start=1.0),y(start=2.0);
parameter Real b = 2.0;
equation
der(x) = -b*y;
der(y) = x;
end CalledbyR;"
```

Then the model can be simulated thus:

```c++
out <- callOpenModelica("CalledbyR", model)
```

The function `callOpenModelica` returns a data-frame, which can be plotted:

```c++
plot(y~time, data=out, type="l")
```

The default script can be altered to change different arguments to `simulate()`. So:

```c++
out <- callOpenModelica("CalledbyR", 
                        model, 
                        script=defaultScript("CalledbyR",stopTime=10))
plot(y~time, data=out, type="l")
```

This also allows for multiple simulations with different parameter values:

```c++
out <- callOpenModelica("CalledbyR",
                        model,
                        script=defaultScriptWithParameter("CalledbyR", "b", stopTime=10), 
                        values=c(0.5,1,2))
if (require(ggplot2))
   qplot(x=time, y=y, data=transform(out, value=factor(value)), color=value, geom="line")
```
