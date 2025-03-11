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
RAH is a protocol developed by Vicharak to facilitate efficient data transfer between the CPU and FPGA. It enables the CPU to run multiple applications, encapsulating their data into structured frames identified by an **app_id** and delivering them to the FPGA. The key data transfer process is as follows:

1. **Data Transmission (CPU to FPGA)**:
   - The CPU encapsulates application data into a distinguishable frame (with **app_id**).
   - The RAH Services send this frame to the FPGA.
   - The FPGA decodes the frame and writes it into the appropriate **APP_WR_FIFO**.

2. **Data Processing and Response (FPGA to CPU)**:
   - The FPGA processes the data and writes the result into **APP_RD_FIFO**.
   - The RAH Services encapsulate this data and send it back to the CPU.
   - The CPU decodes the frame and extracts the computed results.

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
  - **Mode 1**: Computes Sin and Cos
  - **Mode 2**: Computes Hyperbolic Sine (sinh) and Hyperbolic Cosine (cosh)
  - **Mode 3**: Computes Hyperbolic Tangent (tanh)
  - **Mode 4**: Computes Arcsin and Arccos
  - **Mode 5**: Computes Exponential (exp)
  - **Mode 6**: Computes Natural Logarithm (ln)
  - **Mode 7**: Computes Square Root (sqrt)
  - **Mode 8**: Computes Arctan

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

## CPU-Side User Guide

## Conclusion
This project showcases an efficient implementation of the CORDIC algorithm on FPGA using Verilog, integrated with RAH for seamless communication between the CPU and FPGA. The design supports a range of mathematical functions, making it a versatile solution for hardware-accelerated computing applications.
