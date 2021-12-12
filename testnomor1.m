% RGB KE HSI

clear all;
close all;
clc;
warning off;

%% import citra
filename='teschannel.png';
img = imread(filename);
imshow (img);
title ('Gambar asli');
img=im2double(img);
R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);

%% konversi warna

%menghitung nilai Hue 
N=(R-G)+(R-B);
D=2*(sqrt((R-G).^2 + (R-B).*(G-B)));
delta=acos(N./(D+eps));
H=delta;
H(B>G)=2*pi-H(B>G);
H=H/(2*pi)

%menghitung nilai S
N=min(min(R,B),G);
D=(R+B+G);
D(D==0)=eps;
S=1-3.*N./D;
H(S==0)=0;

% menghitung nilai I yang menyatakan intensitas
I=(R+B+G)/3;
citra=cat(3,H,S,I);

figure, imshow(citra);
title ('citra dalam HSI');

figure, imshow(H);
title ('nilai komponen H');

figure, imshow(S);
title ('nilai komponen S');

figure, imshow(I);
title ('nilai komponen I'); 

%% smoothing dengan gaussian filtering pada channel saturasi

filter = fspecial ('gaussian', [125 125],1);

H= imfilter(H,filter);
S= imfilter(S,filter);
I= imfilter(I,filter);

cat(3, H,S,I);

figure, imshow (H);
title ('Hasil Gaussian Filter Channel H');

figure, imshow (S);
title ('Hasil Gaussian Filter Channel S');

figure, imshow (I);
title ('Hasil Gaussian Filter Channel I');


%% end