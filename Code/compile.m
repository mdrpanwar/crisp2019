% Compile crisp boundaries
%
% -------------------------------------------------------------------------
% Crisp Boundaries Toolbox
% Phillip Isola, 2014 [phillpi@mit.edu]
% Please email me if you find bugs, or have suggestions or questions
% -------------------------------------------------------------------------

function [] = compile()
    
    addpath(genpath(pwd));
    
    type = 'compile_test';
    
    test_im = uint8(255*ones(36,36,3));
    
    %%
    kde_error_string = sprintf(['Something went wrong with compilation of the kde toolbox.\n' ...
                           'Try editing ./Code/Toolboxes/@kde/mex/makemex_kde.m\n' ...
                           'See http://www.ics.uci.edu/~ihler/code/kde.html ' ...
                           'for more documentation on how to install this toolbox.\n']);
    
    ucm_error_string = sprintf(['Something went wrong with compilation of ucm.\n' ...
                           'Don''t worry, you can still do boundary detection ' ...
                           'without ucm segmentation.\nBut if you do want ucm ' ...
                           'segmentation, please see ./installation_issues.txt ' ...
                           'for help troubleshooting.\n']);
    
    evaluation_error_string = sprintf(['Precompiled binaries for evaluation do not ' ...
                                       'work on your system. If you wish to evaluate ' ...
                                       'performance using the Berkeley metrics, please '...
                                       'download and compile source from ' ...
                                       'http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/, ' ...
                                       'then place correspondPixels in the path']);
    
    %% install boundary detection
    try % check if pre-compiled binaries work
        findBoundaries(test_im,type);
    catch
        try % try compiling
            cd('toolboxes/@kde/mex/');
            makemex_kde;
            cd('../../..');
            try % check if compiled correctly
                findBoundaries(test_im,type);
            catch
                error(kde_error_string);
            end
        catch
            cd('../../..');
            error(kde_error_string);
        end
    end
    fprintf('Boundary detection successfully compiled!\n');
    
    %% install ucm segmentation
    if (ispc==0)
        fprintf('Skipping UCM segmentation (not supported on Windows)');
    else
        [~,E_oriented] = findBoundaries(test_im,type);
        try % check if pre-compiled binaries work
            contours2ucm_crisp_boundaries(E_oriented);
        catch
            try % try compiling
                makemex_ucm;
                try % check if compiled correctly
                    contours2ucm_crisp_boundaries(E_oriented);
                catch
                    error(ucm_error_string);
                end
            catch
                error(ucm_error_string);
            end
        end
        fprintf('UCM segmentation successfully compiled!\n');
    end
    
    %% install evalution
    try % check if pre-compiled binaries work
        correspondPixels;
    catch        
        error(evaluation_error_string);
    end
    fprintf('Evaluation code successfully compiled!\n');
    
end