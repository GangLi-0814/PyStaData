
* The Matrix
matrix A = (2,1\3,2\-2,2)

matrix list A

/*
A[3,2]
    c1  c2
r1   2   1
r2   3   2
r3  -2   2
*/

*Multiplication by a Scalar

mat B = 3*A
/*
mat lis B

B[3,2]
    c1  c2
r1   6   3
r2   9   6
r3  -6   6
*/

* Matrix Addition & Subtraction
mat B = (1,1\4,2\-2,1)

mat C = A + B

mat lis C
/*
C[3,2]
    c1  c2
r1   3   2
r2   7   4
r3  -4   3
 */
mat D = A - B

mat lis D
/*
D[3,2]
    c1  c2
r1   1   0
r2  -1   0
r3   0   1
*/
* Matrix Multiplication
mat D = (2,1,3\-2,2,1)

mat C = D*A

mat lis C
/*
C[2,2]
    c1  c2
r1   1  10
r2   0   4
*/
mat C = A*D

mat lis C
/*
C[3,3]
    c1  c2  c3
r1   2   4   7
r2   2   7  11
r3  -8   2  -4
*/
mat D = (2,1,3)

mat C = D*A

mat lis C
/*
C[1,2]
    c1  c2
r1   1  10
*/
mat C = A*D
/*
conformability error
r(503);
*/

* Transpose of a Matrix
mat AT = A'

mat lis AT
/*
AT[2,3]
    r1  r2  r3
c1   2   3  -2
c2   1   2   2
*/
mat ATT = AT'

mat lis ATT
/*
ATT[3,2]
    c1  c2
r1   2   1
r2   3   2
r3  -2   2
*/

*Common Vectors
* Unit Vector
mat U = J(3,1,1)

mat lis U
/*
U[3,1]
    c1
r1   1
r2   1
r3   1
*/

* Common Matrices
* Unit Matrix
mat U = J(3,2,1)

mat lis U
/*
U[3,2]
    c1  c2
r1   1   1
r2   1   1
r3   1   1
*/

* Diagonal Matrix
mat S = (2,1,4\3,2,2\-2,2,3)

mat lis S 
/*
S[3,3]
    c1  c2  c3
r1   2   1   4
r2   3   2   2
r3  -2   2   3
*/
mat D = diag(vecdiag(S))

mat lis D
/*
symmetric D[3,3]
    c1  c2  c3
c1   2
c2   0   2
c3   0   0   3
*/

mat V = (3,1,2)

mat D = diag(V)

mat lis D

symmetric D[3,3]
    c1  c2  c3
c1   3
c2   0   1
c3   0   0   2
Identity Matrix
mat I = I(3)

mat lis I

symmetric I[3,3]
    c1  c2  c3
r1   1
r2   0   1
r3   0   0   1
Symmetric Matrix
Using Stata
mat C = (2,1,5\1,3,4\5,4,-2)

mat lis C

symmetric C[3,3]
    c1  c2  c3
r1   2
r2   1   3
r3   5   4  -2

mat CT = C'

mat lis CT

symmetric CT[3,3]
    r1  r2  r3
c1   2
c2   1   3
c3   5   4  -2
Inverse of a Matrix
matrix A = (4,2,2 \ 4,6,8 \ -2,2,4)

matrix list A

A[3,3]
    c1  c2  c3
r1   4   2   2
r2   4   6   8
r3  -2   2   4

matrix A1 = inv(A)

matrix list A1

A1[3,3]
      r1    r2    r3
c1     1   -.5    .5
c2    -4   2.5    -3
c3   2.5  -1.5     2
Inverse & Determinant of a Matrix
mat C = (2,1,6\1,3,4\6,4,-2)

mat CI = syminv(C)

mat lis CI

symmetric CI[3,3]
     r1   r2   r3
c1   .6
c2  -.2   .4
c3    0    0    0

scalar d = det(C)

display d
-102
Number of Rows & Columns
mat X = (3,2\2,-2\4,6\3,1)

mat lis X

X[4,2]
    c1  c2
r1   3   2
r2   2  -2
r3   4   6
r4   3   1

scalar r = rowsof(X)

scalar c = colsof(X)

display r, "  ", c
4    2
Computing Column & Row Sums
mat A = (2,1\3,2\-2,2)

mat lis A

A[3,2]
    c1  c2
r1   2   1
r2   3   2
r3  -2   2

mat U = J(rowsof(A),1,1)

mat list U

U[3,1]
    c1
r1   1
r2   1
r3   1

mat c = U'*A

mat list c

    c1  c2
c1   3   5
Computing Column & Row Means
mat cm = c/rowsof(A)

mat lis cm

cm[1,2]
           c1         c2
r1          1  1.6666667
Horizontal Concatenation
mat A = (2,1\3,2\-2,2)

mat lis A

A[3,2]
    c1  c2
r1   2   1
r2   3   2
r3  -2   2

mat A = (2,1\3,2\-2,2)

mat lis B

B[3,2]
    c1  c2
r1   1   1
r2   3   4
r3   2   2

mat C = A,B

mat lis C

C[3,4]
    c1  c2  c1  c2
r1   2   1   1   1
r2   3   2   3   4
r3  -2   2   2   2
Vertical Concatenation (Appending)
mat C = A\B

mat lis C

C[6,2]
    c1  c2
r1   2   1
r2   3   2
r3  -2   2
r1   1   1
r2   3   4
r3   2   2
Matrix Subsetting
/* first create large matrix to be subset */

mat A = (2,1\3,2\-2,2)

mat B = (1,1\3,4\5,0)

mat C = A,B\B,A

mat list C

C[6,4]
    c1  c2  c1  c2
r1   2   1   1   1
r2   3   2   3   4
r3  -2   2   5   0
r1   1   1   2   1
r2   3   4   3   2
r3   5   0  -2   2

/*  create a matrix with 3 columns */

mat D = C[1...,1..3]

mat list D

D[6,3]
    c1  c2  c1
r1   2   1   1
r2   3   2   3
r3  -2   2   5
r1   1   1   2
r2   3   4   3
r3   5   0  -2

/* create a matrix with 2 rows */

mat D = C[1..2,1...]

mat list D

D[2,4]
    c1  c2  c1  c2
r1   2   1   1   1
r2   3   2   3   4
Multivariate Course Page

Phil Ender, 22nov05, 30jun98