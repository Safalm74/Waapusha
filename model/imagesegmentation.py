import cv2
from PIL import Image as im
from numpy import array
from rembg import remove
def segment(original_image):
    original_image=array(original_image)
    # Resize the image
    # Resize the image
    original_image = cv2.resize(original_image, (256, 256), interpolation = cv2.INTER_NEAREST)
    #cv2_imshow(original_image)
    #removing background
    bgremoved_image = remove(original_image)
    #cv2.imshow(bgremoved_image) 
     #this block of code is to convert background to black
    # Convert to hsv and splitting channels
    hsv_image = cv2.cvtColor(bgremoved_image, cv2.COLOR_BGR2HSV)
    channel_h, channel_s, channel_v = cv2.split(hsv_image)

    # Performing threshold operation on saturation channel to generate mask
    # Color saturation is the purity and intensity of a color as displayed in an image
    _, thresh1 = cv2.threshold(channel_s, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

    # Applying erode to remove small spots
    # Using ellipitical kernel for better corner detection
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3,3))
    mask1 = cv2.erode(thresh1, kernel, iterations = 1)
    #cv2_imshow(mask)

    # Invert the shadow mask to create a mask of the non-shadow pixels
    mask1 = cv2.bitwise_not(mask1)
    #cv2_imshow(mask1)

    # Write black to input image where mask is not black
    img_result = original_image.copy()
    img_result[mask1 != 0] = 0
    #cv2_imshow(img_result)



    # Applying gaussian blur just to reduce noise detected
    # GaussianBlur using predefined (3,3)kernel 
    blur_image = cv2.GaussianBlur(img_result, (3,3), 0)
    #cv2_imshow(blur_image)

    # Apply Canny
    edges = cv2.Canny(blur_image, 100, 200, 3, L2gradient=True)

    # performing morph open to fill the small areas
    kernel1 = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5,5))
    edges = cv2.morphologyEx(edges, cv2.MORPH_CLOSE, kernel1)

    #performing erode(for not file so work as dilate) to thicken the area
    kernel2 =  cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3,3))
    segment = cv2.erode(edges, kernel2, iterations = 1)
    #cv2_imshow(segment)
    segment = cv2.dilate(segment, kernel2, iterations = 2)
    segment = cv2.bitwise_not(segment)

    img = img_result.copy()
    img[segment != 0] = 0
    #cv2_imshow(img)
    # # Converting image space to lab color space and splitting channels
    lab_image = cv2.cvtColor(img_result, cv2.COLOR_RGB2LAB)
    channel_l, channel_a, channel_b = cv2.split(lab_image)
    #cv2_imshow(channel_a)

    # Performing threshold operation on channel a to generate mask
    # The a channel is relative to the green–red opponent colors, with negative values toward green and positive values toward red
    _, thresh2 = cv2.threshold(channel_a, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    #cv2_imshow(thresh5)

    # Applying erode operation in threshold mask(thresh2) to remove small spots
    # Applying dilate operation in mask2 to increase mask size
    # Using ellipitical kernel for better corner detection
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3,3))
    mask2 = cv2.erode(thresh2, kernel, iterations = 1)
    mask2 = cv2.dilate(mask2, kernel, iterations = 1)
    #cv2_imshow(mask2)

    # Invert the shadow mask to create a mask of the non-shadow pixels
    mask = cv2.bitwise_not(mask2)
    #cv2_imshow(mask2)

    # Preforming bitwise anding operation for segmentation
    segmented_image = cv2.bitwise_and(img_result, img_result, mask = mask2)
    segmented_image = cv2.bitwise_or(segmented_image, img)
    #cv2_imshow(segmented_image)
    #print(segmented_image.shape)
    data1=im.fromarray(segmented_image)
    #data1.show()
    #data2.show()
    return data1