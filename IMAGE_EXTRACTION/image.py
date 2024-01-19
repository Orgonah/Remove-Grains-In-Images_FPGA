from PIL import Image

# Read the binary file
with open('image.bin', 'rb') as file:
    pixel_data = file.read()

# Create a grayscale image from the pixel data
image = Image.frombytes('L', (224, 224), pixel_data)

# Save the image as JPEG
image.save('image.jpg')