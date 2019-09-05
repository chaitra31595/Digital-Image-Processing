import pickle
import numpy as np
import data
import saab
import keras
import sklearn

def main():
    # load data
    fr=open('pca_params_10.pkl','rb')  
    pca_params=pickle.load(fr)
    fr.close()

    # read data
    train_images, train_labels, test_images, test_labels, class_list = data.import_data("0-9")
    print('Training image size:', train_images.shape)
    print('Testing_image size:', test_images.shape)
    
    Edge_filter=np.array([-1,-2, 0 ,2, 1])
    Level_filter=np.array([1,4,6,4,1])
    
    Spot_filter=np.array([-1, 0, 2, 0, -1])
    Wave_filter=np.array([-1, 2, 0, -2, 1])
    Ripple_filter=np.array([1 ,-4, 6 ,-4, 1])

    Filter=Wave_filter.T*Ripple_filter
    #Filter2=Level_filter.T*Edge_filter
    #Filter1=Level_filter.T*Level_filter
    altered_train=train_images.copy()
    
    for i in range(train_images.shape[0]):
        altered_train[i,:,:,0] = cv2.filter2D(train_images[i,:,:,0],-1,Filter)
    train_images = altered_train.copy()   
    
    # Training
    print('--------Training--------')
    train_images = train_images[0:3000,:,:,:]  #Taking only 3000 samples
    train_labels = train_labels[0:3000]
    feature=saab.initialize(train_images, pca_params) 
    feature=feature.reshape(feature.shape[0],-1)
    print("S4 shape:", feature.shape)
    print('--------Finish Feature Extraction subnet--------')
    feat={}
    feat['feature']=feature
    
    # save data
    fw=open('feat_10.pkl','wb')    
    pickle.dump(feat, fw)    
    fw.close()

if __name__ == '__main__':
    main()
