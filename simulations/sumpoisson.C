#include <iostream>
#include <cstdlib>
#include </home/uttam/Dropbox/c/randfunctions.h>
using namespace std;

main()
	{
	const int N = 100;
	const double dt=0.001L;
	const double T=100.L;
	int state[N]={0};
	
	for(double t=0.L; t<T; t+=dt)
		{
		for(int n=0; n<N; n++){ if(binrand(dt)) state[n] = 1-state[n];  }
		
		double average=0.L;
		for(int n=0; n<N; n++) average+=(double)state[n];
		cout << t << '\t' << average/(double)N << endl;
		}
	}
	
