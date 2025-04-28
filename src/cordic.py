#!/usr/bin/python3

import pyrah

APPID = 1
denom = 65536

def safe_input(prompt, convert_func=int, valid_range=None):
    while True:
        try:
            user_input = convert_func(input(prompt))
            if valid_range and not (valid_range[0] <= user_input <= valid_range[1]):
                print(f"Invalid input. Please enter a value between {valid_range[0]} and {valid_range[1]}.\n")
                continue
            return user_input
        except ValueError:
            print("Invalid input. Please enter a valid number.\n")
        except (KeyboardInterrupt, EOFError):
            print("\n")
            exit()

def input_data_and_mode():
    global choice
    global angle
    global ratio
    global exp_in
    global log_in
    global ratio1
    global ratio2

    print("\n=== Welcome to the Trigonometric Calculator ===\n")
    print("Select the trigonometric function you want to calculate:")
    print("1. Sine (sin)")
    print("2. Cosine (cos)")
    print("3. Sinh (sinh)")
    print("4. Cosh (cosh)")
    print("5. Tanh (tanh)")
    print("6. Arcsine (asin)")
    print("7. Arccosine (acos)")
    print("8. Exponential (exp)")
    print("9. Logarithmic (log)")
    print("10. Square root (sqrt)")
    print("11. Arctangent (atan)")
    print("12. Exit\n")

    in_choice = safe_input("Enter the number corresponding to the function (1-12): ", int, (1, 12))

    if in_choice == 12:
        print("\nThank you for using the Trigonometric Calculator.")
        exit()

    print("\nYou selected option:", in_choice)

    if in_choice == 1 or in_choice == 2:
        angle = safe_input("Enter the angle in degrees between [0, 360]: ", int, (0, 360))
        choice = 1 if in_choice == 1 else 9
        sin_cos_input_convertor(angle, choice)

    elif in_choice == 3 or in_choice == 4:
        angle = safe_input("Enter the angle in radians between [-3.142, 3.142]: ", float, (-3.142, 3.142))
        choice = 2 if in_choice == 3 else 10
        input_convertor(angle, choice)

    elif in_choice == 5:
        angle = safe_input("Enter the angle in radians between [-1.13, 1.13]: ", float, (-1, 1.13))
        choice = 3
        input_convertor(angle, choice)

    elif in_choice == 6 or in_choice == 7:
        ratio = safe_input("Enter the ratio between [-1, 1]: ", float, (-1, 1))
        choice = 4 if in_choice == 6 else 11
        input_convertor(ratio, choice)

    elif in_choice == 8:
        exp_in = safe_input("Enter the exponent in range [-10, 10]: ", float, (10, 10))
        choice = 5
        input_convertor(exp_in, choice)

    elif in_choice == 9 or in_choice == 10:
        log_in = safe_input("Enter the input in range [1, 30000]: ", float, (1, 30000))
        choice = 6 if in_choice == 9 else 7
        input_convertor(log_in, choice)

    elif in_choice == 11:
        ratio1 = safe_input("Enter the value of x between [-255, 255]: ", float, (-255, 255))
        ratio2 = safe_input("Enter the value of y between [-255, 255]: ", float, (-255, 255))
        choice = 8
        input_convertor_arctan(ratio1, ratio2, choice)

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
    print(data_in)
    pyrah.rah_write(APPID, data_in)

def receive_data():
    data = pyrah.rah_read(APPID, 6)
    print(data)
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

    print("\n=== Result ===")
    if choice == 1:
        print(f"The output of sin({angle}°) is: {out_val}")
    elif choice == 2:
        print(f"The output of sinh({angle} rad) is: {out_val}")
    elif choice == 3:
        print(f"The output of tanh({angle} rad) is: {out_val}")
    elif choice == 4:
        print(f"The output of asin({ratio}) is: {out_val}")
    elif choice == 5:
        print(f"The output of exp({exp_in}) is: {out_val}")
    elif choice == 6:
        print(f"The output of log({log_in}) is: {out_val}")
    elif choice == 7:
        print(f"The output of sqrt({log_in}) is: {out_val}")
    elif choice == 8:
        print(f"The output of arctan(y={ratio2}, x={ratio1}) is: {out_val}")
    elif choice == 9:
        print(f"The output of cos({angle}°) is: {out_val}")
    elif choice == 10:
        print(f"The output of cosh({angle} rad) is: {out_val}")
    elif choice == 11:
        print(f"The output of acos({ratio}) is: {out_val}")
    print("=================\n")

def main():
    input_data_and_mode()
    receive_data()

if __name__ == "__main__":
    while True:
        try:
            main()
        except (KeyboardInterrupt, EOFError):
            break
        except Exception as e:
            print(f"An unexpected error occurred: {e}\n")
            break
