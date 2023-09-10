// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// getCleverCovariate
arma::dmat getCleverCovariate(arma::dvec GStar, arma::dmat NuisanceWeight, arma::dmat hFS, int LeqJ);
RcppExport SEXP _concrete_getCleverCovariate(SEXP GStarSEXP, SEXP NuisanceWeightSEXP, SEXP hFSSEXP, SEXP LeqJSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::dvec >::type GStar(GStarSEXP);
    Rcpp::traits::input_parameter< arma::dmat >::type NuisanceWeight(NuisanceWeightSEXP);
    Rcpp::traits::input_parameter< arma::dmat >::type hFS(hFSSEXP);
    Rcpp::traits::input_parameter< int >::type LeqJ(LeqJSEXP);
    rcpp_result_gen = Rcpp::wrap(getCleverCovariate(GStar, NuisanceWeight, hFS, LeqJ));
    return rcpp_result_gen;
END_RCPP
}
// getHazLS
arma::dmat getHazLS(arma::dvec T_Tilde, arma::dvec EvalTimes, arma::dmat HazL);
RcppExport SEXP _concrete_getHazLS(SEXP T_TildeSEXP, SEXP EvalTimesSEXP, SEXP HazLSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::dvec >::type T_Tilde(T_TildeSEXP);
    Rcpp::traits::input_parameter< arma::dvec >::type EvalTimes(EvalTimesSEXP);
    Rcpp::traits::input_parameter< arma::dmat >::type HazL(HazLSEXP);
    rcpp_result_gen = Rcpp::wrap(getHazLS(T_Tilde, EvalTimes, HazL));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_concrete_getCleverCovariate", (DL_FUNC) &_concrete_getCleverCovariate, 4},
    {"_concrete_getHazLS", (DL_FUNC) &_concrete_getHazLS, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_concrete(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
