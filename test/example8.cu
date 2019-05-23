#include <stdio.h>
#include <cstdio>
#include <stdlib.h>
#define WIDTH 10000 
typedef struct input{
	int x;
}input;
__global__ void inputkernel(input *c, const input *a)
{
	int i = threadIdx.x + blockIdx.x *100; 
	c[i].x = a[i].x+1;	
}


int main(void)
{

	input *inputt=0;
	input *minput=0;
	int *cary=0;
	int *cary2=0;
	int *ary;
	minput = (input *)malloc(sizeof(input)*WIDTH);

	cudaMalloc((void **)&inputt , WIDTH * sizeof(input));
			
	for(int i = 0 ; i < WIDTH ; i++)
	{
	minput[i].x=0;	


	}
	

	inputkernel<<<10,100>>>(inputt,minput);

	
	printf("kernel exit\n");
	cudaMemcpy(minput,inputt,sizeof(input)*WIDTH,cudaMemcpyDeviceToHost);

	printf("final result : %d %d %d", minput[0].x,minput[1].x ,minput[9999].x );
	cudaFree(inputt);
	return 0;


}

