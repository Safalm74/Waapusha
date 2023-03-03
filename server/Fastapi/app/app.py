from fastapi import FastAPI, File, UploadFile
from io import BytesIO
from base64 import b64encode
from PIL import Image as im
import imagesegmentation as seg 
import return_soln as ret_soln
import classify_img 
import binary_classification
app=FastAPI()

@app.get('/',tags=['Root'])
async def root():
    return "Use Mobile app"

@app.post("/classify_image/")
async def classify_image(file: UploadFile = File(...)):
    img=im.open(BytesIO(file.file.read()))
    if binary_classification.binary_classification(img):
        segmented_img=seg.segment(img)
        #print(type(np(segmented_img)))
        classification_result= ret_soln.soln(classify_img.classify(segmented_img))
        buffer=BytesIO()
        segmented_img.save(buffer,format='jpeg')
        #segmented_img.show()
        buffer.seek(0)
        encoded_image = buffer.read()
        buffer.close()
        encoded_image = b64encode(encoded_image).decode()
        classification_result['segmented_image']=encoded_image
        classification_result['status']=True
        return classification_result
    else:
        classification_result=ret_soln.soln("Healthy")
        classification_result['segmented_image']=''
        classification_result['status']=False
        return classification_result