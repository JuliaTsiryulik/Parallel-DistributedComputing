%%cu

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

__global__ void raise_power(int two, int power, int *res)
{
  int i, idx = blockDim.x * blockIdx.x + threadIdx.x;
  int offset = blockDim.x * gridDim.x;
  for (i = idx; i < power; i += offset)
  {
	res[i] = pow(two, i);
  }
}

int main()
{
  int res;
  int i;
  int two;
  int power;

  if(cudaSetDevice(0)!= cudaSuccess)
  {
    cerr << "ERROR: CUDA validation failed.\n";
	return 0;
  }
  
  two = 2;
  power = 32;
 
  int* arr = (int*)malloc(sizeof(int) * power);
 
  int* dev_arr;

  cudaError err = cudaMalloc(&dev_arr, sizeof(int) * power);
 
  if (err != cudaSuccess) 
  {
	cerr << "ERROR: bad Malloc\n";
	return 0;
  }

  if (cudaMemcpy(dev_arr, arr, sizeof(int) * power, cudaMemcpyHostToDevice) != cudaSuccess) 
  {
	cerr << "ERROR: bad Memcpy\n";
	return 0;
  }
 
  raise_power <<<256, 256>>> (two, power, dev_arr);
 

  if (cudaGetLastError() != cudaSuccess) 
  {
	cerr << "ERROR: kernel error\n";
  }

  if (cudaMemcpy(arr, dev_arr, sizeof(int) * power, cudaMemcpyDeviceToHost) != cudaSuccess) 
  {
	cerr << "ERROR: bad Memcpy\n";
	return 0;
  }

  if (cudaFree(dev_arr) != cudaSuccess) 
  {
	cerr << "ERROR: bad Free\n";
	return 0;
  }
 
  for (i = 0; i < power; i++)
  {
	printf("%d\n", arr[i]);
  }
  free(arr);
  return 0;
}



