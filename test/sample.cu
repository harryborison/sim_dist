#include <cstdio>
#include <stdio.h>
#include <stdlib.h>
#define SIZE 1024*128*512



// int == 4byte
// 1GB 256  1kb
// 256 1024 1mb
// 256 1024 1024 1GB



__global__ void input(int *a, int *b)
{
	int i=blockIdx.x*blockDim.x*512 + threadIdx.x*512;
	int t=i+2048;
	for(;i<t;i++)
	{
	a[i]=b[i];
	}
}
int main(void)
{
	
	int *arr;
	int *arr2;
	int *carr=0;
	int *carr2=0;
	arr= (int *)malloc(sizeof(int)*SIZE);
	arr2= (int *)malloc(sizeof(int)*SIZE);
	for(int i=0; i<SIZE; i++)
	{
	arr[i] = i;

	}

	cudaMalloc((void**)&carr2,sizeof(int)*SIZE);
	cudaMalloc((void**)&carr,sizeof(int)*SIZE);
	cudaMemcpy(carr,arr,sizeof(int)*SIZE,cudaMemcpyHostToDevice);
	
	input<<<256,512>>>(carr2,carr);
	cudaMemcpy(arr2,carr2,sizeof(int)*SIZE,cudaMemcpyDeviceToHost);

	
	cudaFree(carr2);
	cudaFree(carr);
	free(arr2);
	free(arr);

	return 0;
}
