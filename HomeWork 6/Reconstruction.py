# -*- coding: utf-8 -*-
"""
Created on Sun Apr 28 17:25:30 2019

@author: lenovo
"""

import pickle
import numpy as np
import data
import saab
import keras
import sklearn
import cv2
import matplotlib.pyplot as plt
import math

def main():
	# load data
    fr=open('pca_params.pkl','rb')  
    pca_params=pickle.load(fr)
    fr.close()	
    
    image = cv2.imread(r'C:\Users\lenovo\Documents\4.png',0)
    h,w=img.shape
    img= image.reshape(1,h,w,1)
    print('--------Training--------')
    feature,pca_params=saab.initialize(img, pca_params)
    n,h,w,c=feature.shape
    feature=feature.reshape(feature.shape[0],-1)
    print("S4 shape:", feature.shape)
    print('--------Finish Feature Extraction subnet--------')
    feat={}
    feat['feature']=feature
	
    #print(feat)
    print(pca_params)
    print(pca_params['Layer_1/kernel'].shape)
	# save data
    num_channels=[8,16]
    
    #Reconstruction
    feature = feature.reshape(n,h,w,c)
    transformed=feature.reshape(h*w,-1)
    
    for i in range(1,-1,-1):
        feature_expectation=pca_params['Layer_%d/feature_expectation'%i]
        dc = pca_params['Layer_%d/dc'%i]
        kernels=pca_params['Layer_%d/kernel'%i]
        
        
        if i==1:
            bias=pca_params['Layer_%d/bias'%i]
            e=np.zeros((1, kernels.shape[0]))
            e[0,0]=1
            transformed+=e*bias
            sample_patches_centered_with_bias = np.matmul(transformed,np.linalg.pinv(np.transpose(kernels)))
            sample_patches_centered = sample_patches_centered_with_bias - np.sqrt(16*num_channels[0])*bias
        else:
            transformed=transformed.reshape(64,num_channels[0])
            sample_patches_centered = np.matmul(transformed,np.linalg.pinv(np.transpose(kernels)))
            
        sample_patches = sample_patches_centered + feature_expectation
        ac = int(np.sqrt(sample_patches.shape[0]))
        sample_patches = sample_patches.reshape(1,ac,ac,-1)
        h,w = ac,ac
        if i==1:
            sample_patches = sample_patches.reshape(1,2,2,1,1,4,4,num_channels[0])
            patches= sample_patches.transpose(0,1,3,5,2,4,6,7).reshape(1,8,8,num_channels[0])
            transformed = patches
        else:
            sample_patches = sample_patches.reshape(1,8,8,1,1,4,4,1)
            patches= sample_patches.transpose(0,1,3,5,2,4,6,7).reshape(1,32,32,1)
            transformed = patches
    
    transformed = transformed.reshape(32,32)
    plt.imshow(transformed,cmap='gray')
            
    PSNR=10*math.log10((255**2/(sum(sum((transformed-image[0,:,:,0])**2))/(32*32))))
    
    print(PSNR)
    fw=open('feat.pkl','wb')    
    pickle.dump(feat, fw)    
    fw.close()

if __name__ == '__main__':
	main()