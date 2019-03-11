function [pdf_array,M,V] = General_EM(IN_Image,Mu,x_image,No_iteration,Number_Gaussian)

variance = 20.*ones(Number_Gaussian,1);
Prob = (1./(Number_Gaussian+eps)).*ones(Number_Gaussian,1);
P = zeros(Number_Gaussian,1); 
for k = 1:No_iteration
    for i=1:length(IN_Image)
        gray = x_image(i);
                    for k2 = 1:Number_Gaussian
                        P(k2) = Gauss_aym(gray,Mu(k2),variance(k2));
                    end
                 
                    if (sum(sum(P.*Prob)) == 0);
                        for k2 = 1:Number_Gaussian
                            density_class(k2,i) = 0;
                        end
                    else
                        for k2 = 1:Number_Gaussian
                         a = (Prob(k2).*P(k2))./(sum(sum(P.*Prob))+eps);
                         density_class(k2,i) = a.*(IN_Image(i));
                        end
                    end
    end
          
         
        % To compute the proportion
        for k2 = 1:Number_Gaussian
            A(k2) = (sum(density_class(k2,:)))./(length(IN_Image));
            Mu(k2) = (sum(density_class(k2,:).*x_image))./(sum(sum(density_class(k2,:)))+eps);
            variance(k2) = sum(sum(density_class(k2,:).*(x_image - Mu(k2)).^2))./(eps+sum(sum(density_class(k2,:))));
        end
        
        
        for k2 = 1:Number_Gaussian
            Prob(k2) = A(k2)./sum(sum(A));
        end
end

for k2 = 1:Number_Gaussian
    for k=1:length(x_image);
      A_const = 1./((2.*pi.*variance(k2)).^0.5);
      B_const = (((k-1)- Mu(k2)).^2)./(2.*variance(k2));
      pdf_array(k2,k) = Prob(k2).*A_const.*exp(-B_const);
  end
end
  M = Mu;
  V = variance;
