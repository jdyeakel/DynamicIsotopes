#include <iostream>
#include <cmath>
#include </home/uttam/Dropbox/c/randfunctions.h>
using namespace std;
double E(double a[], int i, size_t N);
double var(double a[], int i, size_t N);
double cov(double a[], int i, int j, size_t N);

main()
	{
	const int N=3;
	double EX[N]={15.L,15.L,15.L};
	double VX[N]={1.L,1.L,10.L};
	int a[N]={1, 1, 1};
	int a0=0; for(int i=0; i<N; i++) a0 += a[i];
	double p[N]={0.L};
	int n[N]={0};

	const double r=0.01L,dt=1.L;
	const int relaxtime=(int)(1.L/r);
	const int iterations=1000000;
	
	for(int a2=1; a2<100; a2++)
		{	
		a[2]=a2; a0=0; for(int i=0; i<N; i++) a0 += a[i];
		double X=0.L, Z=0.L;
		double sum=0.L, sum2=0.L, m=0.L;
		for(int iterate=0; iterate<iterations; iterate++)
			{
			dirichlet(a,p,N);
			
			Z=0.L;

			for(int i=0; i<N; i++) for(int j=0; j<n[i]; j++) Z += gaussrand(EX[i], sqrt(VX[i]));

			X += (-r*X + r*Z)*dt;


//			cout << (double)iterate*dt << '\t' << X << endl;
			if(iterate>10*relaxtime){ sum += X; sum2 += X*X; m += 1.L; }
			}
		double variance=0.L;
		for(int i=0; i<n
		cout << (double)a[2]/(double)a0 << '\t' << sum2/m - (sum/m)*(sum/m) << '\t' <<  endl;
		}
	
	
	}
double E(double a[], int i, size_t N)
	{
	double a0=0.L; for(int k=0; k<N; k++) a0+=a[k];
	return a[i]/a0;
	}
	

double var(double a[], int i, size_t N)
	{
	double a0=0.L; for(int k=0; k<N; k++) a0+=a[k];
	return a[i]*(a0-a[i])/(a0*a0*(a0+1.L));
	}

double cov(double a[], int i, int j, size_t N)
	{
	double a0=0.L; for(int k=0; k<N; k++) a0+=a[k];
	return -a[i]*a[j]/(a0*a0*(a0+1.L));
	}
