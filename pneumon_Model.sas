PROC IMPORT OUT=pneumon
    DATAFILE= "/home/u63551057/BSTA662/pneumon.csv"
    DBMS=CSV
    REPLACE;
    DELIMITER=",";
    GETNAMES=YES;
RUN;

/* add nsibs_fct - nsibs converted into factors with 3 levels */
data pneumon;
	set pneumon;
	if nsibs = 0 then nsibs_fct = 0;
	if nsibs = 1 then nsibs_fct = 1;
	if nsibs = 2 then nsibs_fct = 2;
	if nsibs = 3 then nsibs_fct = 2;
	if nsibs = 4 then nsibs_fct = 2;
	if nsibs = 5 then nsibs_fct = 2;
	if nsibs = 6 then nsibs_fct = 2;
run;

/* test on the difference of race */
proc lifetest data=pneumon method=km plots=(survival(cl),ls,lls)
	graphics;
	time agepn*hospital(0);
	strata race; 
run;

/* test on the difference of nsibs_fct */
proc lifetest data=pneumon method=km plots=(survival(cl),ls,lls)
	graphics outsurv=a;
	time agepn*hospital(0);
	strata nsibs_fct; 
run;

/* Non-parametric test with chldage */
proc lifetest data=pneumon method=km plots=(survival(cl),ls,lls)
	graphics;
	time agepn*hospital(0);
	test chldage mthage nsibs_fct urban alcohol smoke poverty bweight
	education wmonth sfmonth;
run;

/* Non-parametric test without chldage */
proc lifetest data=pneumon method=km plots=(survival(cl),ls,lls)
	graphics;
	time agepn*hospital(0);
	test mthage nsibs_fct urban alcohol smoke poverty bweight
	education wmonth sfmonth;
run;


/* Graphical checking for the distribution of Y */
data a2;
set a;
s=survival;
logH=log(-log(s));
lnorm=probit(1-s);
logit=log((1-s)/s);
lagepn=log(agepn);
run;

proc print data=a2;
run;

proc gplot data=a2;
symbol1 i=join width=2 value=triangle c=steelblue;
symbol2 i=join width=2 value=circle c=red;
symbol3 i=join width=2 value=diamond c=green;
plot logit*lagepn=nsibs_fct logH*lagepn=nsibs_fct lnorm*lagepn=nsibs_fct; 
/*logit for log-logistic, logH for weibull and lnorm for log-normal distribution */
run;


/* graphical checking for proportional hazards property */
proc gplot data=a2;
title "graphical checking for proportional hazards property for Number of Siblings";
plot logH*agepn=nsibs_fct;
run;

/* in SAS studio */
proc sgplot data=a2;
title "graphical checking for proportional hazards property for Number of Siblings";
loess x=agepn y=logH/ group= nsibs_fct;
run;


/* Cox Regression Model */
proc phreg data=pneumon;
class region race;
   model agepn*hospital(0)= nsibs mthage urban alcohol smoke poverty bweight
	education region race wmonth sfmonth
	/ties=efron selection=backward;
run;


/* fitted final model */
proc phreg data=pneumon;
model agepn*hospital(0)= nsibs wmonth smoke
 /ties=exact;
 assess PH/resample;
run;

/* compare with full model */
proc phreg data=pneumon;
class region race;
   model agepn*hospital(0)= nsibs mthage urban alcohol smoke poverty bweight
	education nsibs_fct region race wmonth sfmonth
	/ties=exact;
run;

/* Baseline survival function */
data null;
	input wmonth nsibs smoke;
	cards;
0 0 0 
run;

proc phreg data=pneumon;
model agepn*hospital(0)= wmonth nsibs smoke
	/ties=exact;
   baseline out=bsln covariates=null survival=s lower=lcl upper=ucl
cumhaz=H lowercumhaz=lH uppercumhaz=uH;
run;

proc print data=bsln;
run;

/* Baseline survival & cumulative hazard functions */
proc gplot data=bsln;
	title "Baseline Survival Function";
	symbol1 value=dot i=join;
	plot s*agepn;
run;

proc sgplot data=bsln;
title "Baseline Survival Function";
loess x=agepn y=s; 
run;

proc gplot data=bsln; 
	title "Baseline Cumulative Hazard Function";
	plot H*agepn;
run;

proc sgplot data=bsln;
title "Baseline Cumulative Hazard Function";
loess x=agepn y=H;
run;


/* Predicted survival function for a particular subject */
/* For Child 1 with nsibs=0, wmonth=6, smoke=0 */
data covals;
	input wmonth nsibs smoke;
cards;
6 0 0
; 
run;

proc phreg data=pneumon;
   model agepn*hospital(0)= wmonth nsibs smoke /ties=exact;
	baseline out=pred covariates=covals survival=s lower=lcl upper=ucl cumhaz=H 
lowercumhaz=lH uppercumhaz=uH;
run;

proc print data=pred;
run;

proc gplot data=pred;
	title "Predicted curve for a child with nsibs=0, wmonth=12, smoke=0";
	symbol1 value=dot i=join;
	plot s*agepn H*agepn;
run;

/*For Child 2 with nsibs=2, wmonth=1, smoke=1*/
data covals1;
	input wmonth nsibs smoke;
cards;
1 2 1 
run;

proc phreg data=pneumon;
   model agepn*hospital(0)= wmonth nsibs smoke /ties=exact;
	baseline out=pred1 covariates=covals1 survival=s lower=lcl upper=ucl cumhaz=H 
lowercumhaz=lH uppercumhaz=uH;
run;

proc print data=pred1;
run;

proc gplot data=pred1;
	title "Predicted curve for a child with nsibs=2, wmonth=1, smoke=1";
	symbol1 value=dot i=join;
	plot s*agepn H*agepn;
run;



/* C-statistics and time-dependent ROC curve  */

ods graphics on;
proc phreg data=pneumon concordance plots=roc rocoptions(at=2 to 10 by 2);
model agepn*hospital(0)= nsibs smoke wmonth;
run;


