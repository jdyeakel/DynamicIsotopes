#include <iostream>
#include <cmath>
using namespace std;

main()
	{
	const double w=0.1;
	const double T=2.L*M_PI/w;
	const double lambda=0.1L;
	const double maxt=300.L, dt=0.0001L;
	double EZ1=1.L, EZ2=2.L, X0=1.L;
	double L1 = (1.L-exp(-lambda*T/2.L))*(EZ1+EZ2*exp(-lambda*T/2.L))/(1.L-exp(-lambda*T));
	double L2 = (1.L-exp(-lambda*T/2.L))*(EZ2+EZ1*exp(-lambda*T/2.L))/(1.L-exp(-lambda*T));
	double Lavg = (1.L-exp(-lambda*T/2.L))*(EZ1+EZ2)*(1.L+exp(-lambda*T/2.L))/(2.L*(1.L-exp(-lambda*T)));
	
	
	double X=X0, EZc=EZ1, integral=0.L;
	int count=0;
	for(double t=0.0L; t<maxt; t+=dt)
		{
		count++;
		if((int)(2.L*t/T)%2==0) EZc=EZ1; else EZc=EZ2;
		integral += exp(lambda*t)*EZc*dt;
		X += -(X0*lambda*exp(-lambda*t)-lambda*EZc + lambda*lambda*exp(-lambda*t)*integral)*dt;
		if(count%100==0) cout << t << '\t' << EZc << '\t' << lambda*X/4.L << endl;
		}
	}
	

