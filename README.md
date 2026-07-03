# FPGA 2D Fighting Game

## Project Overview
This project is a 2D fighting game designed entirely in Verilog and implemented on an FPGA board. The project was built using Intel Quartus. 

The game includes player movement controls, basic attack modes, and a collision system. The entire visual output is handled via hardware-level VGA driver design to display the game state on a monitor in real-time.

## Features
* **Player Mechanics:** Implements 2D movement and real-time attack detection.
* **VGA Display:** Hardware-level VGA controllers designed in Verilog to handle the visual rendering.
* **Single-File Architecture:** The entire core project structure, modules, and pin assignments are bundled into a single archived project file for easy portability.

## Files in this Repository
* `fpga_fighting_game.qar` - The complete Quartus Archived Project file containing all Verilog source modules, pin assignments, and design configurations.

## How to Run
1. Open Intel Quartus.
2. Go to **Project -> Restore Archived Project** and select the `.qar` file.
3. Choose your destination directory to extract the full project structure.
4. Compile the design and assign the pins according to your specific FPGA development board before flashing.

## Author
* Barış Akdağ - Electrical Engineering Student, Middle East Technical University (METU)
