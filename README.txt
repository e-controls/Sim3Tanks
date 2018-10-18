+-------------------------------------------------------------------------------------------------------------+
*** Sim3Tanks: A Benchmark Model Simulator for Process Control and Monitoring ***
+-------------------------------------------------------------------------------------------------------------+
1. Sim3Tanks was developed using MATLAB version 9.2.0.538062 (R2017a) for
windows 64 bits and uses the ode45 solver to solve numerically the differential
equations of the three-tank system shown in figure "three_tank_system.jpg".

2. Sim3Tanks allows the user to define an operation mode for the system
valves (open or closed), making possible the creation of different case studies.

3. Sim3Tanks allows the user to simulate 21 faults that can arise in an
abrupt (stepwise) or incipient (driftwise) way (see figure "fault_behavior.jpg").

4. Please, visit https://github.com/e-controls/Sim3Tanks to get the latest version of Sim3Tanks.


# Written by Arllem Farias, 2018 (arllemfarias@ufam.edu.br/arllem.f@gmail.com).


+-------------------------------------------------------------------------------------------------------------+
*** Running Sim3Tanks via GUI ***
+-------------------------------------------------------------------------------------------------------------+
1. Put the root folder "Sim3Tanks" in the MATLAB current folder and open 
the file "Sim3Tanks_gui.m".

2. Run the file by clicking "Run" in the tab "editor" or pressing F5 on the keyboard.

3. After running the file "Sim3Tanks_gui.m", the command window and the workspace
will be cleaned, all figures will be closed, all paths and subpaths needed
will be added and the Graphical User Interface (GUI) will be displayed.

4. In the displayed GUI are all settings of the simulator, change the parameters
as desired and click "Run simulation".

5. When a simulation starts another GUI is displayed to show a real-time
animation of the simulation.

6. When a simulation finishes all real and measured levels and flows, behavior
of the valves, and fault signals are exported to the user's workspace.

### INCLUDING A CONTROL SYSTEM ###
A1. In the panel "Control system" select "yes", an example of a digital PID controller
to flow Q3 with setpoint of 120 cm^3/s and sample time of 0.1s will be displayed. There
is another example of a digital PID controller to levels h1 and h2 that can be used
changing the function name to "level_controller" and the setpoint to a column vector
with two positions, for example, [2,3]', where h1 = 2cm and h2 = 3cm.

A2. To add any digital controller to the system just create a function with the mask
[cout1,cout2,cout3] = mycontroller(setpoint,Qp,y), where the input arguments are:
a) setpoint: desired value.
b) Qp: flow from the pumps (Qp = [Qp1(k),Qp2(k)]').
c) y: all measured outputs (y = [h1(k),h2(k),h3(k),u1(k),u2(k),Qa(k),Qb(k),Q13(k),Q23(k),Q1(k),Q2(k),Q3(k)]').

and the output arguments are:
a) cout1: must be the control signal (cout1 = u = [u1(k),u2(k)]').
b) cout2: free variable (any desired parameter).
c) cout3: free variable (any desired parameter).

A3. Add the created function, i.e., "mycontroller" and all its subfunctions
in the MATLAB current folder or add them in the folder "control_system".

A4. Back to the main screen, mark the checkbox "yes" in the panel "Control system",
in the textbox type the function name of the designed controller, i.e., "mycontroller",
and enter the desired setpoint and sample time.

A5. Run the simulation, when a simulation finishes the controller output
arguments, i.e., cout1, cout2, and cout3, are exported to the user's workspace.

### INCLUDING A FDI SYSTEM ###
B1. In the panel "FDI system" select "yes", an example of a FDI system for 
the default scenario (i.e., Kp1=Kp2=K13=K23=K3=1 and Ka=Kb=K1=K2=0) with
sample time of 0.1s will be displayed.

