function grafico_covarianza(segnale, rho, estremo,M)
%grafico della stima di covarianza ottenuta dal test di Anderson della 
%funzione 'Anderson'

figure('Name','Stima della covarianza campionaria normalizzata')
indice=0:M;
plot(indice,rho,'Color',[0.252 0.638 0.7],'LineWidth',1);
hold on;
sup = yline(estremo,'Color',[0.752 0.438 0.4],'LineWidth',1);
inf = yline(-estremo,'Color',[0.752 0.798 0.2],'LineWidth',1);
hold off;
title('Grafico di una stima di \rho(\tau)');
xlabel('Ritardo \tau');
ylabel('Stima di \rho(\tau)');
legend('Stima della covarianza campionaria $\hat\rho(\tau)$', ...
'Estremo superiore di $(-\frac{\beta}{\sqrt{\tau_{max}}},\frac{\beta}{\sqrt{\tau_{max}}})$', ...
'Estremo inferiore di $(-\frac{\beta}{\sqrt{\tau_{max}}},\frac{\beta}{\sqrt{\tau_{max}}})$', ...
'Interpreter','latex','FontSize',14);
grid on;
end