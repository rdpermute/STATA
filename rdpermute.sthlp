{smcl}
{* *! version 1.1.1 08nov2016}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "rdpermute##syntax"}{...}
{viewerjumpto "Description" "rdpermute##description"}{...}
{viewerjumpto "Options" "rdpermute##options"}{...}
{viewerjumpto "Examples" "rdpermute##examples"}{...}
{viewerjumpto "Stored Results" "rdpermute##stored_results"}{...}
{viewerjumpto "Remarks" "rdpermute##remarks"}{...}
{viewerjumpto "Dependencies" "rdpermute##dependencies"}{...}
{viewerjumpto "References" "rdpermute##references"}{...}
{viewerjumpto "Also See" "rdpermute##also_see"}{...}
{viewerjumpto "Authors" "rdpermute##authors"}{...}
{viewerjumpto "Acknowledgments" "rdpermute##acknowledgments"}{...}

{title:Title}

{hline}
{phang}{bf:rdpermute} {hline 2} Permutation test for RD and RK designs {p_end}
{hline}

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:rdpermute depen_var indep_var}
[{it:if}],
placebo_disconts({it:numlist})
true_discont({it:string})
[position_true_discont({it:#}) deriv_discont({it:#}) bw({it:#}) reg({it:#}) linear quad cubic skip_install filename({it:#}) save_path({it:#}) dgp({it:#}) bw_manual({it:#}) fg_bandwidth_scaling({it:# #}) fg_bias_porder({it:#}) fg_f_0({it:#}) fg_density_porder({it:#}) fg_num_bins({it:#}) cct_bw_par({it:#}) cct_reg_par({it:#}) silent ] ///


{p2colreset}{...}
{p 4 6 2}

{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required Parameters}
{synopt:{opt placebo_disconts(numlist)}} defines the locations of placebo discontinuities or kinks  {p_end}
{synopt:{opt true_discont(string)}} defines the position at which the true discontinuity or kink is located{p_end}

{syntab:Optional Parameters}
{synopt:{opt position_true_discont(integer)}} Position of the expected discontinuity {cmd:true_discont} in the vector {cmd:placebo_disconts}{p_end}
{synopt:{opt deriv_discont(integer 1)}} Specifies whether regression discontinuity (0) regression kink (1) design is implemented.{p_end}
{synopt:{opt bw(string)}} Defines procedure for bandwidth selection. Valid procedures are "bw","cct","fg", "fg_aic" and "manual". {p_end}
{synopt:{opt reg(string)}} Defines procedure for regression. Valid procedures are "regress","cct". {p_end}
{synopt:{opt linear/quad/cubic}} Specifies that a linear, quadratic, or cubic model be used.{p_end}

{synopt:{opt skip_install}} Skips the installation of required packages.{p_end}
{synopt:{opt filename(string)}} Name for final .dta output{p_end}
{synopt:{opt sav_path(string)}} Path for final .dta output{p_end}
{synopt:{opt dgp(string)}} Adds a column with an index variable to .dta output{p_end}

{synopt:{opt bw_manual(real 1)}} Manual bandwidth for choice reg(manual){p_end}
{synopt:{opt fg_bandwidth_scaling(numlist)}} Specifies the model dependent constants for the bandwidth calculation. {p_end}
{synopt:{opt fg_bias_porder(integer 4)}} Specifies maximal order of polynomial used to estimate m^2 m^3 and m^4 for "fg" bandwidth choice. {p_end}
{synopt:{opt fg_f_0(real 0)}} Specifies the placement of bins for the choice bw(fg). If not set, 50 equally spaced bins on the range of Data will be used.{p_end}
{synopt:{opt fg_density_porder(integer 3)}} Specifies polynomial order for density estimation{p_end}
{synopt:{opt fg_num_bins(integer 50)}} Specifies the number of equally spaced bins for the choice bw(fg) and fg_f_0(0){p_end}
{synopt:{opt cct_bw_par(string)}} Specifies additional/alternative parameters for the subroutine rdbwselect for the choice bw(cct){p_end}
{synopt:{opt cct_reg_par(string)}} Specifies additional/alternative parameters for the subroutine rdrobust for the choice reg(cct){p_end}
{synopt:{opt silent}} Generates less output while running{p_end}

{p2colreset}{...}
{p 4 6 2}


{marker description}{...}
{title:Description}

{pstd}{cmd:rdpermute} Implements a permutation test for regression discontinuity (RD) or regression kink (RK) designs based on Ganong and Jäger (2017). The code calculates RD or RK estimates at a list of pre-specified placebo discontinuities or kinks and computes both asymptotic and randomization-based p-values. It tests for the sharp null hypothesis of no effect of the policy on the outcome.  


{marker options}{...}
{title:Options}
{dlgtab:Required}

{phang}
{opt placebo_disconts} Defines the locations of placebo kinks.

{phang}
{opt true_discont} Defines the integer at which the true kink or discontinuity is located. This value has to appear in the set  {cmd:placebo_disconts}. If {cmd:placebo_disconts} is not generated manually, but automatically (for example by loops), it may happen that the binary representations of {cmd:true_discont} differs from its correspondent copy in {cmd:placebo_disconts}. In this case it is possible to use the parameter {cmd:position_true_discont} instead. Unless rdpermute prints an Error-message this is not necessary.


{dlgtab:Optional}

{phang}
{opt position_true_discont(integer -1)} Position of the expected discontinuity {cmd:true_discont} in the vector {cmd:placebo_disconts}. This parameter replaces {cmd:true_discont} in the case of binary representation Errors. 

{phang}
{opt deriv_discont(integer 1)} Specifies whether regression discontinuity (0) regression kink (1) design is implemented. Default is always regression kink design.

{phang}
{opt bw(string)} Defines the method for the calculation of bandwidths.  {opt "fg.aic"} is always used as default if nothing is specified. All possible choices are:
{break}{tab}{tab}{opt "- fg"}: Bandwidth choice as proposed by Fan and Gijbels. The additional parameters: {cmd:fg_bias_p_order} {cmd:fg_density_p_order}, {cmd:fg_num_bins}, {cmd:fg_f0}, {cmd:fg_bandwidth_scaling} can be used to alter the calculations.
{break}{tab}{tab}{opt "- fg.aic"}: Fan and Gijbels bandwidth choice with automatic selection of {cmd:fg_bias_p_order}. The additional parameters: {cmd:fg_density_p_order}, {cmd:fg_num_bins}, {cmd:fg_f0}, {cmd:fg_bandwidth_scaling} can be used to alter the the calculations.
{break}{tab}{tab}{opt "- cct"}: Uses the function {cmd:rdbwselect} by Calonico, Cattaneo and Titiunik as subroutine. The function call parameters of {cmd:rdbwselect} can be altered with the parameter {cmd:cct_bw_par}. Information on the package rdrobust and its functions is provided by Calonica, Cattaneo and Titiunik  {browse "https://sites.google.com/site/rdpackages/rdrobust"}
{break}{tab}{tab}{opt "- manual"}: Manual choice of a constant bandwidth for Data Points . The bandwidth can be set with the parameter {cmd:manual_bw}.


{phang}
{opt reg(string)} Defines the procedure for calculating the regressions calculating the p-values. {opt "regress"} is always used as default if nothing is specified. Valid procedures are "regress","cct". 
{break}{tab}{tab}{opt "- cct"}: Uses the function rdrobust by Calonico, Cattaneo and Titiunik as subroutine. The function call parameters of rdrobust can be altered with {cmd:cct_reg_par}. Information on the package rdrobust and its functions is provided by Calonica, Cattaneo and Titiunik {browse "https://sites.google.com/site/rdpackages/rdrobust"}
{break}{tab}{tab}{opt "- regress"}: Uses the Stata Regression Enviroment {cmd:regress}.


{phang}
{opt linear/quad/cubic} Specifies that a linear, quadratic, or cubic model be used. {cmd:rdpermute} will calculate the p-values for each specified model. If neither linear, quad nor cubic are specified, {cmd:rdpermute} will calculate the p-values for all of them automatically.

{phang}
{opt skip_install} Skips the installation of required packages. {cmd:rdpermute} will try to install all dependent packages automatically in a stable-predefined version. This is not always possible or desired. {cmd:skip_install} suppresses the installation. Attention: Some subroutines and parts of our code may not work if the dependent packages are not installed.

{phang}
{opt filename(string)} Name for final .dta output. Only if {cmd:filename} is provided, data will be saved}.

{phang}
{opt sav_path(string)} Path for final .dta output. If no {cmd:save_path} is provided, the results will automatically be placed in working directory.

{phang}
{opt dgp(string)} Adds a column with an index variable to .dta output

{phang}
{opt bw_manual(real 1)}  Is a numerical value for the method choice {cmd:reg(manual)}. The value will be used as bandwidth for the computation of the p-values for all placebo_disconts.

{phang}
{opt fg_bandwidth_scaling(numlist)} Specifies the model dependent constants for the bandwidth calculation Formula by Fan and Gijbels. It may be necessary to use other values than our presets for linear quadratic and cubic regressions. {cmd:fg_bandwidth_scaling[1]} describes the prefactor, {cmd:fg_bandwidth_scaling[2]} the used exponents. The parameter {cmd:fg_bandwidth_scaling} has to contain values for both entries. All other entries in {cmd:fg_bandwidth_scaling} are omitted. A detailed description of the Formula can be found in the References .

{phang}
{opt fg_bias_porder(integer 4)} Specifies maximal order of polynomial used to estimate m^2 m^3 and m^4 for bandwidth choice {cmd:bw(fg)}. This parameter is only necessary if the chosen method is fg and not  {cmd:bw(fg_aic)}. WARNING: A high fg_bias_p_order will result in the instability of the used regressions, without indication by STATA. The choice bw="fg.aic" will automatically prevent such Errors and is therefore set as default.

{phang}
{opt fg_f_0(real 0)} Specifies the placement of bins for the choice bw(fg). If not set, 50 equally spaced bins on the range of Data will be used. We recommend to leave this parameter empty for an automatic estimation of {cmd:bw(fg_f_0)}. If you wish to use a manual value you can define a numerical value in fg.f.0

{phang}
{opt fg_density_porder(integer 3)} Specifies polynomial order for density estimation meaning that it denounces the maximal exponent of x^p for the estimation of {cmd:bw(fg_f_0)} by regression. WARNING: A high {cmd:fg_density_p_order} may lead to the same problems as in {cdm:fg_bias_p_order}. We recommend to use the preset value.

{phang}
{opt fg_num_bins(integer 50)} Specifies the number of equally spaced bins for the choice cmd{bw(fg):} and {cmd:fg_f_0(0)} that is used to estimate {cmd:fg_f_0}

{phang}
{opt cct_bw_par(string)} Specifies additional/alternative parameters for the subroutine rdbwselect for the choice {cmd:bw(cct)}. All parameters of rdbwselect can be altered except for: y, x, p, q, deriv. To alter an Option define the intended values within HTML-Tags within the string. Example: {cmd:cct_bw_par("<kernel>epa</kernel><bwselect>cerrd</bwselect>")"

{phang}
{opt cct_reg_par(string)} Specifies additional/alternative parameters for the subroutine rdrobust for the choice {cmd:reg(cct)}. All parameters of rdrobust can be altered except for: y, x, p, q, deriv, h. Altering is done as in {cmd:cct_bw_par}.

{phang}
{opt silent} Generates less output while running



{hline}

{marker examples}{...}
{title:Examples}

{phang}
{cmd: rdpermute} {cmd:y} {cmd:x}, {cmd:placebo_disconts(-0.9(0.1)0.9)} {cmd:true_discont(0)} {cmd:linear} {cmd:quad} {cmd:silent} {cmd:bw(fg)} {cmd:sav_path(~/Data/working/)} {cmd:filename(placebo_pvalues)} {cmd:dgp(1)} {cmd:fg_density_porder(1)}{p_end}

{phang}
{cmd: rdpermute} {cmd:y} {cmd:x}, {cmd:placebo_disconts(-100(10)200)} {cmd:true_discont(20)} {cmd:linear} {cmd:silent} {cmd:bw(manual)} {cmd:sav_path(~/Data/working/)} {cmd:filename(placebo_pvalues)} {cmd:bw_manual(10)}{p_end}

{phang}
{cmd: rdpermute} {cmd:y} {cmd:x}, {cmd:placebo_disconts(1960(0.25)2017)} {cmd:true_discont(2000)} {cmd:linear} {cmd:quad} {cmd:bw(cct)} {cmd:reg(regress)}  {cmd:cct_bw_par(<bwselect>cerrd</bwselect>)}{p_end}

{phang}
{marker stored_results}{...}
{title:Stored Results}

{phang}
{cmd:rdpermute} stores the following in {cmd:e()} (Default matrix output): {p_end}

{p 8 8 2}{cmd:e}(kink_beta_linear){p_end}
{p 8 8 2}{cmd:e}(kink_se_linear){p_end}
{p 8 8 2}{cmd:e}(bw_linear){p_end}
{p 8 8 2}{cmd:e}(pval_linear){p_end}
{p 8 8 2}{cmd:e}(kink_beta_quadratic){p_end}
{p 8 8 2}{cmd:e}(kink_se_quadratic){p_end}
{p 8 8 2}{cmd:e}(bw_quadratic){p_end}
{p 8 8 2}{cmd:e}(pval_quadratic){p_end}
{p 8 8 2}{cmd:e}(kink_beta_cubic){p_end}
{p 8 8 2}{cmd:e}(kink_se_cubic){p_end}
{p 8 8 2}{cmd:e}(bw_cubic){p_end}
{p 8 8 2}{cmd:e}(pval_cubic){p_end}
	
{p 4 4 2}	
With N as number of placebo kinks, matrices kink* and bw* are Nx2. Column 1 is output using "cct" bandwidth choice. Column 2 uses "fg" bandwidth choice.	

{p 4 4 2}
Matrices pval* are 2 x 2. Row 1 is asymptotic p-value. Row 2 is randomization p-value.	
	
{p 4 4 2}
Optional .dta output: collapses all of the above into a single file.		

{marker dependencies}{...}
{title:Dependencies}{...}
{pstd}

{phang} {cmd:rdrobust}  Calonico, Matias D. Cattaneo, Max H. Farrell and Rocio Titiunik{p_end}
{phang} {cmd:rdbwselect}  Calonico, Matias D. Cattaneo, Max H. Farrell and Rocio Titiunik{p_end}
{phang} {cmd:rd} Austin Nichols{p_end}

{phang} All dependent packages will automatically download at the first run of rdpermute. See {cmd: skip_install} for suppressing the installation.{p_end}

{marker references}{...}
{title:References}{...}

{pstd}

{phang} Calonico, S., Cattaneo, M. D., and Titiunik, R. "Robust Nonparametric Confidence Intervals for Regression-Discontinuity Designs." {it:Econometrica}, 82(6):2295-2326 (2014). {p_end}

{phang} Fan, J. and Gijbels, I. {it:Local Polynomial Modelling and Its Applications,} volume 66. Chapman and Hall (1996). {p_end}

{phang} Ganong, P. and Jäger, S. "A Permutation Test for the Regression Kink Design." {it:Journal of the American Statistical Association} (2017). {p_end}


{marker also_see}{...}
{title:Also See}

{phang} {browse "http://www-personal.umich.edu/~cattaneo/software/rdrobust/stata/rdbwselect.pdf":rdbwselect} - Bandwidth Selection Procedures for Local Polynomial Regression Discontinuity Estimators (by Calonico, Cattaneo, Farrell, and Titiunik){p_end}

{phang} {browse "http://www-personal.umich.edu/~cattaneo/software/rdrobust/stata/rdrobust.pdf":rdrobust} - Local Polynomial Regression Discontinuity Estimation with Robust Bias-Corrected Confidence Intervals and Inference Procedures (by Calonico, Cattaneo, Farrell, and Titiunik) {p_end}

{phang} {browse "http://www-personal.umich.edu/~cattaneo/software/rdrobust/stata/rdplot.pdf":rdplot} - Data-Driven Regression Discontinuity Plots (by Calonico, Cattaneo, Farrell, and Titiunik) {p_end}


{marker authors}{...}
{title:Authors}{...}


{pstd} Peter Ganong, University of Chicago, ganong@uchicago.edu {p_end}

{phang}Simon Jäger, MIT, sjaeger@mit.edu {p_end}

{marker acknowledgments}{...}
{title:Acknowledgments}{...}

{pstd}Dennis Kubitza and Michael Schöner provided excellent research assistance to develop the Stata package. {p_end}
