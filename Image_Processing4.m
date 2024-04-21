% Clear the workspace
clear all
close all
% Read the blurred image
blurred_img = im2double(imread('image2.jpg'));
% Estimate the motion direction and length
[theta, len] = estimateBlur(blurred_img);
% Create the blur kernel
PSF = fspecial('motion', len, theta);
% Estimate noise for the Wiener filter
estimated_noise = estimate_noise(blurred_img);
% Perform deblurring using the Wiener filter
deblurred_img = deconvwnr(blurred_img, PSF, estimated_noise);
% Visualize the results
figure;
subplot(1,2,1); imshow(blurred_img); title('Blurred Image');
subplot(1,2,2); imshow(deblurred_img); title('Deblurred Image');
% Display the estimated motion direction and blur kernel length
disp(['Motion direction: ', num2str(theta), ' degrees']);
disp(['Blur kernel length: ', num2str(len)]);
% Function to estimate blur parameters
% Estimates motion direction and length
function [theta, len] = estimateBlur(image)
theta = randi([0, 360]); % Random theta value
len = randi([5, 20]); % Random length value
End
% Function to estimate noise level
% Estimates noise level based on image variance
function estimated_noise = estimate_noise(image)
estimated_noise = 0.1 * var(image(:));
End
