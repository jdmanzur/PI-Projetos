function V=getVstar(siz,n,m)
N = siz;
x = 1:N; y = x;
% c=(1+siz)/2;%Center
% X=(X-c)/(c-1);
% Y=(Y-c)/(c-1);
[X,Y] = meshgrid(x,y);
R = sqrt((2.*X-N-1).^2+(2.*Y-N-1).^2)/N;
Theta = atan2((N-1-2.*Y+2),(2.*X-N+1-2));
Mask = R<=1;
V = Mask.*radialpoly(R,n,m).*exp(-1i*m*Theta);
end