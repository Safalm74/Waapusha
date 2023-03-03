from os import path
from numpy import zeros,array,expand_dims,reshape,float32
from tensorflow.keras.models import load_model
from cv2 import resize,INTER_NEAREST,cvtColor

model = load_model(path.abspath('../model/BinaryClassification/binaryModle2.h5'),compile=False)
model.compile()

def binary_classification(input_image):
    input_image=float32(input_image)
    #input_image = cvtColor(input_image, cv2.COLOR_BGR2RGB)
    input_image = resize(input_image, (256,256),interpolation = INTER_NEAREST)
    result=model.predict(expand_dims(input_image/255, 0))
    if result>0.5:
        return True
    else:
        return False