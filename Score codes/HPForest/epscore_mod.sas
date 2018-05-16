data SASEP.OUT;
dcl package score sc();
dcl double "CLAGE" having label n'Age of oldest credit line in months';
dcl double "CLNO" having label n'Number of credit lines';
dcl double "DEBTINC" having label n'Debt-to-income ratio';
dcl double "DELINQ" having label n'Number of delinquent credit lines';
dcl double "DEROG" having label n'Number of major derogatory reports';
dcl double "LOAN" having label n'Requested loan amount';
dcl double "MORTDUE" having label n'Amount due on existing mortgage';
dcl double "NINQ" having label n'Number of recent credit inquiries';
dcl double "VALUE" having label n'Value of current property';
dcl double "YOJ" having label n'Years at present job';
dcl nchar(7) "JOB" having label n'Occupational category';
dcl nchar(7) "REASON" having label n'DebtCon = debt consolidation; HomeImp = home improvement';
dcl double "P_BAD1" having label n'Predicted: BAD=1';
dcl double "P_BAD0" having label n'Predicted: BAD=0';
dcl nchar(32) "I_BAD" having label n'Into: BAD';
dcl nchar(4) "_WARN_" having label n'Warnings';
dcl double U_BAD;
dcl double EM_EVENTPROBABILITY;
dcl double EM_PROBABILITY;
dcl nchar(32) EM_CLASSIFICATION;
dcl nchar(200) _FORMAT200;
dcl double _P_;
varlist allvars [_all_];
method init();
sc.setvars(allvars);
sc.setkey(n'6C8EBF375CEA31501758C5442522CB752DE742A6');
end;
 
method astoreScore();
 
sc.scoreRecord();
 
end;
 
method postCode();
 
  _FORMAT200 = ' ';
  _P_ = 0.0;
  if P_BAD1 - _P_ > 1E-8 then do ;
  _P_ = P_BAD1;
  _FORMAT200 = '1';
  end;
  if P_BAD0 - _P_ > 1E-8 then do ;
  _P_ = P_BAD0;
  _FORMAT200 = '0';
  end;
  I_BAD = DMNORM(_FORMAT200, 32.0);
  ;
  if I_BAD = '1' then U_BAD = 1.0;
  if I_BAD = '0' then U_BAD = 0.0;
  EM_EVENTPROBABILITY = P_BAD1;
  EM_PROBABILITY = MAX(P_BAD1, P_BAD0);
  EM_CLASSIFICATION = I_BAD;
  
  row_id = _n_;
 
end;
 
 
method run();
    set SASEP.IN;
    astoreScore();
    postCode();
end;
 
method term();
end;
enddata;
