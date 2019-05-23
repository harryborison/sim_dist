#include <cstdio>
#include <stdio.h>
#define BUF_SIZ 1000000
__global__ void addKernel(int *c , const int *a, const int *b){
	int i = threadIdx.x;
	c[i] = a[i]+ b[i];
}
__global__ void GetKernel(int *b)
{
	int i = threadIdx.x;
	b[i] = b[i] * 10;


}
int main(void)
{
	int a[BUF_SIZ];
	int b[BUF_SIZ];
	int *ary1=0;
//	int *ary2=0;
//	int *ary3=0;
	for(int i=0;i<BUF_SIZ;i++)
	{
		a[i] = i;
	}
	cudaMalloc((void**)&ary1 , BUF_SIZ*sizeof(int));
//	cudaMalloc((void**)&ary2 , BUF_SIZ*sizeof(int));
//	cudaMalloc((void**)&ary3 , BUF_SIZ*sizeof(int));
	
//	cudaMemcpy(ary2, a, BUF_SIZ*sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(ary1, a, BUF_SIZ*sizeof(int),cudaMemcpyHostToDevice);
	/*

	for(int i=0;i<100000;i++)
	{
		ary3[i] = ary1[i] + ary2[i];
	}
	*/
	printf("addkernel start\n");
//	addKernel<<<1,3>>>(ary3,ary1,ary2);
	GetKernel<<<1,3>>>(ary1);	
	printf("addkernel end\n");
//	cudaMemcpy(b, ary3 ,BUF_SIZ*sizeof(int),cudaMemcpyDeviceToHost);
	cudaMemcpy(b, ary1 ,BUF_SIZ*sizeof(int),cudaMemcpyDeviceToHost);

	for(int i =0; i < BUF_SIZ; i++)
	{
		if(i/500 ==0)
		{
			printf("%d ",b[i]);
		}
	}
	cudaFree(ary1);
//	cudaFree(ary2);
//      cudaFree(ary3);
	return 0;


}
