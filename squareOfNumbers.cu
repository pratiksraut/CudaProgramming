//============================================================================
// Name        : cudaProg.cpp
// Author      : Pratil
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <stdio.h>
using namespace std;

__global__ void squareFunc(unsigned int *d_in, unsigned int *d_out)
{
    int idx = threadIdx.x;
    unsigned int val = d_in[idx];
    d_out[idx] = val * val;
    //printf("%d square value %d \n  ", idx, d_out[idx]);  
}


int main()
{

    const unsigned int arr_len = 64;
    const unsigned int arr_size = 64 * sizeof(unsigned int);

    unsigned int arr_in[arr_len];
    unsigned int arr_out[arr_len];
    for (unsigned int i = 0; i < 64; i++)
    {
        arr_in[i] = i;
        cout << i << "   :    " << arr_in[i] << endl;
    }

    unsigned int *d_in;
    unsigned int *d_out;

    cudaMalloc((void**) &d_in, arr_size);
    cudaMalloc((void**) &d_out, arr_size);

    cudaMemcpy(d_in, arr_in, arr_size, cudaMemcpyHostToDevice);

    squareFunc<<<1,64>>>(d_in, d_out);

    cudaMemcpy(arr_out, d_out, arr_size, cudaMemcpyDeviceToHost);

    for (unsigned int i = 0; i < 64; i++)
    {
       cout << i <<"    :   " << arr_out[i] << endl;
    }
   cudaDeviceSynchronize();

    cudaFree(d_out);
    cudaFree(d_in);
return 0;
}
