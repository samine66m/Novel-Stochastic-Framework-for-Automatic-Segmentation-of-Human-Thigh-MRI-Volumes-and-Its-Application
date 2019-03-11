% recall

function y = Hausdorff(A, B)

% A: ground-truth; B:automatic segmentation

% A size

As = size(A);

A_ind =  find(A);

[Ax, Ay, Az] = ind2sub(As, A_ind);



% B size

Bs = size(B);

B_ind =  find(B);

[Bx, By, Bz] = ind2sub(Bs, B_ind);



% X: First point sets. 

% Y: Second point sets.

X = [Ax, Ay, Az];

Y = [Bx, By, Bz];

 

y = HausdorffDist(X, Y);