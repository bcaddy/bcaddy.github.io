---
title:      C++17 Structured Binding Tutorial                 # Title
author:     Robert Caddy               # Author Name
date:       2022-08-08 10:58:46 -0400  # Date
categories: [C++, Guide]     # Catagories, no more than 2
tags:       [C++17, Structured Binding, Guide]                     # Tags, any number
pin:        false                      # Should this post be pinned?
toc:        true                       # Table of Contents?
math:       false                      # Does this post contain math?
#image:      /assets/img/#            # Header image path
---

## Summary

Structured binding is a feature released in C++17 that easily allows a function
to return multiple values. This is a quick summary of the various ways to use
it, including in a device function. Note that in C++17 structured binding
returns cannot be `const`, this was added in C++17.

## Code

```cpp
// Demonstration of C++17 structured binding in host and device code. Compile with
// `nvcc -std=c++17 structured-binding.cu` on CUDA on
// 'hipcc -g -std=c++17 structured-binding.cu` on HIP

#include <iostream>
#include <tuple>
#include <vector>

#ifdef __HIP__
#include<hip/hip_runtime.h>
#endif //HIP

// =============================================================================
// The classic method of returning multiple values is to pass them to the
// function by reference and set them within the function. This can be slow and
// unclear. C++17 structured binding attempts to address this and gives you
// several options in implementation.
// More details on the reasons that structured binding is often faster can be
// found [here](https://www.nexthink.com/blog/c17-function/)
// =============================================================================

// =============================================================================
// Returning a std::pair is fast since it doesn't use the stack if the return
// is <= 128 bits. Requires C++17 and can't be overloaded.
// Functions that return std::pair or std::tuple can either be of type `auto` or
// have their type explicitely declared. Both are shown here
auto pairReturn()
{
    return std::make_pair(7,8);
}
// =============================================================================

// =============================================================================
// Uses stack. Slower than returning a local struct or a std::pair but easier to
// add values to
std::tuple<int, int, double> tupleReturn()
{
    return {3,4,17.4};
}
// =============================================================================

// =============================================================================
// Returning a local struct is fast since it doesn't use the stack if the return
// is <= 128 bits. Requires C++17 and can't be overloaded
auto __device__ __host__ localStructReturn()
{
    struct returnStruct
    {
        int ret1, ret2;
    };

    return returnStruct{5,6};
}
// =============================================================================

// =============================================================================
__global__ void printValues()
{
    if (threadIdx.x == 0)
    {
        auto [devA, devB] = localStructReturn();
        printf("devA = %i\ndevB = %i\n", devA, devB);
    }
}
// =============================================================================

int main()
{
    // Simple structured binding from array. Does not work for std::vector since
    // it's details are not known at compile time. It does work with std::array
    // though
    int a[2] = {1,2};
    auto [b,c] = a;

    std::cout << b << std::endl;
    std::cout << c << std::endl;

    auto [d,e,dbl] = tupleReturn();

    std::cout << d << std::endl;
    std::cout << e << std::endl;
    std::cout << dbl << std::endl;

    auto [f,g] = localStructReturn();

    std::cout << f << std::endl;
    std::cout << g << std::endl;

    auto [h,i] = pairReturn();

    std::cout << h << std::endl;
    std::cout << i << std::endl;

    #ifdef __HIP__
        hipLaunchKernelGGL(printValues, 1,1,0,0);
        auto ignore = hipDeviceSynchronize();
    #else // CUDA
        printValues<<<1,1>>>();
        cudaDeviceSynchronize();
    #endif //HIP


    return 0;
}
```