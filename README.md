# Augmented Reality for Kilobots Software (with built-in controller design and compilation).

This repository features a version of the Augmented Reality for Kilobots (ARK) software, which introduces two new functionalities not available in the [original version](https://github.com/DiODeProject/KilobotArena): 
1. Formal and graphical design of swarm controllers. This is done using the [Nadzuro2](https://github.com/openswarm-eu/Nadzoru2) software.
2. Built-in compilation of the swarm controller.

## Requirements
To be able to run the simulator, you must have:
- A recent version of Linux, MacOSX or Windows
- For ARK, same requirments as the [original version](https://github.com/DiODeProject/KilobotArena).
- ForNadzuro2, Python 3.6 (or newer), PyGObject, and Jinja2 must be installed.

## Instalation 

First clone the git repository of Nadzuro2 into the home folder of your computer:
```bash
git clone https://github.com/openswarm-eu/Nadzoru2.git
```
Install ARK as described in the [original version](https://github.com/DiODeProject/KilobotArena).

## Run  

-Run ARK as described in the [original version](https://github.com/DiODeProject/KilobotArena). 

-To design a swarm controller from ARK:
- Press the **Design Controller** button from the **Controller** tab in the ARK UI. This will ask you to select a folder of where the controller files will be stored. 
- Once you select a folder,  the Nadzuro2 software will open providing you with an external UI to graphically design the controller. 
- Once you finish designing the controller, make sure it is saved into the folder selected earlier.

-To compile the designed controller, press the **Compile Controller** button from the **Controller** tab in the ARK UI. A pop up message will let you know if the compilation was successfull or not. In case, of compilation errors, you will get these from within Qt Creator error logs.

-To upload the compiled code, press the **Upload Controller** button from the **Controller** tab in the ARK UI. This will upload the controller binary to the robots present in the ARK arena.