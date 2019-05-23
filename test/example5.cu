//example5.cu

#include <cstdio>
#include <stdio.h>
__global__ void addKernel(int *c , const int *a, const int *b){
	int i = threadIdx.x;
	c[i] = a[i]+ b[i];
}
int main(void)
{
	int a[200000];
	int b[200000];
	int *ary1=0;
	int *ary2=0;
	int *ary3=0;
	for(int i=0;i<200000;i++)
	{
		a[i] = i;
	}
	cudaMalloc((void**)&ary1 , 200000*sizeof(int));
	cudaMalloc((void**)&ary2 , 200000*sizeof(int));
	cudaMalloc((void**)&ary3 , 200000*sizeof(int));
	
	cudaMemcpy(ary2, a, 200000*sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(ary1, a, 200000*sizeof(int),cudaMemcpyHostToDevice);
	/*

	for(int i=0;i<100000;i++)
	{
		ary3[i] = ary1[i] + ary2[i];
	}
	*/
	addKernel<<<1,3>>>(ary3,ary1,ary2);
	cudaMemcpy(b, ary3 ,200000*sizeof(int),cudaMemcpyDeviceToHost);
	for(int i =0; i < 200000; i++)
	{
		if(i/500 ==0)
		{
			printf("%d ",b[i]);
		}
	}
	cudaFree(ary1);
	cudaFree(ary2);
	cudaFree(ary3);
	return 0;


}
