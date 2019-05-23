#include <cstdio>
#include <stdio.h>

int main(void)
{
	int a[100000];
	int b[100000];
	int *ary1;
	int *ary2;
	int *ary3;
	for(int i=0;i<100000;i++)
	{
		a[i] = i;
	}
	cudaMalloc((void**)&ary1 , 100000*sizeof(int));
	cudaMalloc((void**)&ary2 , 100000*sizeof(int));
	cudaMalloc((void**)&ary3 , 100000*sizeof(int));
	
	cudaMemcpy(ary2, a, 100000*sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(ary1, a, 100000*sizeof(int),cudaMemcpyHostToDevice);
	

	for(int i=0;i<100000;i++)
	{
		ary3[i] = ary1[i] + ary2[i];
	}
	cudaMemcpy(b, ary3 ,100000*sizeof(int),cudaMemcpyDeviceToHost);
	for(int i =0; i < 100000; i++)
	{
		if(i/500 ==0)
		{
			printf("%d ",i);
		}
	}
	cudaFree(ary1);
	cudaFree(ary2);
	cudaFree(ary3);
	return 0;


}
