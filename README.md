# CORDIC Application Design using Verilog on FPGA with RAH

## Introduction to CORDIC
CORDIC (Coordinate Rotation Digital Computer) is an efficient algorithm used for computing various mathematical functions such as trigonometric, hyperbolic, logarithmic, and square root operations. It is particularly useful in hardware implementations due to its iterative shift-and-add approach, which eliminates the need for complex multiplications.

This project demonstrates an application example using RAH (Real-time Application Handler) to implement the CORDIC algorithm on an FPGA. The design supports multiple functions including:

- Sine (sin) and Cosine (cos)
- Hyperbolic Sine (sinh) and Hyperbolic Cosine (cosh)
- Arcsine (arcsin) and Arccosine (arccos)
- Arctangent (arctan) and Hyperbolic Tangent (tanh)
- Exponential (exp)
- Natural Logarithm (ln)
- Square Root (sqrt)

## Functions of CORDIC
 **Modes of Operation**: Different modes are assigned to execute different functions based on the input frame received by the FPGA.

The CORDIC-based implementation allows users to compute the following functions efficiently on FPGA:

1. **Trigonometric Functions**: Computes sin, cos, arcsin, arccos, and arctan.
2. **Hyperbolic Functions**: Computes sinh, cosh, and tanh.
3. **Logarithmic and Exponential**: Computes ln and exp.
4. **Square Root**: Computes sqrt.

## Understanding RAH (Real-time Application Handler)
RAH is a protocol developed by Vicharak to enable efficient and real-time data transfer between the CPU and FPGA. It allows the CPU to manage multiple applications simultaneously by encapsulating their data into structured frames, each identified by a unique app_id, and routing them to the appropriate logic on the FPGA.

## FPGA User Guide

### Input Frame Format

The FPGA receives input frames via the RAH communication interface. The input frame format for CORDIC processing is as follows:

- **48-bit Frame Structure**:
  - **1st Byte**: Reserved
  - **2nd Byte**: Mode selection (determines which function to execute)
  - **3rd - 6th Bytes**: Input value for computation

  ![image](images/Input_data_frame_structure.svg)

#### Special Case: Arctan Function
For the **arctan** function, **two input frames** are required, as it involves two input values instead of one.
The RAH protocol ensures that these frames are sent sequentially and processed accordingly by the FPGA.

#### Example
```sh
Input packet: 00 08 00 01 00 00 00 08 00 00 00 00
```
- **Mode Selection**:
  - **Mode 1**  : Computes Sin 
  - **Mode 2**  : Computes Hyperbolic Sine (sinh)
  - **Mode 3**  : Computes Hyperbolic Tangent (tanh)
  - **Mode 4**  : Computes Arcsin 
  - **Mode 5**  : Computes Exponential (exp)
  - **Mode 6**  : Computes Natural Logarithm (ln)
  - **Mode 7**  : Computes Square Root (sqrt)
  - **Mode 8**  : Computes Arctan
  - **Mode 9**  : Computes Cos
  - **Mode 10** : Computes Hyperbolic Cosine (cosh)
  - **Mode 11** : Computes Arccos

### Output Frame Format
As per the design, the output frame received on the terminal (through RAH communication) follows this format:

- **1st Byte**: Reserved
- **2nd Byte**: Indicates the output function (sin, cos, etc.)
- **3rd - 6th Bytes**: Output value

  ![image](images/output_data_frame_structure.svg)

- **Function Encoding in 2nd Byte:
  - **'a'** → Sin / Arcsin / Sinh
  - **'c'** → Cos / Arccos / Cosh
  - **'b'** → Tanh / Arctan 
  - **'e'** → Exp
  - **'f'** → Ln
  - **'d'** → Sqrt

## CPU Guide

This script provides a user interface to perform trigonometric and mathematical calculations. To access the interface, use the following command:

```
sudo python3 cordic.py
```

### How the interface looks:

```
Select the trigonometric function you want to calculate:
1. Sine (sin)
2. Cosine (cos)
3. Sinh (sinh)
4. Cosh (cosh)
5. Tanh (tanh)
6. Arcsine (asin)
7. Arccosine (acos)
8. Exponential (exp)
9. Logarithmic (log)
10. Square root (sqrt)
11. Arctangent (atan)
Enter the number corresponding to the function (1-11):
```

### Function Selection and Input Details

Each function corresponds to a specific calculation:

1. **Sine (sin):** Enter an angle in degrees [0, 360].
2. **Cosine (cos):** Enter an angle in degrees [0, 360].
3. **Sinh (sinh):** Enter a value in the range [-3.142, 3.142].
4. **Cosh (cosh):** Enter a value in the range [-3.142, 3.142].
5. **Tanh (tanh):** Enter a value in the range [-1.13, 1.13].
6. **Arcsine (asin):** Enter a value between [-1, 1].
7. **Arccosine (acos):** Enter a value between [-1, 1].
8. **Exponential (exp):** Enter a value in the range [-10, 10].
9. **Logarithmic (log):** Enter a positive value in range [0, 30000].
10. **Square root (sqrt):** Enter a non-negative value in range [0, 30000].
11. **Arctangent (atan):** Enter two values (x, y), both in the range [-255, 255].

### Running the Program

To execute the script:

1. Save the Python script to your local machine.
2. Open a terminal or command prompt.
3. Run the script using the command:
   
   ```
   sudo python3 cordic.py 
   ```

This will start the program and display the main menu for selecting the operation mode.

### Input and Results

After selecting a mode (e.g., Sine or Logarithm), the program will prompt you to enter a numerical value within the valid range. Once processed, the result is displayed in decimal format.

Example:

- If you selected **Arctangent (atan)** and entered `x = 3`, `y = 4`, the program will output:
  
```
  The output of arctan for x = 3.0 and y = 4.0 is: 53.1279296875
```

The interface allows users to perform mathematical computations easily and efficiently.

## RAH Protocol User Guide - Resources

1. **[CPU Usage Guide](https://github.com/vicharak-in/rah-bit/blob/master/docs/cpu-usage-guide.md)**:
   This guide will provide detailed instructions on how to set up and use the RAH protocol on the CPU side.

2. **[FPGA Implementation Guide](https://github.com/vicharak-in/rah-bit/blob/master/docs/fpga-implementation.md)**:
   This guide covers the FPGA side of the RAH protocol .

3. **[RAH Example Integration](https://github.com/vicharak-in/rah-bit/blob/master/docs/rah-example-integration.md)**:
   This document provides a step-by-step example of integrating the RAH protocol between the CPU and FPGA, demonstrating the complete flow from data generation on the CPU to processing on the FPGA and back.


This project showcases an efficient implementation of the CORDIC algorithm on FPGA using Verilog, integrated with RAH for seamless communication between the CPU and FPGA. The design supports a range of mathematical functions, making it a versatile solution for hardware-accelerated computing applications.

If you encounter any issues, feel free to refer to this guide for help or reach out for further clarification!

Good luck with your integration, and happy coding!
