## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  echo = TRUE, 
  eval = FALSE
)

## ----setup--------------------------------------------------------------------
#  library(concrete)
#  library(data.table)
#  set.seed(12345)
#  data <- as.data.table(survival::pbc)
#  data <- data[!is.na(trt), ][, trt := trt - 1]
#  data <- data[, c("time", "status", "trt", "age", "sex", "albumin")]

## ----singlebinaryintervention-------------------------------------------------
#  ConcreteArgs <- formatArguments(DataTable = data,
#                                  EventTime = "time",
#                                  EventType = "status",
#                                  Treatment = "trt",
#                                  Intervention = 0:1,
#                                  TargetTime = 1500,
#                                  TargetEvent = 1:2,
#                                  MaxUpdateIter = 250,
#                                  CVArg = list(V = 10),
#                                  Verbose = FALSE)
#  ConcreteEst <- doConcrete(ConcreteArgs)
#  ConcreteOut <- getOutput(ConcreteEst)

## ----jointbinaryintervention--------------------------------------------------
#  data <- data[, trt2 := sample(0:1, .N, replace = TRUE, prob = c(0.3, .7))]
#  Intervention <- makeITT("A1" = data.frame(trt = rep_len(1, nrow(data)),
#                                            trt2 = rep_len(1, nrow(data))),
#                          "A0" = data.frame(trt = rep_len(0, nrow(data)),
#                                            trt2 = rep_len(0, nrow(data))))
#  
#  ConcreteArgs <- formatArguments(DataTable = data,
#                                  EventTime = "time",
#                                  EventType = "status",
#                                  Treatment = c("trt", "trt2"),
#                                  Intervention = Intervention,
#                                  TargetTime = 2000,
#                                  TargetEvent = 1:2,
#                                  MaxUpdateIter = 250,
#                                  CVArg = list(V = 10),
#                                  Verbose = FALSE)
#  ConcreteEst <- doConcrete(ConcreteArgs)
#  ConcreteOut <- getOutput(ConcreteEst)

