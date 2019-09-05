import pickle
import numpy as np
from sklearn.decomposition import PCA
from sklearn.svm import SVC
from sklearn import metrics
from tensorflow.python.platform import flags
import pickle
import data
import saab
import cv2

flags.DEFINE_string("output_path", None, "The output dir to save params")
flags.DEFINE_string("use_classes", "0-9", "Supported format: 0,1,5-9")
flags.DEFINE_string("kernel_sizes", "3,5", "Kernels size for each stage. Format: '3,3'")
flags.DEFINE_string("num_kernels", "5,15", "Num of kernels for each stage. Format: '4,10'")
flags.DEFINE_float("energy_percent", None, "Energy to be preserved in each stage")
flags.DEFINE_integer("use_num_images",3000, "Num of images used for training")
FLAGS = flags.FLAGS

train_images, train_labels, test_images, test_labels, class_list = data.import_data(FLAGS.use_classes)

fr=open('ffcnn_feature_1.pkl','rb')  
feature_1=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_2.pkl','rb')  
feature_2=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_3.pkl','rb')  
feature_3=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_4.pkl','rb')  
feature_4=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_5.pkl','rb')  
feature_5=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_6.pkl','rb')  
feature_6=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_7.pkl','rb')  
feature_7=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_8.pkl','rb')  
feature_8=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_9.pkl','rb')  
feature_9=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_10.pkl','rb')  
feature_10=pickle.load(fr)
fr.close()

feature = np.hstack([feature_1, feature_2,feature_3,feature_4,feature_5,feature_6,feature_7,feature_8,feature_9,feature_10])

pca = PCA(n_components = 60, svd_solver='full')
pca.fit(feature)

feature_transformed = pca.transform(feature)

clf = SVC(kernel='linear')
clf.fit(feature_transformed,train_labels[0:3000])

pred_train = clf.predict(feature_transformed)
train_acc = metrics.accuracy_score(train_labels[0:3000],pred_train)

fr=open('ffcnn_feature_test1.pkl','rb')  
feature_1=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test2.pkl','rb')  
feature_2=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test3.pkl','rb')  
feature_3=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test4.pkl','rb')  
feature_4=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test5.pkl','rb')  
feature_5=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test6.pkl','rb')  
feature_6=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test7.pkl','rb')  
feature_7=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test8.pkl','rb')  
feature_8=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test9.pkl','rb')  
feature_9=pickle.load(fr)
fr.close()

fr=open('ffcnn_feature_test10.pkl','rb')  
feature_10=pickle.load(fr)
fr.close()

feature = np.hstack([feature_1, feature_2,feature_3,feature_4,feature_5,feature_6,feature_7,feature_8,feature_9,feature_10])

pca = PCA(n_components = 60, svd_solver='full')
pca.fit(feature)

feature_transformed = pca.transform(feature)

clf = SVC(kernel='linear')
clf.fit(feature_transformed,test_labels[0:3000])

pred_test = clf.predict(feature_transformed)
test_acc = metrics.accuracy_score(test_labels[0:3000],pred_test)
