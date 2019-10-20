% 317 things
% Kai Brooks
% github.com/kaibrooks
% 2019
%
% Do a thing 

% Init
clc
close all
clear all
format
rng('shuffle')

L = 560e-6;
C = 100e-6;
R = 25;

% tf parameters k, a1, a2, as functions of L,C,R
K = 1;      % tf dc gain 
a1 = 1;     % coeffecient of s^1 in denominator polynomial 
a2 = 1;     % coeffecient of s^2 in denominator polynomial 

tf_LCR = tf(K, [a2, a1, 1]); % tf of rlc network

% t is a vector of 100 time values linearly spaces between 0 and 0.2
t = linspace(0, 0.2, 1000);
u = 5*ones(length(t), 1);
step_time = 0.11; % step the input at step_time
n = find(t >= step_time);
u(n) = u(n) + 0.5; % input containing 10% step at step_time

y = lsim(tf_LCR,u,t); % simulate the lcr network with the desired input

figure(1)
plot(t,y)
title('output response including the large-signal startup transient')

% isolate smal-signal step response
c_prime_0 = y(n(1)-1); % inital output before the step
ys = y(n) - c_prime_0; % small signal output response
ts = t(n) - step_time; % small signal response times

figure(2)
plot(ts, ys)
title('step response')

stepinfo(ys, ts) % obtain step response metrics
