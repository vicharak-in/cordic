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
    print("2. Cosine (cos)")
    print("3. Sinh (sec)")
    print("4. Cosh (csc)")
    print("5. Tanh (tanh)")
    print("6. Arcsine (asin)")
    print("7. Arccosine (acos)")
    print("8. Exponential (exp)")
    print("9. Logarithmic (log)")
    print("10. Square root (sqrt)")
    print("11. Arctangent (atan)")

    # Get user's choice
    choice = int(input("Enter the number corresponding to the function (1-11): "))

    # Ensure the user enters a valid choice
    if choice not in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]:
        print("Invalid choice. Please select a number between 1 and 11.")
    else:
        # Ask for the angle in degrees for choices 1 and 2
        if choice in [1, 2]:
            angle = int(input("Enter the angle in degrees between [0, 360]: "))

            if angle < 0 or angle > 360:
                print("Invalid input. Please select a number between 0 and 360.")
            else:
                sin_cos_input_convertor(angle,choice)
        # Ask for the angle in radians for choices 3 and 4
        elif choice in [3, 4]:
            angle = float(input("Enter the angle in radians between [-3.142, 3.142]: "))

            if angle < -3.142 or angle > 3.142:
                print("Invalid input. Please select a number between -3.142 and 3.142.")
            else:
               input_convertor(angle,choice)

        # Ask for the angle in radians for choice 5
        elif choice == 5:
            angle = float(input("Enter the angle in radians between [-1.13, 1.13]: "))

            if angle < -1.13 or angle > 1.13:
                print("Invalid input. Please select a number between -1.13 and 1.13.")
            else:
               input_convertor(angle,choice)

        # Ask for the ratio for choices 6 and 7
        elif choice in [6, 7]:
            ratio = float(input("Enter the ratio between [-1, 1]: "))

            if ratio < -1 or ratio > 1:
                print("Invalid input. Please select a number between -1 and 1.")
            else:
               input_convertor(ratio,choice)

        # Ask for the ratio for choice 8
        elif choice == 8:
            exp_in = float(input("Enter the exponent in range [-10, 10]: "))

            if exp_in < -10 or exp_in > 10:
                print("Invalid input. Please select a number between -10 and 10.")
            else:
               input_convertor(exp_in,choice)
        # Ask for the input for choices 9 and 10
        elif choice in [9, 10]:
            log_in = float(input("Enter the input in range [0, 30000]: "))

            if log_in < 0 or log_in > 30000:
                print("Invalid input. Please select a number between 0 and 30000.")
            else:
               input_convertor(log_in,choice)

        # Ask for the input for choice 11

        elif choice == 11:
            ratio1 = float(input("Enter the value of x between [-255, 255]: "))
            ratio2 = float(input("Enter the value of y between [-255, 255]: "))
        
            if ratio1 < -255 or ratio1 > 255 or ratio2 < -255 or ratio2 > 255:
                print("Invalid input. Please select numbers between -255 and 255.")
            else:
                input_convertor_arctan(ratio1, ratio2, choice)  # New function for arctan


def sin_cos_input_convertor(angle,choice):
    byte_array = angle.to_bytes(4, byteorder='big')
    data_packeting(byte_array,choice)

def input_convertor(input_in,choice):
    ratio_in = input_in*65536
    int_input = int(round(ratio_in))
    byte_array = int_input.to_bytes(4, byteorder='big')
    data_packeting(byte_array,choice)

def input_convertor_arctan(ratio1, ratio2, choice):
    ratio1_in = int(round(ratio1 * 65536))
    ratio2_in = int(round(ratio2 * 65536))

    byte_array1 = ratio1_in.to_bytes(4, byteorder='big')
    byte_array2 = ratio2_in.to_bytes(4, byteorder='big')

    data_packeting_arctan(byte_array1, byte_array2, choice)

def data_packeting(byte_array,choice):
    if choice in [1, 2]:
        mode = 1
    elif choice in [3, 4]:
        mode = 2
    elif choice == 5:
        mode = 3
    elif choice in [6, 7]:
        mode = 4
    elif choice == 8:
        mode = 5
    elif choice == 9:
        mode = 6
    elif choice == 10:
        mode = 7
    elif choice == 11:
        mode = 8

    mode_byte = mode.to_bytes(2,byteorder='big')
    data_in = mode_byte + byte_array
    transfer_data(data_in)

def data_packeting_arctan(byte_array1, byte_array2, choice):
    mode = 8  # Mode for arctan

    mode_byte = mode.to_bytes(2, byteorder='big')
    data_in = mode_byte + byte_array1 + mode_byte + byte_array2  
    transfer_data(data_in)

def transfer_data(data_in):
    pyrah.rah_write(APPID,data_in)


def receive_data():
    input_data_and_mode()
    while True:
        data = pyrah.rah_read(APPID,6)
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

    mode_sel_hex = hex_data[2:4]  # First 2 bytes
    hex_data = hex_data[4:]  # Remaining 4 bytes
    mode_sel = int(mode_sel_hex,16)
    data = int(hex_data, 16)

    if choice == 1 and mode_sel == 10:
        out_angle = data/denom
        print("The output of sin",angle,"is:",out_angle)
    elif choice == 2 and mode_sel == 12:
        out_angle = data/denom
        print("The output of cos",angle,"is:",out_angle)

    if choice == 3 and mode_sel == 10:
        out_angle = data/denom
        print("the output of sinh",angle,"is:",out_angle)
    elif choice == 4 and mode_sel == 10:
        out_angle = data/denom
        print("The output of cos",angle,"is:",out_angle)

    if choice == 5 and mode_sel == 11:
        out_angle = data/denom
        print("the output of tahh",angle,"is:",out_angle)

    if choice == 6 and mode_sel == 10:
        out_ratio = data/denom
        print("the output of arcsin",ratio,"is:",out_ratio)
    elif choice == 7 and mode_sel == 12:
        out_ratio = data/denom
        print("The output of arccos",ratio,"is:",out_ratio)

    elif choice == 8 and mode_sel == 14:
        out_exp = data
        print("The output of exp",exp_in,"is:",out_exp)

    if choice == 9 and mode_sel == 15:
        out_log = data/denom
        print("the output of a log",log_in,"is:",out_log)
    elif choice == 10 and mode_sel == 13:
        out_log = data/denom
        print("The output of log",log_in,"is:",out_log)

    elif choice == 11 and mode_sel == 11:
        out_ratio = data/denom
        print("the output of a arctan for x=",ratio1,"and y=",ratio2,"is:",out_ratio)

def main():
    receive_data()

if __name__ == "__main__":
    main()
