%%
% uses full bootstrap sample without replacement for each tree

function [rf] = fastRFreg_train(X,y,Ntrees)
    
    rf.Ntrees = Ntrees;
    
    for i=1:Ntrees
        t = fitrtree(X,y,'NumVariablesToSample',min(3,size(X,2)),...
                             'MinLeafSize',5,'Prune','off');
        rf.Trees{i} = t;
    end
end