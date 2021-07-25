%{
-----------------------------------------------------------
GENERAZIONE DI UN RUMORE BIANCO GAUSSIANO (~WN[0,lambda^2])
-----------------------------------------------------------
%}

%WGN: media nulla, varianza unitaria con 10000 campioni
media = 0; 
lambda = 1;
varianza = lambda^2;
N = 10000; 
WN = lambda * randn(1,N) + media; 

%verifico le proprietà del WGN
fprintf("\nLa media è: \n" + mean(WN) + "\n\n");
fprintf("La deviazione standard è: \n" + std(WN) + "\n\n");
fprintf("La varianza è: \n" + var(WN) + "\n\n");  

%plot andamento rumore bianco generato
figure('Name','Gaussian White Noise generation');
plot(WN,'LineWidth',1,'Color',[0.635, 0.078, 0.184]),
     title("White noise: media = 0, \lambda^2 = 1");
xlabel("Samples");
ylabel("Sample values");
grid on;

%plot istogramma e funzione di densità di probabilità (PDF)
n = 100; %numero di bin
f = figure('Name','Probability distribution of the gaussian white noise');
f.Position = [400 418 599 459];
[counts,x] = hist(WN,n); 
bar(x,counts/trapz(x,counts),'EdgeColor','k','LineWidth',1.35,'EdgeAlpha',0.95);      
hold on;
PDF_gauss = (1/(sqrt(2*pi)*lambda)) * exp(-((x-media).^2)/(2*lambda^2)); 
plot(x,PDF_gauss,'LineWidth',2.5,"Color",[0.635, 0.078, 0.184]);
pdf ='$$p_X(x)=\frac{1}{\lambda \sqrt{2\pi}}e^{-\frac{(x-\mu)^2}{2\lambda^2}} \searrow$$';
text(-3.7,0.3,pdf,'Interpreter','latex','FontSize',14); 
hold off;
grid on;
xlabel('Bins');
ylabel('Distribution (PDF) f_x(x)')
title("Probability distribution of the Gaussian White Noise (WN~[0,\lambda^2])");
legend('Histogram','PDF (Gaussian)', 'Location','best');

%funzione di autocorrelazione del rumore bianco
figure('Name','Auto-correlation function of the white noise')
[autocorr,lag] = xcorr(WN,'normalized'); 
p = plot(lag,autocorr);
p.Color = [.33 .49 .11];
title('Auto-correlation of white noise');
xlabel('Lag');
ylim([-0.05 1.05]);
ylabel('Correlation');
grid on;

