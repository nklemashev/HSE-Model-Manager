data SASEP.OUT;
dcl package score sc();
dcl double "PC_1" having label n'Principal Component 1';
dcl double "PC_10" having label n'Principal Component 10';
dcl double "PC_11" having label n'Principal Component 11';
dcl double "PC_12" having label n'Principal Component 12';
dcl double "PC_2" having label n'Principal Component 2';
dcl double "PC_3" having label n'Principal Component 3';
dcl double "PC_4" having label n'Principal Component 4';
dcl double "PC_5" having label n'Principal Component 5';
dcl double "PC_6" having label n'Principal Component 6';
dcl double "PC_7" having label n'Principal Component 7';
dcl double "PC_8" having label n'Principal Component 8';
dcl double "PC_9" having label n'Principal Component 9';
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
sc.setkey(n'577F443C7E17091F0B07F881C3A7238381044D3D');
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
 
end;
 
 
method run();
    set SASEP.IN;
    astoreScore();
    postCode();
end;
 
method term();
end;
enddata;
