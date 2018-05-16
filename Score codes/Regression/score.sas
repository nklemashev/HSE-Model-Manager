*------------------------------------------------------------*;
* EM SCORE CODE;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Input Data Source;
* TYPE: SAMPLE;
* NODE: Ids;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Regression;
* TYPE: MODEL;
* NODE: Reg;
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_BAD $ 12;
label I_BAD = 'Into: BAD' ;
*** Target Values;
array REGDRF [2] $12 _temporary_ ('1' '0' );
label U_BAD = 'Unnormalized Into: BAD' ;
*** Unnormalized target values;
ARRAY REGDRU[2]  _TEMPORARY_ (1 0);
 
drop _DM_BAD;
_DM_BAD=0;
 
*** Check CLAGE for missing values ;
if missing( CLAGE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check CLNO for missing values ;
if missing( CLNO ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check DEBTINC for missing values ;
if missing( DEBTINC ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check DELINQ for missing values ;
if missing( DELINQ ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check DEROG for missing values ;
if missing( DEROG ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check LOAN for missing values ;
if missing( LOAN ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check MORTDUE for missing values ;
if missing( MORTDUE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check NINQ for missing values ;
if missing( NINQ ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check VALUE for missing values ;
if missing( VALUE ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check YOJ for missing values ;
if missing( YOJ ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for JOB ;
drop _1_0 _1_1 _1_2 _1_3 _1_4 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
_1_4 = 0;
if missing( JOB ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
   _1_4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   %DMNORMCP( JOB , _dm7 )
   _dm_find = 0; drop _dm_find;
   if _dm7 <= 'OTHER'  then do;
      if _dm7 <= 'OFFICE'  then do;
         if _dm7 = 'MGR'  then do;
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm7 = 'OFFICE'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm7 = 'OTHER'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm7 <= 'SALES'  then do;
         if _dm7 = 'PROFEXE'  then do;
            _1_3 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm7 = 'SALES'  then do;
               _1_4 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm7 = 'SELF'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _1_4 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      _1_4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** Generate dummy variables for REASON ;
drop _2_0 ;
if missing( REASON ) then do;
   _2_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   %DMNORMCP( REASON , _dm7 )
   if _dm7 = 'HOMEIMP'  then do;
      _2_0 = -1;
   end;
   else if _dm7 = 'DEBTCON'  then do;
      _2_0 = 1;
   end;
   else do;
      _2_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1462264151;
   _P1 = 0.8537735849;
   goto REGDR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: CLAGE ;
_TEMP = CLAGE ;
_LP0 = _LP0 + (   -0.00581111662036 * _TEMP);
 
***  Effect: CLNO ;
_TEMP = CLNO ;
_LP0 = _LP0 + (   -0.01276959737564 * _TEMP);
 
***  Effect: DEBTINC ;
_TEMP = DEBTINC ;
_LP0 = _LP0 + (    0.04253133548449 * _TEMP);
 
***  Effect: DELINQ ;
_TEMP = DELINQ ;
_LP0 = _LP0 + (     0.3790884607832 * _TEMP);
 
***  Effect: DEROG ;
_TEMP = DEROG ;
_LP0 = _LP0 + (    0.39931045531923 * _TEMP);
 
***  Effect: JOB ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.23230614232246) * _TEMP * _1_0;
_LP0 = _LP0 + (     -0.541674406513) * _TEMP * _1_1;
_LP0 = _LP0 + (   -0.24781202565303) * _TEMP * _1_2;
_LP0 = _LP0 + (   -0.35387155343305) * _TEMP * _1_3;
_LP0 = _LP0 + (    0.19171376785891) * _TEMP * _1_4;
 
***  Effect: LOAN ;
_TEMP = LOAN ;
_LP0 = _LP0 + (   -0.00006989151977 * _TEMP);
 
***  Effect: MORTDUE ;
_TEMP = MORTDUE ;
_LP0 = _LP0 + (   -0.00003289930302 * _TEMP);
 
***  Effect: NINQ ;
_TEMP = NINQ ;
_LP0 = _LP0 + (   -0.05973810207309 * _TEMP);
 
***  Effect: REASON ;
_TEMP = 1;
_LP0 = _LP0 + (    0.01364991114943) * _TEMP * _2_0;
 
***  Effect: VALUE ;
_TEMP = VALUE ;
_LP0 = _LP0 + (    0.00001679080175 * _TEMP);
 
***  Effect: YOJ ;
_TEMP = YOJ ;
_LP0 = _LP0 + (   -0.01905884117313 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_P0 = probnorm((    0.02385810503037) + _LP0);
_P1 = 1.0 - _P0;
 
REGDR1:
 
 
*** Posterior Probabilities and Predicted Level;
label P_BAD1 = 'Predicted: BAD=1' ;
label P_BAD0 = 'Predicted: BAD=0' ;
P_BAD1 = _P0;
_MAXP = _P0;
_IY = 1;
P_BAD0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_BAD = REGDRF[_IY];
U_BAD = REGDRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------*;
* TOOL: Score Node;
* TYPE: ASSESS;
* NODE: Score;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Score: Creating Fixed Names;
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