B2. To add any FDI system to the simulator just create a function with the mask
[fout1,fout2,fout3,fout4,fout5] = myfdisystem(u,y), where the input arguments are:
a) u: control signals (u = [u1,u2]').
b) y: all measured outputs (yk = [h1(k),h2(k),h3(k),u1(k),u2(k),Qa(k),Qb(k),Q13(k),Q23(k),Q1(k),Q2(k),Q3(k)]').

and the output arguments are:
a) fout1: free variable (any desired parameter).
b) fout2: free variable (any desired parameter).
c) fout3: free variable (any desired parameter).
d) fout4: free variable (any desired parameter).
e) fout5: free variable (any desired parameter).

B3. Add the created function, i.e., "myfdisystem" and all its subfunctions
in the MATLAB current folder or add them in the folder "fdi_system".

B4. Back to the main screen, mark the checkbox "yes" in the panel "FDI system",
in the textbox type the function name of the designed FDI system, i.e., "myfdisystem",
and enter the desired sample time.

B5. Run the simulation, when a simulation finishes the FDI system outputs, i.e.,
fout1, fout2, fout3, fout4, and fout5, are exported to the user's workspace.


+-------------------------------------------------------------------------------------------------------------+
*** Running Sim3Tanks via Simulink ***
+-------------------------------------------------------------------------------------------------------------+
1. Put the root folder "Sim3Tanks" in the MATLAB current folder and open
the simulink file "Sim3Tanks_simulink.slx", the MATLAB must be at least
version R2017a.

2. Click twice on the "Three-Tank System" block to open the Sim3Tanks configurations
and set the simulation parameters, scenario, and faults as desired and click "Apply"
and after "OK".

3. Run simulation by clicking "Run" or pressing Ctrl+T on the keyboard.

4. When a simulation starts the command window and the workspace are cleaned,
all figures are closed, and all paths and subpaths needed to run the simulation
are added.

5. When a simulation finishes the simulink loading bar is complete.

NOTE: In the system feedback signals in Simulink, the user must use a memory
block to avoid errors due to algebraic loops.

### INCLUDING DIFFERENT TYPES OF FAULTS ###
A1. Click twice on the "Sim3Tanks" block and go to tab "faults".

A2. Mark the checkbox "From workspace" and click on link available, the script
"fault_signals.m" will be open, put the fault signals as desired and save it.
NOTE: Do not edit fields marked with "DO NOT EDIT".

A3. Go back to tab "faults" and click "Apply" and after "OK".

A4. In the Simulink file "Sim3Tanks_simulink.slx", run simulation by clicking
"Run" or pressing Ctrl+T on the keyboard.


+-------------------------------------------------------------------------------------------------------------+
*** Running Sim3Tanks with control and FDI system via script ***
+-------------------------------------------------------------------------------------------------------------+
1. Put the root folder "Sim3Tanks" in the MATLAB current folder and open 
the file "Sim3Tanks_script.m".

2. In the file "Sim3Tanks_script.m" are all settings of the simulator, control
and FDI system, change the parameters as desired and save it.

3. Run the file by clicking "Run" in the tab "editor" or pressing F5 on the keyboard.

4. When a simulation starts the command window and the workspace are cleaned,
all figures are closed, all paths and subpaths needed to run the simulation
are added and the message "#Running Sim3Tanks..." is displayed in the command window.

5. When a simulation finishes the message "#Plotting Graphs..." is displayed
in the command window and all real and measured levels and flows, behavior of
the valves, and fault signals are displayed in figures.


+-------------------------------------------------------------------------------------------------------------+
*** Running (only) Sim3Tanks via script ***
+-------------------------------------------------------------------------------------------------------------+
1. Go to the folder "three_tank_system" and open the file "Sim3Tanks.m".

2. In the file "Sim3Tanks.m" are all settings of the simulator, change the
parameters as desired and save it.

3. Run the file by clicking "Run" in the tab "editor" or pressing F5 on the keyboard.

4. When a simulation starts the command window and the workspace are cleaned, all
figures are closed, all paths and subpaths needed to run the simulation are
added and the message "#Running Sim3Tanks..." is displayed in the command window.

5. When a simulation finishes the message "#Plotting Graphs..." is displayed
in the command window and all real and measured levels and flows, behavior of
the valves, and fault signals are displayed in figures.
