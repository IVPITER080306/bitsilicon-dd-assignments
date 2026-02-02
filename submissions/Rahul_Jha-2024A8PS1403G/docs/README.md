# Verilog Stopwatch with C++ Co-Simulation
**Name:** Rahul Jha
**ID:** 2024A8PS1403G

## Project Description
This project implements a digital stopwatch using Verilog for the hardware logic and C++ for the testbench and simulation. The design is based on a **Finite State Machine (FSM)** that controls two counter modules (Seconds and Minutes).

### Approach
* **Control FSM:** Uses a 3-state FSM (`IDLE`, `RUNNING`, `PAUSED`) to manage the stopwatch operation based on `start`, `stop`, and `reset` inputs.
* **Modular Design:** The minutes and seconds counters are separated into their own modules (`seconds_counter.v`, `minutes_counter.v`) for cleaner logic and reusability.
* **Synchronous Logic:** The design uses a global clock and synchronous resets to ensure stability.
* **C++ Testbench:** A `main.cpp` file acts as the testbench, driving the clock and simulating button presses to verify the FSM states and counter values in real-time.

## Directory Structure
* **src/**: Contains all source code.
    * `stopwatch_top.v`: Top-level module connecting FSM and counters.
    * `control_fsm.v`: State machine logic.
    * `seconds_counter.v`: 0-59 counter with rollover logic.
    * `minutes_counter.v`: Minutes counter triggered by seconds rollover.
    * `main.cpp`: C++ simulation wrapper using Verilator.
* **docs/**: Contains simulation screenshots and reports.

## Prerequisites
* **Verilator**: For compiling Verilog to C++.
* **Build Essentials**: `make` and `g++` (GCC) for compiling the generated C++ model.

## How to Run (Execution Steps)

1.  **Navigate to the source directory:**
    ```bash
    cd src
    ```

2.  **Compile the Project:**
    Run the following Verilator command to build the C++ model and executable:
    ```bash
    verilator -Wall --cc --exe --build stopwatch_top.v seconds_counter.v minutes_counter.v control_fsm.v main.cpp
    ```

3.  **Run the Simulation:**
    Execute the generated binary:
    ```bash
    ./obj_dir/Vstopwatch_top
    ```

## Expected Output
The simulation will print the current time and state to the terminal.
* **Status 0**: IDLE
* **Status 1**: RUNNING
* **Status 2**: PAUSED

Example:
```text
System Reset Released
Display: 00:00
Button Pressed: START
Display: 00:01
...
Button Pressed: STOP
Display: 00:45
