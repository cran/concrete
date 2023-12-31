% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/formatArguments.R
\name{formatArguments}
\alias{formatArguments}
\alias{makeITT}
\alias{print.ConcreteArgs}
\title{formatArguments}
\usage{
formatArguments(
  DataTable,
  EventTime,
  EventType,
  Treatment,
  ID = NULL,
  TargetTime = NULL,
  TargetEvent = NULL,
  Intervention,
  CVArg = NULL,
  Model = NULL,
  MaxUpdateIter = 500,
  OneStepEps = 0.1,
  MinNuisance = 5/sqrt(nrow(DataTable))/log(nrow(DataTable)),
  Verbose = TRUE,
  GComp = TRUE,
  ReturnModels = TRUE,
  ConcreteArgs = NULL,
  RenameCovs = TRUE,
  ...
)

makeITT(...)

\method{print}{ConcreteArgs}(x, ...)
}
\arguments{
\item{DataTable}{data.table (n x (d + (3:5)); data.table of the observed data, with rows n =
the number of observations and d = the number of baseline covariates. DataTable must include
the following columns:
\itemize{
\item{"EventTime"}{: numeric; real numbers > 0, the observed event or censoring time}
\item{"EventType"}{: numeric; the observed event type, censoring events indicated by integers <= 0}
\item{"Treatment"}{: numeric; the observed treatment value. Binary treatments must be coded as 0, 1}
\item{"Treatment"}{: numeric; the observed treatment}
}
May include
\itemize{
\item{"ID"}{: factor, character, or numeric; unique subject id. If ID column is missing, row
numbers will be used as ID. For longitudinal data, ID must be provided}
\item{"Baseline Covariates"}{: factor, character, or numeric; }
}}

\item{EventTime}{character: the column name of the observed event or censoring time}

\item{EventType}{character: the column name of the observed event type. (0 indicating censoring)}

\item{Treatment}{character: the column name of the observed treatment assignment}

\item{ID}{character (default: NULL): the column name of the observed subject id
longitudinal data structures}

\item{TargetTime}{numeric: vector of target times. If NULL, the last observed non-censoring event
time will be targeted.}

\item{TargetEvent}{numeric: vector of target events - some subset of unique EventTypes. If NULL,
all non-censoring observed event types will be targeted.}

\item{Intervention}{list: a list of desired interventions on the treatment variable.
Each intervention must be a list containing two named functions:
'intervention' = function(treatment vector, covariate data) and
'gstar' = function(treatment vector, covariate data)
concrete::makeITT() can be used to specify an intent-to-treat analysis for a
binary intervention variable}

\item{CVArg}{list: arguments to be passed into do.call(origami::make_folds). If NULL, the default is
list(n = nrow(DataTable), fold_fun = folds_vfold, cluster_ids = NULL, strata_ids = NULL)}

\item{Model}{list (default: NULL): named list of models, one for each failure or censoring event
and one for the 'Treatment' variable. If Model = NULL, then
a template will be generated for the user to amend.}

\item{MaxUpdateIter}{numeric (default: 500): the number of one-step update steps}

\item{OneStepEps}{numeric (default: 1): the one-step tmle step size}

\item{MinNuisance}{numeric (default: 5/log(n)/sqrt(n)): value between (0, 1) for truncating the g-related denominator of the clever covariate}

\item{Verbose}{boolean}

\item{GComp}{boolean (default: TRUE): return g-computation formula plug-in estimates}

\item{ReturnModels}{boolean (default: TRUE): return fitted models from the initial estimation stage}

\item{ConcreteArgs}{list (default: NULL, not yet ready) : Use to recheck amended output from previous formatArguments()
calls. A non-NULL input will cause all other arguments to be ignored.}

\item{RenameCovs}{boolean (default: TRUE): whether or not to rename covariates}

\item{...}{additional arguments to be passed into print methods}

\item{x}{a ConcreteArgs object}
}
\value{
a list of class "ConcreteArgs"
\itemize{
\item{Data}{: data.table containing EventTime, EventType, Treatment, and potentially ID and baseline covariates. Has the following attributes}
\itemize{
\item{EventTime}{: the column name of the observed event or censoring time}
\item{EventType}{: the column name of the observed event type. (0 indicating censoring)}
\item{Treatment}{: the column name of the observed treatment assignment}
\item{ID}{: the column name of the observed subject id}
\item{RenameCovs}{: boolean whether or not covariates are renamed}
}
\item{TargetTime}{: numeric vector of target times to evaluate risk/survival}
\item{TargetEvent}{: numeric vector of target events}
\item{Regime}{: named list of desired regimes, each tagged with a 'g.star' attribute function}
\itemize{
\item{Regime[[i]]}{: a vector of desired treatment assignments}
\item{attr(Regime[[i]], "g.star")}{: function of Treatment and Covariates, outputting a vector of desired treatment assignment probabilities}
}
\item{CVFolds}{: list of cross-validation fold assignments in the structure as output by origami::make_folds()}
\item{Model}{: named list of model specifications, one for each unique 'EventType' and one for the 'Treatment' variable.}
\item{MaxUpdateIter}{: the number of one-step update steps}
\item{OneStepEps}{: list of cross-validation fold assignments in the structure as output by origami::make_folds()}
\item{MinNuisance}{: numeric lower bound for the propensity score denominator in the efficient influence function}
\item{Verbose}{: boolean to print additional information}
\item{GComp}{: boolean to return g-computation formula plug-in estimates}
\item{ReturnModels}{: boolean to return fitted models from the initial estimation stage}
}
}
\description{
formatArguments() checks and reformats inputs into a form that can be interpreted by doConcrete().
makeITT() returns an Intervention list for a single, binary, point-treatment variable
}
\section{Functions}{
\itemize{
\item \code{makeITT()}: makeITT ...

\item \code{print(ConcreteArgs)}: print.ConcreteArgs print method for "ConcreteArgs" class

}}
\examples{
library(data.table)
library(concrete)

data <- as.data.table(survival::pbc)
data <- data[1:200, .SD, .SDcols = c("id", "time", "status", "trt", "age", "sex")]
data[, trt := sample(0:1, nrow(data), TRUE)]

# makeITT() creates a list of functions to specify intent-to-treat
#   regimes for a binary, single, point treatment variable
intervention <- makeITT()

# formatArguments() returns correctly formatted arguments for doConcrete()
#   If no input is provided for the Model argument, a default will be generated
\donttest{concrete.args <- formatArguments(DataTable = data,
                                 EventTime = "time",
                                 EventType = "status",
                                 Treatment = "trt",
                                 ID = "id",
                                 TargetTime = 2500,
                                 TargetEvent = c(1, 2),
                                 Intervention = intervention,
                                 CVArg = list(V = 2))

# Alternatively, estimation algorithms can be provided as a named list
model <- list("trt" = c("SL.glm", "SL.glmnet"),
              "0" = list(Surv(time, status == 0) ~ .),
              "1" = list(Surv(time, status == 1) ~ .),
              "2" = list(Surv(time, status == 2) ~ .))
concrete.args <- formatArguments(DataTable = data,
                                 EventTime = "time",
                                 EventType = "status",
                                 Treatment = "trt",
                                 ID = "id",
                                 TargetTime = 2500,
                                 TargetEvent = c(1, 2),
                                 Intervention = intervention,
                                 CVArg = list(V = 2), 
                                 Model = model)

# 'ConcreteArgs' output can be modified and passed back through formatArguments()
# examples of modifying the censoring and failure event candidate regressions
concrete.args[["Model"]][["0"]] <-
    list(Surv(time, status == 0) ~ trt:sex + age)
concrete.args[["Model"]][["1"]] <-
    list("mod1" = Surv(time, status == 1) ~ trt,
         "mod2" = Surv(time, status == 1) ~ .)
formatArguments(concrete.args)}

}
