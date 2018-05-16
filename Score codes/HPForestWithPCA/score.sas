*------------------------------------------------------------*;
* EM SCORE CODE;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Input Data Source;
* TYPE: SAMPLE;
* NODE: Ids;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: princompanalysis Class;
* TYPE: MODIFY;
* NODE: PRINCOMP;
*------------------------------------------------------------*;
**********************************************************;
**** Begin scoring code for principal components analysis;
**********************************************************;
LENGTH _FORMAT $200;
LENGTH _NORMFMT $%DMNORLEN;
;
/************************************************/
* Create dummy variables for JOB;
/************************************************/
;
length JOB_1_ 8;
_FORMAT =JOB;
%DMNORMCP(_FORMAT , _NORMFMT );
IF _NORMFMT ="" THEN JOB_1_=3.14001523120094;
ELSE JOB_1_=-0.31815132298511;
IF _NORMFMT ="MGR" THEN JOB_2_=2.73259980511513;
ELSE JOB_2_=-0.36558591497005;
IF _NORMFMT ="OFFICE" THEN JOB_3_=2.30733283470906;
ELSE JOB_3_=-0.43296744404279;
IF _NORMFMT ="OTHER" THEN JOB_4_=1.15076314415847;
ELSE JOB_4_=-0.86811956489147;
IF _NORMFMT ="PROFEXE" THEN JOB_5_=2.42706719569397;
ELSE JOB_5_=-0.41160788698903;
IF _NORMFMT ="SALES" THEN JOB_6_=5.0991175707175;
ELSE JOB_6_=-0.19591625141905;
IF _NORMFMT ="SELF" THEN JOB_7_=6.99649912456222;
ELSE JOB_7_=-0.14278569641963;
;
/************************************************/
* Create dummy variables for REASON;
/************************************************/
;
length REASON_1_ 8;
_FORMAT =REASON;
%DMNORMCP(_FORMAT , _NORMFMT );
IF _NORMFMT ="" THEN REASON_1_=4.71524741021453;
ELSE REASON_1_=-0.21186587109636;
IF _NORMFMT ="DEBTCON" THEN REASON_2_=1.19651867277805;
ELSE REASON_2_=-0.83492219781287;
IF _NORMFMT ="HOMEIMP" THEN REASON_3_=0.91141117486583;
ELSE REASON_3_=-1.09610242616023;
;
/************************************************/
* Impute missing values for interval variables;
/************************************************/
;
length _D1 8;
if CLAGE=. then _D1 = 0;
else _D1=(CLAGE-160.663353868122)/78.762910871724;
length _D2 8;
if CLNO=. then _D2 = 0;
else _D2=(CLNO-19.2598684210526)/9.47402598437236;
length _D3 8;
if DEBTINC=. then _D3 = 0;
else _D3=(DEBTINC-32.5271312269612)/6.3853056650028;
length _D4 8;
if DELINQ=. then _D4 = 0;
else _D4=(DELINQ-0.5607476635514)/1.16713466438973;
length _D5 8;
if DEROG=. then _D5 = 0;
else _D5=(DEROG-0.27515151515151)/0.78813816544336;
length _D6 8;
if LOAN=. then _D6 = 0;
else _D6=(LOAN-6778)/1840.60420075143;
length _D7 8;
if MORTDUE=. then _D7 = 0;
else _D7=(MORTDUE-59752.1208878506)/27306.5121605761;
length _D8 8;
if NINQ=. then _D8 = 0;
else _D8=(NINQ-1.11695906432748)/1.65379537207598;
length _D9 8;
if VALUE=. then _D9 = 0;
else _D9=(VALUE-74851.5924795918)/35966.3174486113;
length _D10 8;
if YOJ=. then _D10 = 0;
else _D10=(YOJ-8.1796600877193)/7.02039109207691;
/****************************************/
* Principal Component 1;
/****************************************/
;
length PC_1 8;
label PC_1 = "Principal Component 1";
PC_1 =
0.010056611*JOB_1_+
0.0607489451*JOB_2_+
-0.058682046*JOB_3_+
-0.266436644*JOB_4_+
0.2396456319*JOB_5_+
0.2505879581*JOB_6_+
-0.006253606*JOB_7_+
-0.024449796*REASON_1_+
0.3848788521*REASON_2_+
-0.37038369*REASON_3_+
0.0074165758*_D1+
0.2356435788*_D2+
0.0293782825*_D3+
-0.024634074*_D4+
-0.006740864*_D5+
0.1894704764*_D6+
0.4475248694*_D7+
-0.014728375*_D8+
0.4707029961*_D9+
-0.023350208*_D10;
/****************************************/
* Principal Component 2;
/****************************************/
;
length PC_2 8;
label PC_2 = "Principal Component 2";
PC_2 =
-0.265461595*JOB_1_+
-0.04978063*JOB_2_+
0.1673499796*JOB_3_+
-0.018564787*JOB_4_+
0.0672848951*JOB_5_+
0.0849917312*JOB_6_+
0.0085874657*JOB_7_+
-0.172806025*REASON_1_+
-0.401133676*REASON_2_+
0.466817392*REASON_3_+
0.2995557568*_D1+
0.2162112811*_D2+
0.1108737521*_D3+
-0.048301403*_D4+
-0.013332964*_D5+
-0.076570079*_D6+
0.2768568902*_D7+
-0.286296837*_D8+
0.2798345928*_D9+
0.2900299924*_D10;
/****************************************/
* Principal Component 3;
/****************************************/
;
length PC_3 8;
label PC_3 = "Principal Component 3";
PC_3 =
0.4718040343*JOB_1_+
0.0124090243*JOB_2_+
0.178367117*JOB_3_+
-0.388983198*JOB_4_+
0.026083361*JOB_5_+
-0.107389968*JOB_6_+
-0.0125812*JOB_7_+
0.4718326329*REASON_1_+
-0.134873888*REASON_2_+
-0.05895922*REASON_3_+
0.2145867236*_D1+
0.1238182594*_D2+
-0.395384288*_D3+
0.0102630909*_D4+
-0.128410348*_D5+
-0.051503042*_D6+
-0.057097445*_D7+
-0.193964025*_D8+
-0.038585968*_D9+
0.2411109322*_D10;
/****************************************/
* Principal Component 4;
/****************************************/
;
length PC_4 8;
label PC_4 = "Principal Component 4";
PC_4 =
-0.130070257*JOB_1_+
0.0150392146*JOB_2_+
-0.011555663*JOB_3_+
0.2759734612*JOB_4_+
-0.138219409*JOB_5_+
-0.227337237*JOB_6_+
-0.057794945*JOB_7_+
-0.086003284*REASON_1_+
0.2075370831*REASON_2_+
-0.170051251*REASON_3_+
0.4508198667*_D1+
0.4076551784*_D2+
-0.008685662*_D3+
0.1134071559*_D4+
-0.062284953*_D5+
0.4364514361*_D6+
-0.184825354*_D7+
0.1242697769*_D8+
-0.14732671*_D9+
0.324055877*_D10;
/****************************************/
* Principal Component 5;
/****************************************/
;
length PC_5 8;
label PC_5 = "Principal Component 5";
PC_5 =
-0.171694415*JOB_1_+
0.5581534074*JOB_2_+
-0.006563856*JOB_3_+
-0.324444933*JOB_4_+
0.1108585619*JOB_5_+
-0.140743668*JOB_6_+
0.1436562509*JOB_7_+
-0.07814096*REASON_1_+
0.0005719976*REASON_2_+
0.0312726598*REASON_3_+
-0.0326366*_D1+
0.0670824206*_D2+
0.0483227527*_D3+
0.5896231418*_D4+
0.29566363*_D5+
-0.16535369*_D6+
-0.096252336*_D7+
0.0727597042*_D8+
-0.048975507*_D9+
0.0811586061*_D10;
/****************************************/
* Principal Component 6;
/****************************************/
;
length PC_6 8;
label PC_6 = "Principal Component 6";
PC_6 =
0.2357998378*JOB_1_+
-0.001427914*JOB_2_+
-0.610868765*JOB_3_+
0.3234563165*JOB_4_+
-0.050839932*JOB_5_+
0.1138608874*JOB_6_+
-0.061499331*JOB_7_+
0.3444116987*REASON_1_+
-0.209190562*REASON_2_+
0.066398776*REASON_3_+
0.1318712279*_D1+
0.2475707111*_D2+
0.0528815681*_D3+
0.1425870698*_D4+
0.296689957*_D5+
-0.163996421*_D6+
0.157431285*_D7+
0.1462589196*_D8+
0.1071428455*_D9+
-0.078148886*_D10;
/****************************************/
* Principal Component 7;
/****************************************/
;
length PC_7 8;
label PC_7 = "Principal Component 7";
PC_7 =
0.0708425926*JOB_1_+
0.4039142381*JOB_2_+
0.0830534235*JOB_3_+
-0.031934459*JOB_4_+
-0.690150139*JOB_5_+
0.3709941277*JOB_6_+
0.0550611806*JOB_7_+
0.1458089191*REASON_1_+
-0.006302123*REASON_2_+
-0.053180805*REASON_3_+
-0.017490245*_D1+
0.0168231865*_D2+
0.3292658735*_D3+
-0.059494934*_D4+
-0.144885902*_D5+
0.085825252*_D6+
-0.00424556*_D7+
-0.204419043*_D8+
-0.007050794*_D9+
-0.007470989*_D10;
/****************************************/
* Principal Component 8;
/****************************************/
;
length PC_8 8;
label PC_8 = "Principal Component 8";
PC_8 =
0.0479041762*JOB_1_+
-0.125332928*JOB_2_+
0.4569864099*JOB_3_+
-0.046641245*JOB_4_+
-0.213445936*JOB_5_+
0.1159007774*JOB_6_+
-0.45518574*JOB_7_+
0.0474678584*REASON_1_+
-0.038624595*REASON_2_+
0.0188292506*REASON_3_+
-0.091009895*_D1+
-0.003518062*_D2+
-0.033621633*_D3+
-0.014484618*_D4+
0.5649385358*_D5+
0.0686487592*_D6+
0.0803413815*_D7+
0.3782984783*_D8+
0.0617831227*_D9+
0.1175322149*_D10;
/****************************************/
* Principal Component 9;
/****************************************/
;
length PC_9 8;
label PC_9 = "Principal Component 9";
PC_9 =
0.0632163278*JOB_1_+
-0.410526947*JOB_2_+
0.1489498843*JOB_3_+
-0.036755495*JOB_4_+
-0.170005086*JOB_5_+
0.1326969173*JOB_6_+
0.8060544436*JOB_7_+
0.0060952515*REASON_1_+
0.035281561*REASON_2_+
-0.03734946*REASON_3_+
0.0390449935*_D1+
0.0461536524*_D2+
0.023013039*_D3+
0.0991432284*_D4+
0.2382933606*_D5+
-0.01457638*_D6+
-0.050711416*_D7+
0.1520043861*_D8+
0.0636244113*_D9+
0.0654866662*_D10;
/****************************************/
* Principal Component 10;
/****************************************/
;
length PC_10 8;
label PC_10 = "Principal Component 10";
PC_10 =
0.0834359246*JOB_1_+
0.2450664123*JOB_2_+
-0.061663524*JOB_3_+
-0.002067814*JOB_4_+
-0.018798577*JOB_5_+
-0.545304299*JOB_6_+
0.2135069225*JOB_7_+
0.1804938843*REASON_1_+
-0.16979894*REASON_2_+
0.0942581529*REASON_3_+
-0.178821538*_D1+
-0.237385761*_D2+
0.1794539742*_D3+
-0.272597577*_D4+
0.0423373641*_D5+
0.38702875*_D6+
0.2112980394*_D7+
0.2074618434*_D8+
0.2373004785*_D9+
0.1586181935*_D10;
/****************************************/
* Principal Component 11;
/****************************************/
;
length PC_11 8;
label PC_11 = "Principal Component 11";
PC_11 =
0.0238391771*JOB_1_+
-0.020615607*JOB_2_+
-0.055951283*JOB_3_+
-0.257652806*JOB_4_+
0.3401118582*JOB_5_+
0.1649272213*JOB_6_+
-0.022568692*JOB_7_+
0.1337911739*REASON_1_+
-0.007682401*REASON_2_+
-0.046920249*REASON_3_+
0.0668406803*_D1+
0.1244045647*_D2+
0.5963960435*_D3+
-0.339584325*_D4+
-0.017732935*_D5+
-0.166976336*_D6+
-0.258853476*_D7+
0.2476379191*_D8+
-0.219998024*_D9+
0.2647071712*_D10;
/****************************************/
* Principal Component 12;
/****************************************/
;
length PC_12 8;
label PC_12 = "Principal Component 12";
PC_12 =
-0.073700665*JOB_1_+
0.0542845526*JOB_2_+
0.1183618615*JOB_3_+
0.0383659973*JOB_4_+
-0.154003216*JOB_5_+
-0.033515824*JOB_6_+
0.0155316788*JOB_7_+
0.0079585349*REASON_1_+
-0.05589068*REASON_2_+
0.0519897307*REASON_3_+
-0.146511923*_D1+
0.2438013833*_D2+
-0.137376206*_D3+
0.0754389372*_D4+
-0.557436065*_D5+
-0.341083608*_D6+
0.1229876661*_D7+
0.6135073707*_D8+
0.1406781138*_D9+
0.0363269565*_D10;
;
DROP _FORMAT _NORMFMT
JOB_1_
JOB_2_
JOB_3_
JOB_4_
JOB_5_
JOB_6_
JOB_7_
REASON_1_
REASON_2_
REASON_3_
_D1
_D2
_D3
_D4
_D5
_D6
_D7
_D8
_D9
_D10
;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: MODEL;
* NODE: HPDMForest2;
*------------------------------------------------------------*;
%macro em_hpfst_score;
 
  %if %symexist(hpfst_score_input)=0 %then %let hpfst_score_input=&em_score_output;
  %if %symexist(hpfst_score_output)=0 %then %let hpfst_score_output=&em_score_output;
  %if %symexist(hpfst_id_vars)=0 %then %let hpfst_id_vars = _ALL_;
 
  %let hpvvn= %sysfunc(getoption(VALIDVARNAME));
  options validvarname=V7;
  proc hp4score data=&hpfst_score_input;
  id &hpfst_id_vars;
  %if %symexist(EM_USER_OUTMDLFILE)=0 %then %do;
    score file="C:\Users\ruskni\Documents\Projects\71 BigData HSE\Model Manager\HSE_MM\Workspaces\EMWS1\HPDMForest2\OUTMDLFILE.bin" out=&hpfst_score_output;
  %end;
  %else %do;
    score file="&EM_USER_OUTMDLFILE" out=&hpfst_score_output;
  %end;
    PERFORMANCE  DETAILS;
  run;
 
  options validvarname=&hpvvn;
 
  data &hpfst_score_output;
    set &hpfst_score_output;
