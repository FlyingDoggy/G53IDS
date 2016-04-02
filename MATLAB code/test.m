pnames = {'kernel_function','method','showplot', 'polyorder','mlp_params',...
    'boxconstraint','rbf_sigma','autoscale', 'options',...
    'tolkkt','kktviolationlevel','kernelcachelimit'...
    'kfunargs', 'quadprog_opts','smo_opts'};
dflts =  { 'linear',         [],      false,      [],         [],   ....
    1,              [],         true ,        [] ,    ....
    [],      [],                 [],...
    {} ,          []  ,           []};
[kfun,optimMethod, plotflag, polyOrder, mlpParams, boxC,  rbf_sigma, ...
    autoScale, opts, tolkkt, kktvl,kerCL, kfunargs, qpOptsInput, ...
    smoOptsInput] = internal.stats.parseArgs(pnames, dflts, varargin{:});

usePoly = false;
useMLP = false;
useSigma = false;
%parse kernel functions
if ischar(kfun)
    okfuns = {'linear','quadratic', 'radial','rbf','polynomial','mlp'};
    [~,i] = internal.stats.getParamVal(kfun,okfuns,'kernel_function');
    switch i
        case 1
            kfun = @linear_kernel;
        case 2
            kfun = @quadratic_kernel;
        case {3,4}
            kfun = @rbf_kernel;
            useSigma = true;
        case 5
            kfun = @poly_kernel;
            usePoly = true;
        case 6
            kfun = @mlp_kernel;
            useMLP = true;
    end
elseif ~isa(kfun,  'function_handle')
    error(message('stats:svmtrain:BadKernelFunction'));
end

%parse optimization method
optimList ={'QP','SMO','LS'};
i = 2; % set to 'SMO'

if ~isempty(optimMethod)
    [~,i] = internal.stats.getParamVal(optimMethod,optimList,'Method');
    if i==1 &&  ( ~license('test', 'optimization_toolbox') ...
            || isempty(which('quadprog')))
        warning(message('stats:svmtrain:NoOptim'));
        i = 2;
    end
end

if i == 2 && ngroups==1
    error(message('stats:svmtrain:InvalidY'));
end
optimMethod = optimList{i};

% The large scale solver cannot handle this type of problem, so turn it off.
% qp_opts = optimset('LargeScale','Off','display','off');
% We can use the 'interior-point-convex' option 
qp_opts = optimset('Algorithm','interior-point-convex','display','off');
smo_opts = statset('Display','off','MaxIter',15000);
%parse opts. opts will override 'quadprog_opt' and 'smo_opt' argument
if ~isempty(opts)
    qp_opts = optimset(qp_opts,opts);
    smo_opts = statset(smo_opts,opts);
else
    % only consider undocumented 'quadprog_opts' arguments
    % when 'opts' is empty; Otherwise, ignore 'quadprog_opts'
    if ~isempty(qpOptsInput)
        if isstruct(qpOptsInput)
            qp_opts = optimset(qp_opts,qpOptsInput);
        elseif iscell(qpOptsInput)
            qp_opts = optimset(qp_opts,qpOptsInput{:});
        else
            error(message('stats:svmtrain:BadQuadprogOpts'));
        end
    end
end
 