% Demo for Structured Edge Detector (please see readme.txt first).

%% set opts for training (see edgesTrain.m)
opts=edgesTrain();                % default options (good settings)
opts.modelDir='models/';          % model will be in models/forest
opts.modelFnm='modelBsds';        % model name
opts.nPos=5e5; opts.nNeg=5e5;     % decrease to speedup training
opts.useParfor=0;                 % parallelize if sufficient memory

%% train edge detector (~20m/8Gb per tree, proportional to nPos/nNeg)
tic, model=edgesTrain(opts); toc; % will load model if already trained

%% set detection parameters (can set after training)
model.opts.multiscale=1;          % for top accuracy set multiscale=1
model.opts.sharpen=1;             % for top speed set sharpen=0
model.opts.nTreesEval=1;          % for top speed set nTreesEval=1
model.opts.nThreads=10;            % max number threads for evaluation
model.opts.nms=1;                 % set to true to enable nms

%% evaluate edge detector on BSDS500 (see edgesEval.m)
if(0), edgesEval( model, 'show',1, 'name','' ); end

%% detect edge and visualize results
I = imread('Tiger.jpg');
tic, E=edgesDetect(I,model); toc
figure(1); im(I); figure(2); im(1-E);
P=1-E;
% figure(3);Binary=P>0.95;im(Binary);title('Binary Edge map ( with p > 0.95 )for nms =0');
[thrs,cntR,sumR,cntP,sumP,V] = edgesEvalImg( E, 'Tiger');
R=cntR./sum(R);
P=cntP./sum(P);
p=mean(P);
r=mean(R);
F=(2*p*r)/(p+r);


