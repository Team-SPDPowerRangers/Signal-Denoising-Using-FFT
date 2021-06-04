clear all;
close all;
clc;
dt = 0.001;
t = 0:dt:1;
fclean=sin(2*pi*50*t)+sin(2*pi*120*t);
f = fclean + 2.5*randn(size(t));

figure(1); 
subplot(3,1,1)
plot(t,f,'c','LineWidth',1.5)
hold on
plot(t,fclean,'k','LineWidth',2)
l=legend('Noisy','Clean');
set(gca,'FontSize',16)

%%% The FFT
n = length(t);
fhat=fft(f,n);
PSD = fhat.*conj(fhat)/n;
freq=1/(dt*n)*(0:n);
L=1:floor(n/2);

subplot(3,1,3);
set(gca,'FontSize',16)
plot(freq(L),PSD(L),'c','LineWidth',3)
hold on
set(gca,'FontSize',16)

% using PSD to filter out the noise
indices = PSD>100;
PSDclean = PSD.*indices;
fhat = indices.*fhat;
ffilt=ifft(fhat);

plot(freq(L),PSDclean(L),'-','Color',[.5 .1 0],'LineWidth',2.5)
l1=legend('Noisy','Filtered');
set(l1,'FontSize',16)

subplot(3,1,2);
set(gca,'FontSize',16)
plot(t,ffilt,'-','Color',[.5 .1 0],'LineWidth',2.5)
l1=legend('Filtered');
set(l1,'FontSize',16)
ylim([-10 10]);
set(gca,'FontSize',16)