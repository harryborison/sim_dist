#include <cstdio>
#include <stdio.h>

#define SIZE 256*1024*64

__global__ void input(int *a, int *b)
{
	int i=blockIdx.x*blockDim.x + threadIdx.x;
	a[i]=b[i];
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
	arr[i] = 2;

	}
	printf("%d %d",arr[SIZE-1],arr[SIZE-100]);	

	cudaMalloc((void**)&carr2,sizeof(int)*SIZE);
	cudaMalloc((void**)&carr,sizeof(int)*SIZE);
	cudaMemcpy(carr,arr,sizeof(int)*SIZE,cudaMemcpyHostToDevice);
	
	input<<<9096,512>>>(carr2,carr);
	cudaMemcpy(arr2,carr2,sizeof(int)*SIZE,cudaMemcpyDeviceToHost);

	printf("output : %d %d %d",arr2[0],arr2[10000],arr2[1000]);
	
	cudaFree(carr2);
	cudaFree(carr);
	free(arr2);
	free(arr);

	return 0;
}
