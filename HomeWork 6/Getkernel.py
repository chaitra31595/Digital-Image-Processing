from tensorflow.python.platform import flags
import pickle
import data
import saab
import cv2
import numpy as np

flags.DEFINE_string("output_path", None, "The output dir to save params")
flags.DEFINE_string("use_classes", "0-9", "Supported format: 0,1,5-9")
flags.DEFINE_string("kernel_sizes", "3,5", "Kernels size for each stage. Format: '3,3'")
flags.DEFINE_string("num_kernels", "5,15", "Num of kernels for each stage. Format: '4,10'")
flags.DEFINE_float("energy_percent", None, "Energy to be preserved in each stage")
flags.DEFINE_integer("use_num_images",3000, "Num of images used for training")
FLAGS = flags.FLAGS

def main():
	# read data
    train_images, train_labels, test_images, test_labels, class_list = data.import_data(FLAGS.use_classes)
    print('Training image size:', train_images.shape)
    print('Testing_image size:', test_images.shape)

    kernel_sizes=saab.parse_list_string(FLAGS.kernel_sizes)
    if FLAGS.num_kernels:
    	num_kernels=saab.parse_list_string(FLAGS.num_kernels)
    else:
    	num_kernels=None
    energy_percent=FLAGS.energy_percent
    use_num_images=FLAGS.use_num_images
    print('Parameters:')
    print('use_classes:', class_list)
    print('Kernel_sizes:', kernel_sizes)
    print('Number_kernels:', num_kernels)
    print('Energy_percent:', energy_percent)
    print('Number_use_images:', use_num_images)
    
    #Level_filter=np.array([1,4,6,4,1])
    #Edge_filter=np.array([-1,-2, 0 ,2, 1])
    #Spot_filter=np.array([-1, 0, 2, 0, -1])
    Wave_filter=np.array([-1, 2, 0, -2, 1])
    Ripple_filter=np.array([1 ,-4, 6 ,-4, 1])

    Filter=Wave_filter.T*Ripple_filter
    
    '''
    Filter1=Level_filter.T*Level_filter
    Filter3=Level_filter.T*Spot_filter
    Filter4=Level_filter.T*Wave_filter
    Filter5=Level_filter.T*Ripple_filter
    
    Filter6=Edge_filter.T*Level_filter
    Filter7=Edge_filter.T*Edge_filter
    Filter8=Edge_filter.T*Spot_filter
    Filter9=Edge_filter.T*Wave_filter
    Filter10=Edge_filter.T*Ripple_filter
    
    Filter11=Spot_filter.T*Level_filter
    Filter12=Spot_filter.T*Edge_filter
    Filter13=Spot_filter.T*Spot_filter
    Filter14=Spot_filter.T*Wave_filter
    Filter15=Spot_filter.T*Ripple_filter
    
    Filter16=Wave_filter.T*Level_filter
    Filter17=Wave_filter.T*Edge_filter
    Filter18=Wave_filter.T*Spot_filter
    Filter19=Wave_filter.T*Wave_filter
    Filter20=Wave_filter.T*Ripple_filter
    
    Filter21=Ripple_filter.T*Level_filter
    Filter22=Ripple_filter.T*Edge_filter
    Filter23=Ripple_filter.T*Spot_filter
    Filter24=Ripple_filter.T*Wave_filter
    Filter25=Ripple_filter.T*Ripple_filter
    '''
    
    altered_train = train_images.copy()
    for i in range(train_images.shape[0]):
        altered_train[i,:,:,0] = cv2.filter2D(train_images[i,:,:,0],-1,Filter)
    train_images = altered_train.copy()   
    
    pca_params=saab.multi_Saab_transform(train_images, train_labels,
    	                 kernel_sizes=kernel_sizes,
    	                 num_kernels=num_kernels,
    	                 energy_percent=energy_percent,
    	                 use_num_images=use_num_images,
    	                 use_classes=class_list)
    # save data
    fw=open('pca_params_10.pkl','wb')    
    pickle.dump(pca_params, fw)    
    fw.close()

    # load data
    fr=open('pca_params_10.pkl','rb')  
    data1=pickle.load(fr)
    print(data1)
    fr.close()

if __name__ == '__main__':
	main()

















