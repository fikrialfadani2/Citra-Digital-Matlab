clc; clear; close all; warning off all;

%membaca citra rgb
A = imread('BautMur.jpg');
figure, imshow(A)

%mengkonversi citra rgb menjadi grayscale
B = rgb2gray(A);
figure, imshow(B)

%melakukan operasi thresholding
C = imbinarize(B);
figure, imshow(C)

%melakukan operasi komplemen
D = imcomplement(C);
figure, imshow(D)

%melakukan operasi morfologi
E = imfill(D, 'holes');
figure, imshow(E)

%melakukan pelabelan
[labeled, numObjects] = bwlabel(E);
figure, imshow(labeled,[])
labeledrgb = label2rgb(labeled);
figure, imshow(labeledrgb,[])

%melakukan ekstrak masing-masing objek
s = regionprops(labeled,'Area','Perimeter','BoundingBox');
luas = cat(1,s.Area);
keliling = cat(1,s.Perimeter);
bbox = cat(1,s.BoundingBox);
metric = 4*pi*luas./(keliling.^2);

%klasifikasi bentuk pada masing-masing objek
for k = numObjects
    if metric(k)>0.8
        A = insertObjectAnnotation(A,'rectangle',bbox(k,:),'Mur',...
            'LineWidth',3,'Color','y','FontSize',24);
    else
         A = insertObjectAnnotation(A,'rectangle',bbox(k,:),'Baut',...
            'LineWidth',3,'Color','r','FontSize',24);
    end
end

%menampilkan citra hasil klasifikasi
figure, imshow(A)