%mend;
 
%em_hpfst_score;
*------------------------------------------------------------*;
*Computing Classification Vars: BAD;
*------------------------------------------------------------*;
length _format200 $200;
drop _format200;
_format200= ' ' ;
length _p_ 8;
_p_= 0 ;
drop _p_ ;
if P_BAD1 - _p_ > 1e-8 then do ;
   _p_= P_BAD1 ;
   _format200='1';
end;
if P_BAD0 - _p_ > 1e-8 then do ;
   _p_= P_BAD0 ;
   _format200='0';
end;
I_BAD=dmnorm(_format200,32); ;
length U_BAD 8;
label U_BAD = 'Unnormalized Into: BAD';
if I_BAD='1' then
U_BAD=1;
if I_BAD='0' then
U_BAD=0;
data &em_score_output;
set &em_score_output;
*------------------------------------------------------------*;
* TOOL: Score Node;
* TYPE: ASSESS;
* NODE: Score3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Score3: Creating Fixed Names;
*------------------------------------------------------------*;
LENGTH EM_EVENTPROBABILITY 8;
LABEL EM_EVENTPROBABILITY = 'Probability for level 1 of BAD';
EM_EVENTPROBABILITY = P_BAD1;
LENGTH EM_PROBABILITY 8;
LABEL EM_PROBABILITY = 'Probability of Classification';
EM_PROBABILITY =
max(
P_BAD1
,
P_BAD0
);
LENGTH EM_CLASSIFICATION $%dmnorlen;
LABEL EM_CLASSIFICATION = "Prediction for BAD";
EM_CLASSIFICATION = I_BAD;
