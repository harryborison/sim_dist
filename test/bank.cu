#include <stdio.h>
#include <stdlib.h>
#include <cstdio>



__global__ void input(  int *output)
{
	__shared__ int s_data[1024];
	for(int i= 0 ; i < 1024 ; i++)
	{
		s_data[i] = 2;
	}

	__syncthreads();
	/*
	for(int i=0 ; i < 32; i++)
	{
	int t = threadIdx.x + i *32;
	output[t]=s_data[t]; 	

	}*/
	for(int i=0; i < 32 ; i++)
	{
	output[threadIdx.x*32+i] = s_data[threadIdx.x*32+i];

	}

}



int main(void)
{

	int *ary;
	cudaMalloc((void**)&ary, 1024*sizeof(int));
	input<<<1,32>>>(ary);
	int *ary2;
	ary2= (int *)malloc(sizeof(int)*1024);
	cudaMemcpy(ary2,ary,sizeof(int)*1024,cudaMemcpyDeviceToHost);

	printf("final result : %d %d %d",ary2[0],ary2[1],ary2[1023]);







	return 0;
}
