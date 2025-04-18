#!/usr/bin/python3

import pyrah

APPID = 1
denom = 65536

def input_data_and_mode():
    global choice
    global angle
    global ratio
    global exp_in
    global log_in
    global ratio1
    global ratio2

    print("Select the trigonometric function you want to calculate:")
    print("1. Sine (sin)")
    print("2. Sinh (sinh)")
    print("3. Tanh (tanh)")
    print("4. Arcsine (asin)")
    print("5. Exponential (exp)")
    print("6. Logarithmic (log)")
    print("7. Square root (sqrt)")
    print("8. Arctangent (atan)")
    print("9. Cosine (cos)")
    print("10. Cosh (cosh)")
    print("11. Arccosine (acos)")
    print("12. Exit")

    choice = int(input("Enter the number corresponding to the function (1-12): "))

    if choice == 12:
        print("Exiting.")
        exit()

    if choice == 1:
        angle = int(input("Enter the angle in degrees between [0, 360]: "))
        if 0 <= angle <= 360:
            sin_cos_input_convertor(angle, choice)
        else:
            print("Invalid input.")

    elif choice == 2:
        angle = float(input("Enter the angle in radians between [0, 3.142]: "))
        if 0 <= angle <= 3.142:
            input_convertor(angle, choice)
        else:
            print("Invalid input.")

    elif choice == 3:
        angle = float(input("Enter the angle in radians between [0, 1.13]: "))
        if 0 <= angle <= 1.13:
            input_convertor(angle, choice)
        else:
            print("Invalid input.")

    elif choice == 4:
        ratio = float(input("Enter the ratio between [0, 1]: "))
        if 0 <= ratio <= 1:
            input_convertor(ratio, choice)
        else:
            print("Invalid input.")

    elif choice == 5:
        exp_in = float(input("Enter the exponent in range [0, 10]: "))
        if 0 <= exp_in <= 10:
            input_convertor(exp_in, choice)
        else:
            print("Invalid input.")

    elif choice in [6, 7]:
        log_in = float(input("Enter the input in range [0, 30000]: "))
        if 0 <= log_in <= 30000:
            input_convertor(log_in, choice)
        else:
            print("Invalid input.")

    elif choice == 8:
        ratio1 = float(input("Enter the value of x between [0, 255]: "))
        ratio2 = float(input("Enter the value of y between [0, 255]: "))
        if 0 <= ratio1 <= 255 and 0 <= ratio2 <= 255:
            input_convertor_arctan(ratio1, ratio2, choice)
        else:
            print("Invalid input.")

    elif choice == 9:
        angle = int(input("Enter the angle in degrees between [0, 360]: "))
        if 0 <= angle <= 360:
            sin_cos_input_convertor(angle, choice)
        else:
            print("Invalid input.")

    elif choice == 10:
        angle = float(input("Enter the angle in radians between [0, 3.142]: "))
        if 0 <= angle <= 3.142:
            input_convertor(angle, choice)
        else:
            print("Invalid input.")

    elif choice == 11:
        ratio = float(input("Enter the ratio between [0, 1]: "))
        if 0 <= ratio <= 1:
            input_convertor(ratio, choice)
        else:
            print("Invalid input.")

def sin_cos_input_convertor(angle, choice):
    byte_array = angle.to_bytes(4, byteorder='big', signed=False)
    data_packeting(byte_array, choice)

def input_convertor(input_in, choice):
    ratio_in = input_in * denom
    int_input = int(round(ratio_in))
    byte_array = int_input.to_bytes(4, byteorder='big', signed=False)
    data_packeting(byte_array, choice)

def input_convertor_arctan(ratio1, ratio2, choice):
    ratio1_in = int(round(ratio1 * denom))
    ratio2_in = int(round(ratio2 * denom))

    byte_array1 = ratio1_in.to_bytes(4, byteorder='big', signed=False)
    byte_array2 = ratio2_in.to_bytes(4, byteorder='big', signed=False)

    data_packeting_arctan(byte_array1, byte_array2, choice)

def data_packeting(byte_array, choice):
    mode_byte = choice.to_bytes(2, byteorder='big', signed=False)
    data_in = mode_byte + byte_array
    transfer_data(data_in)

def data_packeting_arctan(byte_array1, byte_array2, choice):
    mode_byte = choice.to_bytes(2, byteorder='big', signed=False)
    data_in = mode_byte + byte_array1 + mode_byte + byte_array2
    transfer_data(data_in)

def transfer_data(data_in):
    pyrah.rah_write(APPID, data_in)

def receive_data():
    data = pyrah.rah_read(APPID, 6)
    data_hex = data.hex()
    data_transformer(data_hex)

def data_transformer(hex_data):
    global denom
    global choice
    global angle
    global ratio
    global exp_in
    global log_in
    global ratio1
    global ratio2

    hex_data = hex_data[4:]  # Remove mode bytes
    data = int(hex_data, 16)

    out_val = data / denom

    if choice == 1:
        print("The output of sin", angle, "is:", out_val)
    elif choice == 2:
        print("The output of sinh", angle, "is:", out_val)
    elif choice == 3:
        print("The output of tanh", angle, "is:", out_val)
    elif choice == 4:
        print("The output of asin", ratio, "is:", out_val)
    elif choice == 5:
        print("The output of exp", exp_in, "is:", data)
    elif choice == 6:
        print("The output of log", log_in, "is:", out_val)
    elif choice == 7:
        print("The output of sqrt", log_in, "is:", out_val)
    elif choice == 8:
        print("The output of arctan for x =", ratio1, "and y =", ratio2, "is:", out_val)
    elif choice == 9:
        print("The output of cos", angle, "is:", out_val)
    elif choice == 10:
        print("The output of cosh", angle, "is:", out_val)
    elif choice == 11:
        print("The output of acos", ratio, "is:", out_val)

def main():
    input_data_and_mode()
    receive_data()

if __name__ == "__main__":
    while(1):
        main()

