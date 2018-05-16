*------------------------------------------------------------*;
* EM SCORE CODE;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Input Data Source;
* TYPE: SAMPLE;
* NODE: Ids;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: MODEL;
* NODE: HPDMForest;
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
    score file="C:\Users\ruskni\Documents\Projects\71 BigData HSE\Model Manager\HSE_MM\Workspaces\EMWS1\HPDMForest\OUTMDLFILE.bin" out=&hpfst_score_output;
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
* NODE: Score2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Score2: Creating Fixed Names;
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
