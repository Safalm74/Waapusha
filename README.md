# Waapusha
Waapusha(Paddy Seed) is a mobile application developed on Flutter to detect disease on the leaf through leaf image. To reduce the load of running the model on mobile, a server was used. The mobile application allows users to use the mobile camera or gallery to select a leaf image, crop the infected area, and send the image to the server via API. The application is capable of reading reports from the server and also provides symptoms, overviews, preventive measures, and solutions for the disease. 

The Server is built using the FastAPI web framework. The server takes an image from a mobile application via API. The server will segment image, check if the provided image is of rice leaf or not, classify the disease, and finally reply with the report.

Rice disease on leaf detection using CNN(VGG16 and VGG19) and LSTM.

#To use models (save the models inside model directory)
BinaryClassification:(classify rice or non-rice leaf)
https://drive.google.com/drive/folders/1Lj_YWkCaTZDgRdVn3lqmV3B55cIp0lnS?usp=sharing
DiseaseClassification:(clasify classes)
https://drive.google.com/drive/folders/1BnS5Tf4ObRlLUBzwhHJTjEZq_asw3km_?usp=sharing

#To use mobile application
https://drive.google.com/file/d/1IC1i_uhw2oLewfGcrZUcDnfQohxvJo7p/view?usp=share_link
