# Approximate Perceptron VLSI Design

A hardware-efficient perceptron implementation using **approximate 8×8 multipliers**, designed, synthesized, and verified using **UMC 65nm technology**. This project was part of a summer internship at **IIT Guwahati** under the guidance of **Prof. Roy Paily Palathinkal**.

---

## Project Overview

This project explores **Approximate Computing** to reduce area, power, and delay in hardware implementations of neural networks. We designed multiple 8×8 approximate multipliers and integrated them into a **perceptron** model. The entire system was evaluated for image processing applications like **smoothing** and **edge detection**, and also tested on the **MNIST dataset**.

---

##  Key Features

-  Custom 8×8 approximate multipliers (N8-L1, N8-L2, N8-5, N8-6)
-  Reduced power and area with minimal accuracy loss
-  Simulation and synthesis using Verilog + Synopsys
-  Designed and tested with UMC 65nm technology
-  Applied to image smoothing, edge detection & MNIST digit recognition

---

##  Performance Metrics

| Multiplier Type | Area Reduced | Power Saved | Accuracy (SSIM/MNIST) |
|------------------|--------------|--------------|------------------------|
| N8-L1            | High         | High         | Moderate               |
| N8-L2            | Medium       | Medium       | High                   |
| N8-5             | Medium       | High         | Moderate               |
| N8-6             | Low          | Medium       | High                   |

---

##  Tools & Technologies

- **Verilog HDL**
- **Synopsys Design Compiler**
- **UMC 65nm Standard Cell Library**
- **Python + MNIST dataset (for evaluation)**
- **Cadence Genus (for synthesis & analysis)**

---

##  Report & Documentation

📎 [Summer Internship Report (PDF)](docs/Summer_Internship_Report.pdf)  

---

##  License

This project is licensed under the [MIT License](LICENSE).

---

##  Author

**Tripti Golchha**  
Electronics and Communication Engineering  
National Institute of Technology, Silchar  
[GitHub @tripti02](https://github.com/tripti02)

---

##  Future Work

- Apply approximate techniques to deeper networks
- Explore FPGA/ASIC implementation
- Optimize further using Genetic Algorithms or Reinforcement Learning


