def jpg_to_binary(file_path):
    with open(file_path, 'rb') as file:
        # Read the file content as binary
        data = file.read()
    print(len(data))
    binary_data = ''
    for byte in data:
        # Convert each byte to its binary representation
        binary_byte = format(byte, '08b')
        #binary_data += binary_byte + ",\n"
        fil.write(binary_byte+",\n")

    return binary_data

# Usage example
jpg_file_path = 'example.jpg'
fil = open('ex.txt', 'w')
binary_data = jpg_to_binary("image.jpg")
fil.close()
#print(binary_data)
a="fdv"
