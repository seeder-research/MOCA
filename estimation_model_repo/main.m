clear;
clc;
addpath('./init');
addpath('./evaln');
addpath('./explore');
addpath('./output');
%% Initialization

evaln = init_evaln();
dnn = init_dnn();
cim = init_cim();
%% Explore

% Available scripts for case study are hosted under ./explore repository
% -1- fexplore: Explore the design space with varying kernel size & crossbar size
% -2- frealnn: Evaluate with the real DNN workload (9 models are available)
% -3- froof_line: Explore the design space with varying bwmm & tytd with a toy model
% -4- froof_line_nn: Explore the design space with varying bwmm & tytd with real DNN workload
% -5- froof_line_nn_layer: Explore the design space with varying bwmm & tytd with layer-wise DNN workload

frealnn();

fprintf("Finished");
