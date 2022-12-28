% Naive Bayes classifier

% Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

% Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

% Calculate for each image, colour and roundness
% For Apples
% 1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
% 2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
% 3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
% 4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
% 5th apple image(A5)
hsv_value_A5=spalva_color(A5); %color
metric_A5=apvalumas_roundness(A5); %roundness
% 6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
% 7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
% 8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
% 9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

%selecting features(color, roundness, 3 apples and 2 pears)
%A1,A2,A3,P1,P2
%building matrix 2x5
x1 = [hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8...
      hsv_value_A9 hsv_value_P3 hsv_value_P4];
x2 = [metric_A4 metric_A5 metric_A6 metric_A7 metric_A8 metric_A9...
      metric_P3 metric_P4];

%% Calculation of mean and standart deviation
%calculating mean(arithmetic average) of hsv value (apple)
A_hsv_mean = (x1(1) + x1(2) + x1(3) + x1(4) + x1(5) + x1(6))/6;
%calculating mean(arithmetic average) of hsv value (pear)
P_hsv_mean = (x1(7) + x1(8))/2;
%calculating mean(arithmetic average) of metric (apple)
A_metric_mean = (x2(1) + x2(2) + x2(3) + x2(4) + x2(5) + x2(6))/6;
%calculating mean(arithmetic average) of metric (pear)
P_metric_mean = (x2(7) + x2(8))/2;


%calculating standart deviation(sigma) of apple hsv value(apple)
tmp = ((x1(1) - A_hsv_mean)^2+(x1(2) - A_hsv_mean)^2+(x1(3) - A_hsv_mean)^2+...
        (x1(4) - A_hsv_mean)^2+(x1(5) - A_hsv_mean)^2+(x1(6) - A_hsv_mean)^2);
A_hsv_dev = sqrt(tmp/6);
%calculating standart deviation(sigma) of hsv value (pear)
tmp = ((x1(7) - A_hsv_mean)^2+(x1(8) - A_hsv_mean)^2);
P_hsv_dev = sqrt(tmp/2);
%calculating standart deviation(sigma) of metric (apple)
tmp = ((x2(1) - A_metric_mean)^2 + (x2(2) - A_metric_mean)^2 + (x2(3) - A_metric_mean)^2+...
     (x1(4) - A_metric_mean)^2 + (x1(5) - A_metric_mean)^2+(x1(6) - A_metric_mean)^2);
A_metric_dev = sqrt(tmp/6);
%calculating standart deviation(sigma) of metric (pear)
tmp = ((x2(7) - P_metric_mean)^2 + (x2(8) - P_metric_mean)^2);
P_metric_dev = sqrt(tmp/2);

%% Calculation of normal distribution and probability
for n = 1:8
%APPLES
    %number of apples is data set
    P_apple = 6/8;
%   Normal distribution (Gaussian) of hsv value
    A = 1/(A_hsv_dev*sqrt(2*pi));
    B = exp(-0.5*((x1(n)-A_hsv_mean)/A_hsv_dev)^2);
    px1 = A*B;
%   Normal distribution (Gaussian) of metric
    A = 1/(A_metric_dev*sqrt(2*pi));
    B = exp(-0.5*((x2(n)-A_metric_mean)/A_metric_dev)^2);
    px2 = A*B;
%   Probability that current sample is an apple
    APPLE_PROB = P_apple*px2*px1;

%PEARS
%   number of pears is data set
    P_pear = 2/8;
%   Normal distribution (Gaussian) of hsv value
    A = 1/(P_hsv_dev*sqrt(2*pi));
    B = exp(-0.5*((x1(n)- P_hsv_mean)/P_hsv_dev)^2);
    px1 = A*B;
%   Normal distribution (Gaussian) of metric
    A = 1/(P_metric_dev*sqrt(2*pi));
    B = exp(-0.5*((x2(n)- P_metric_mean)/P_metric_dev)^2);
    px2 = A*B;
%   Probability that current sample is a pear
    PEAR_PROB = P_pear*px2*px1;


fprintf("\nProbability that current sample %d is an apple: %s",n, APPLE_PROB);
fprintf("\nProbability that current sample %d is a pear: %s\n\n",n,PEAR_PROB);
end





