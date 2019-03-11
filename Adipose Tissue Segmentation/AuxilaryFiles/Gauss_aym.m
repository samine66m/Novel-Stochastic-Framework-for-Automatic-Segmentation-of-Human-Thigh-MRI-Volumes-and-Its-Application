function p= Gauss_aym(x, Miu, Sigma)
format long
A = (2.*pi).^0.5;
B = (Sigma).^0.5;
con = 1./((A.*B)+eps);
D = -(0.5.*(x-Miu).^2)./(Sigma+eps);
p = con.*exp(D) +eps;

