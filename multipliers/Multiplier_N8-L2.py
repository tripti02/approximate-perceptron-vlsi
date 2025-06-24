from re import L
import numpy as np
import cv2
import matplotlib.pyplot as plt
import itertools
#from operator import*
import math

def decimal_to_bin_list(n, bits=8):
    return list(map(int, bin(n)[2:].zfill(bits)))

def bin_list_to_decimal(bin_list):
    return int(''.join(map(str, bin_list)), 2)


    
def Multiplier_12(A,B, debug=False):
    A_bin = decimal_to_bin_list(A)
    B_bin = decimal_to_bin_list(B)
    
    partial_products = []
    
    for i in range(7,3,-1):
        partial_product = [0]*(i+1-4) + [A_bin[i] & B_bin[j] for j in range(4,8)] + [0] * (7-i)
        partial_product = (partial_product + [0] * (8 - len(partial_product)))[:8]
        partial_products.append(partial_product)
        
      #  if debug:
       #     print(f"Partial product 1 row {i}: {''.join(map(str, partial_product))} ({bin_list_to_decimal(partial_product)})")
            
    result1 = [0] * 8

    for i in range(7,-1,-1):
        result1[i] = partial_products[0][i]
        for j in range(4):
            result1[i] |= partial_products[j][i]
        #if debug:
         #   print("result1:" , result1[i])
    
   
    return bin_list_to_decimal(result1)

def Multiplier_22(A,B, debug=False):
    A_bin = decimal_to_bin_list(A)
    B_bin = decimal_to_bin_list(B)
    
    partial_products = []
    
    for i in range(3,-1,-1):
        partial_product = [0]*(i+1) + [A_bin[i] & B_bin[j] for j in range(4,8)] + [0] * (3-i)
        partial_product = (partial_product + [0] * (8 - len(partial_product)))[:8]
        partial_products.append(partial_product)
        
       # if debug:
        #    print(f"Partial product 2 row {i}: {''.join(map(str, partial_product))} ({bin_list_to_decimal(partial_product)})")
            
    result2 = [0] * 8

    for i in range(7,2,-1):
        result2[i] = partial_products[0][i]
        for j in range(4):
            result2[i] |= partial_products[j][i]
        #if debug:
         #   print("result2:" , result2[i])
    
    result2[2] = partial_products[2][2] | partial_products[3][2] 
    result2[1] = partial_products[3][1] & ~partial_products[2][3]
    result2[0] = partial_products[3][1] & partial_products[2][3]
    #print("result2:" , result2[2])
    #print("result2:" , result2[1])
    #print("result2:" , result2[0])
    
   
    return bin_list_to_decimal(result2)

def Multiplier_32(A,B, debug=False):
    A_bin = decimal_to_bin_list(A)
    B_bin = decimal_to_bin_list(B)
    
    partial_products = []
    
    for i in range(7,3,-1):
        partial_product = [0]*(i+1-4) + [A_bin[i] & B_bin[j] for j in range(0,4)] + [0] * (7-i)
        partial_product = (partial_product + [0] * (8 - len(partial_product)))[:8]
        partial_products.append(partial_product)
        
       # if debug:
      #      print(f"Partial product 3 row {i}: {''.join(map(str, partial_product))} ({bin_list_to_decimal(partial_product)})")
            
    result3 = [0] * 8

    for i in range(7,2,-1):
        result3[i] = partial_products[0][i]
        for j in range(4):
            result3[i] |= partial_products[j][i]
        #if debug:
         #   print("result3:" , result3[i])
    
    result3[2] = partial_products[2][2] | partial_products[3][2] 
    result3[1] = partial_products[3][1] & ~partial_products[2][3]
    result3[0] = partial_products[3][1] & partial_products[2][3]
    #print("result3:" , result3[2])
    #print("result3:" , result3[1])
    #print("result3:" , result3[0])
    
   
    return bin_list_to_decimal(result3)

def Multiplier_42(A,B, debug=False):
    A_bin = decimal_to_bin_list(A)
    B_bin = decimal_to_bin_list(B)
    
    partial_products = []
    
    for i in range(3,-1,-1):
        partial_product = [0]*(i+1) + [A_bin[i] & B_bin[j] for j in range(0,4)] + [0] * (3-i)
        partial_product = (partial_product + [0] * (8 - len(partial_product)))[:8]
        partial_products.append(partial_product)
        
       # if debug:
        #    print(f"Partial product 4 row {i}: {''.join(map(str, partial_product))} ({bin_list_to_decimal(partial_product)})")
            
    result4 = [0] * 8
    carry=0

    for i in range(7,-1,-1):
        sum_ = carry
        result4[i] = sum_ % 2
        for j in range(4):
            sum_ += partial_products[j][i]
        carry = sum_//2
        result4[i] = sum_%2
        #if debug:
         #   print("result4:" , result4[i])
        
        
 
   
    return bin_list_to_decimal(result4)

def approximate_multiplyN2(A , B, debug=False):
    
    L = Multiplier_12(A,B)
    
    M = Multiplier_22(A,B)
    N = Multiplier_32(A,B)
    O = Multiplier_42(A,B)
    M1 = M << 4 
    N1 = N << 4
    O1 = O << 8
    L2 = [0]*16
    M2 = [0]*16
    N2 = [0]*16
    O2 = [0]*16
    L2 = list(map(int, bin(L)[2:].zfill(16)))
   
    #if debug:
     #   print("L2:", L2)
    M2 = list(map(int, bin(M1)[2:].zfill(16)))
    
    #if debug:
     #   print("M2:" , M2)
    N2 = list(map(int, bin(N1)[2:].zfill(16)))
    #if debug:
     #   print("N2:" , N2)
    O2 = list(map(int, bin(O1)[2:].zfill(16)))
    #if debug:
     #   print("O2:" , O2)
    result = [0]*16
    res1 = [0]*16
    res2 = [0]*16
    
    for i in range(15,8,-1):
        result[i] = L2[i] | M2[i] | N2[i] | O2[i]
        #if debug:
         #   print("result[i]:", result[i])
        
    carry=0
    carry1=0
    carry2=0
    for i in range(8, -1,-1):
       
        sum1 = carry
        sum1 += L2[i]+M2[i]
        res1[i] = sum1%2
        carry = sum1 // 2

        sum2 = carry1
        sum2 += N2[i]+O2[i]
        res2[i] = sum2%2
        carry1 = sum2 // 2

        sum = carry2
        sum += res1[i]+res2[i]
        result[i] = sum%2
        carry2 = sum // 2
        
        #if debug:
         #   print("result[i]:", result[i])
          
        
        
   
        
    return bin_list_to_decimal(result)
    
    #if debug:
    #   print("final result:" , result)
    
    


  

  


