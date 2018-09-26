J=imread('1.png');

iter = 100; %max iteration number
lambda = 0.25; %stability parameter
kappa = 3; %fifusion cte
J = double(J); %converts the image to double type

[Mi,Ni] = size(J); %size of the pic MxN
E = [1, 1:Mi-1]; %right pixels index
W = [2:Mi, Mi]; %left pixels index
S = [1, 1:Ni-1]; %down pixels index
N = [2:Ni,Ni]; %upper pixels index

for t =1:iter
    [DN,DS,DE,DW] = grads(J,N,S,E,W); %border detection
    %difusion coeficients
    gN = 1./(1+((abs(DN)/kappa).^2)); %to the down part
    gS = 1./(1+((abs(DS)/kappa).^2)); %to the down part
    gE = 1./(1+((abs(DE)/kappa).^2)); %to the down part
    gW = 1./(1+((abs(DW)/kappa).^2)); %to the down part
    %updates the picture for the next iteration
    J= J + lambda*(gN.*DN + gS.*Ds + gE.*DE + gW.*DW);
end
J = uint8(J); %filtered image converted to 8bit

function [DN,DS,DE,DW] = grads(I,N,S,E,W)
    DN= I(:,N) -I; %difference for the upper part
    DS= I(:,S) -I; %fifference for down part
    DE= I(E,:) -I; %difference to the right
    DW= I(W,:) -I; %difference to the left
end