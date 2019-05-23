#include <cstdio>
#include <stdio.h>

int main(void)
{
	int a[100000];
	int b[100000];
	int *ary1;
	for(int i=0;i<100000;i++)
	{
		a[i] = i;
	}
	cudaMalloc((void**)&ary1 , 100000*sizeof(int));
	cudaMemcpy(ary1, a, 100000*sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(b, ary1 ,100000*sizeof(int),cudaMemcpyDeviceToHost);
	for(int i =0; i < 100000; i++)
	{
		if(i/500 ==0)
		{
			printf("%d ",i);
		}
	}
	cudaFree(ary1);
	return 0;


}
