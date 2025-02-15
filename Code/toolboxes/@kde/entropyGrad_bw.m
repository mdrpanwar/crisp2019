%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% err = entropyGrad(npd,estType)
%   Compute gradient of an entropy estimate for the npde
%
%   entType is one of:
%       ISE     :  integrated squared error from uniform estimate
%       RS,LLN  :  law of large numbers resubstitution estimate
%       KL,dist :  nearest-neighbor distance based estimate
%
% see also: kde, miGrad, klGrad, adjustPoints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copyright (C) 2003 Alexander Ihler; distributable under GPL -- see README.txt

function err=entropyGrad_bw(npd1,npd2,entType)
  %if (nargin < 2), entType = 'ISE'; end;
  switch (upper(entType))
      %case 'ISE', err = entropyGradISE(npd);
      case {'RS','LLN'}, %[err1,err2]=llGrad(npd,1,1e-3,1e-2);
                         p_reg = kde(zeros(getDim(npd1),1),1000,[],'e');
                         npd1 = joinTrees(npd1,p_reg,0.99);
                         [err1,err2]=llGrad(npd1,npd2,1,1e-3,1e-2);
                         err1 = err1(:,1:end-1);
                         err = -(err1+err2); 
                         % err = entropyGradRS(npd);
      %case {'KL','DIST'}, err = entropyGradDist(npd);
  end;  

