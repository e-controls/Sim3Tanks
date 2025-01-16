![Status](https://img.shields.io/badge/STATUS-Updating...-blue)
![License](https://img.shields.io/badge/License-_MIT-green)
![Language](https://img.shields.io/badge/Language-_MATLAB-green)
> [!NOTE]
> This README is still being updated...

# Sim3Tanks: A Benchmark Model Simulator for Process Control and Monitoring
Sim3Tanks is suitable for studying and developing process control, fault detection and diagnosis, and fault-tolerant control strategies for nonlinear multivariable systems. This new release was developed in the MATLAB environment, version 9.11.0 (2021b), and can be used via command-line script <`file.m`>. Future releases will include versions for using the simulator via Simulink block diagram <`file.slx`> and graphical user interface <`file.fig`>.

The original paper that publishes the simulator can be accessed at <http://dx.doi.org/10.1109/ACCESS.2018.2874752> and its repository at <https://github.com/e-controls/Sim3Tanks_old>.

## 1. Table of Contents

- [Sim3Tanks Plant Description](#2-sim3tanks-plant-description)
- [Fault Description and Symbols](#3-fault-description-and-symbols)
- [How to Create and Configure a Sim3Tanks Object](#4-how-to-create-and-configure-a-sim3tanks-object)
- [Contributions](#5-contributions)
- [Citation](#6-citation)
- [License](#7-license)


## 2. Sim3Tanks Plant Description
Sim3Tanks simulates the dynamic behavior of the following plant:

<p align="center">
	<img src="/assets/images/three_tank_system.jpg"/> 
	<br>
	<strong>Figure 1:</strong> Sim3Tanks plant.
</p>

- The plant consists of three cylindrical tanks interconnected by four pipes, allowing fluid exchange between the lateral tanks (T1 and T2) and the central tank (T3) in both directions. The dashed arrows indicate the reference direction of each flow. Negative values indicate that the flow is opposite to this reference.

- The upper pipes and valves that connect the lateral tanks to the central tank are located at the same height h<sub>0</sub> and are called transmission pipes and valves. The lower pipes and valves are aligned with the base of the tanks and are called connection pipes and valves. At the bottom of each tank are the output pipes and valves.

- The pumps P1, P2, and P3 share the same minimum and maximum flow rate constraints, but they work independently and can provide different flow rates Q<sub>P1</sub>, Q<sub>P2</sub>, and Q<sub>P3</sub> to the tanks T1, T2, and T3, respectively.

- The tanks are identical and have the same radius and maximum height. Similarly, all pipes are also identical and have the same radius value. The system has three level sensors (one per tank) and ten flow sensors (one per valve), and any valve can be configured as an actuator.

- When a valve is enabled to be controlled, it becomes an actuator and, consequently, Sim3Tanks simulates an actuator fault (loss of effectiveness). Otherwise, a plant fault is simulated, which could be a clogging if the valve operation mode is defined as 'Open', or leakage if its operation mode is set to 'Closed'.

## 3. Fault Description and Symbols
Sim3Tanks allows the user to define different scenarios for case studies with as many actuators and sensors as necessary, in addition to simulating different kinds of perturbations, faults, and noises. The following table briefly describes the faults modeled in Sim3Tanks.

| Symbol | Description |
| --- | --- |
| `f1`   | Blocking/Clogging in pump 1, if `ValveSettings.Kp1.OperationMode = 'Open'`. |
|         | Disturbance in tank 1, if `ValveSettings.Kp1.OperationMode = 'Closed'`. |
| `f2`   | Blocking/Clogging in pump 2, if `ValveSettings.Kp2.OperationMode = 'Open'`. |
|         | Disturbance in tank 2, if `ValveSettings.Kp2.OperationMode = 'Closed'`. |
| `f3`   | Blocking/Clogging in pump 3, if `ValveSettings.Kp3.OperationMode = 'Open'`. |
|         | Disturbance in tank 3, if `ValveSettings.Kp3.OperationMode = 'Closed'`. |
| `f4`   | Clogging in the transmission pipe from tank 1 to tank 3, if `ValveSettings.Ka.OperationMode = 'Open'`. |
|         | Leakage through the transmission pipe from tank 1 to tank 3, if `ValveSettings.Ka.OperationMode = 'Closed'`. |
| `f5`   | Clogging in the transmission pipe from tank 2 to tank 3, if `ValveSettings.Kb.OperationMode = 'Open'`.  |
|         | Leakage through the transmission pipe from tank 2 to tank 3, if `ValveSettings.Kb.OperationMode = 'Closed'`. |
| `f6`   | Clogging in the connection pipe from tank 1 to tank 3, if `ValveSettings.K13.OperationMode = 'Open'`. |
|         | Leakage through the connection pipe from tank 1 to tank 3, if `ValveSettings.K13.OperationMode = 'Closed'`. |
| `f7`   | Clogging in the connection pipe from tank 2 to tank 3, if `ValveSettings.K23.OperationMode = 'Open'`. |
|         | Leakage through the connection pipe from tank 2 to tank 3, if `ValveSettings.K23.OperationMode = 'Closed'`. |
| `f8`   | Clogging in output pipe of the tank 1, if `ValveSettings.K1.OperationMode = 'Open'`. |
|         | Leakage in tank 1, if `ValveSettings.K1.OperationMode = 'Closed'`. |
| `f9`   | Clogging in output pipe of the tank 2, if `ValveSettings.K2.OperationMode = 'Open'`. |
|         | Leakage in tank 2, if `ValveSettings.K2.OperationMode = 'Closed'`. |
| `f10` | Clogging in output pipe of the tank 3, if `ValveSettings.K3.OperationMode = 'Open'`. |
|         | Leakage in tank 3, if `ValveSettings.K3.OperationMode = 'Closed'`. |
| `f11` | Fault in level sensor `h1`. |
| `f12` | Fault in level sensor `h2`. |
| `f13` | Fault in level sensor `h3`. |
| `f14` | Fault in flow sensor `Q1in`. |
| `f15` | Fault in flow sensor `Q2in`. |
| `f16` | Fault in flow sensor `Q3in`. |
| `f17` | Fault in flow sensor `Qa`. |
| `f18` | Fault in flow sensor `Qb`. |
| `f19` | Fault in flow sensor `Q13`. |
| `f20` | Fault in flow sensor `Q23`. |
| `f21` | Fault in flow sensor `Q1`. |
| `f22` | Fault in flow sensor `Q2`. |
| `f23` | Fault in flow sensor `Q3`. |

## 4. How to Create and Configure a Sim3Tanks Object
A Sim3Tanks object is created using the `createSim3Tanks()` function.

```sh
tts = createSim3Tanks();
```

This function does not have an input argument and returns an object with the following fields:

- [**Model**](#41-the-model-attribute)                               : [attribute]
- [**simulateModel**](#42-the-simulatemodel-method)                  : [method]
- [**displayFields**](#43-the-displayfields-method)                  : [method]
- [**clearModel**](#44-the-clearmodel-method)                        : [method]
- [**clearVariables**](#45-the-clearvariables-method)                : [method]
- [**setDefaultModel**](#46-the-setdefaultmodel-method)              : [method]
- [**getDefaultLinearModel**](#47-the-getdefaultlinearmodel-method)  : [method]
- [**getStateVariables**](#48-the-getstatevariables-method)          : [method]
- [**getFlowVariables**](#49-the-getflowvariables-method)            : [method]
- [**getSensorMeasurements**](#410-the-getsensormeasurements-method) : [method]
- [**getValveSignals**](#411-the-getvalvesignals-method)             : [method]
- [**getFaultSignals**](#412-the-getfaultsignals-method)             : [method]

---
### 4.1. The `Model` attribute
This attribute is used to define the system configurations. It is divided into the following subfields:

- **PhysicalParam**: used to define the system's physical structure.
  - **TankRadius**: must be real and greater than 0.
    ```
    tts.Model.PhysicalParam.TankRadius = 5;
    ```
  - **TankHeight**: must be real and greater than 0.
    ```
    tts.Model.PhysicalParam.TankHeight = 50;
    ```
  - **PipeRadius**: must be real, greater than 0, and less than TankRadius.
    ```
    tts.Model.PhysicalParam.PipeRadius = 0.6;
    ```
  - **TransPipeHeight**: must be real, greater than 0, and less than TankHeight.
    ```
    tts.Model.PhysicalParam.TransPipeHeight = 30;
    ```
  - **CorrectionTerm**: must be real and greater than 0.
    ```
    tts.Model.PhysicalParam.CorrectionTerm = 1;
    ```
  - **GravityConstant**: must be real and greater than 0.
    ```
    tts.Model.PhysicalParam.GravityConstant = 981;
    ```
  - **PumpMinFlow**: must be real and greater than or equal to 0.
    ```
    tts.Model.PhysicalParam.PumpMinFlow = 0;
    ```
  - **PumpMaxFlow**: must be real and greater than PumpMinFlow.
    ```
    tts.Model.PhysicalParam.PumpMaxFlow = 120;
    ```

- **ValveSettings**: used to define the system valve settings. It is divided into ten subfields, one per valve (Kp1, Kp2, Kp3, Ka, Kb, K13, K23, K1, K2, K3), and each one has the following settings:
  - **OperationMode**: must be set to ‘Open’ or ‘Closed’.
    ```
    tts.Model.ValveSettings.Kp1.OperationMode = 'Open';
    ```
  - **EnableControl**: must be set to a logical value (true or false).
    ```
    tts.Model.ValveSettings.Kp1.EnableControl = true;
    ```
  - **OpeningRate**: must be real and belong to the range [0,1].
    ```
    tts.Model.ValveSettings.Kp1.OpeningRate = 0.9;
    ```

- **FaultSettings**: used to define the system fault settings. It is divided into twenty-three subfields, one per fault (f1, f2, …, f23), and each one has the following settings:
  - **EnableSignal**: must be set to a logical value (true or false).
    ```
    tts.Model.FaultSettings.f1.EnableSignal = true;
    ```
  - **Magnitude**: must be real and belong to the range [0,1].
    ```
    tts.Model.FaultSettings.f1.Magnitude = 0.3;
    ```

- **ProcessNoise**: used to set the system process noise.
  - **EnableSignal**: must be set to a logical value (true or false).
    ```
    tts.Model.ProcessNoise.EnableSignal = true;
    ```
  - **Magnitude**: must be a row or a column vector with three real and finite elements ([h1 h2 h3]).
    ```
    tts.Model.ProcessNoise.Magnitude = [-0.05 0.06 -0.02];
    ```
    
- **MeasurementNoise**: used to set the system process noise.
  - **EnableSignal**: must be set to a logical value (true or false).
    ```
    tts.Model.MeasurementNoise.EnableSignal = true;
    ```
  - **Magnitude**: must be a row or a column vector with thirteen real and finite elements ([h1, h2, h3, Q1in, Q2in, Q3in, Qa, Qb, Q13, Q23, Q1, Q2, Q3]).  
    ```
    tts.Model.MeasurementNoise.Magnitude = [0.26 -0.12 -0.18 0.39 -0.66 -0.96 0.81 0.71 -0.42 0.68 0.44 0.61 -0.45];
    ```
    
- **InitialCondition**: used to define the system's initial condition and must be filled with a row vector of three elements.
    ```
    tts.Model.InitialCondition = [40 25 20];
    ```
---
### 4.2. The `simulateModel()` method
This method simulates the dynamic behavior of the three-tank system.
```
[y,x,q] = tts.simulateModel('Qp1',VALUE1,'Qp2',VALUE2,'Qp3',VALUE3,'Tspan',VALUE4);
```
> [!IMPORTANT]
> Sim3Tanks uses the ode45 solver to solve the system differential equations numerically, and it is highly recommended to use simulation time increment as Tspan.

---
### 4.3. The `displayFields()` method
This method does not have an input argument. It displays all fields and subfields of an object on the command line.
```
tts.displayFields();
```

---
### 4.4. The `clearModel()` method
This method does not have an input argument. It clears all variables and restores an object's settings.
```
tts.clearModel();
```

---
### 4.5. The `clearVariables()` method
This method does not have an input argument. It clears all state variables, valve, fault, flow signals, and sensor measurement data.
```
tts.clearVariables();
```

---
### 4.6. The `setDefaultModel()` method
This method does not have an input argument. It configures a Sim3Tanks object to the default model.
```
tts.setDefaultModel();
```
<img src="/assets/images/default_scenario.jpg">

---
### 4.7. The `getDefaultLinearModel()` method
This method returns a linear model of the default scenario.
```
[SYS,OP] = tts.getDefaultLinearModel(x1op,METHOD,TSPAN);
```

Input arguments: 
- `x1op>0` (mandatory): define the operating point of T1. The remaining variables are found as follows:
> x2op = x1op;
> 
> x3op = (4/5)*x1op;
>
> u1op = (Beta/Qp)*sqrt(x1op/5);
> 
> u2op = u1op;
> 
> Q13op = Beta*sign(x1op - x3op)*sqrt(abs(x1op - x3op));
> 
> Q23op = Beta*sign(x2op - x3op)*sqrt(abs(x2op - x3op));
>
> Q3op  = Beta*sqrt(x3op);
>
> x_op = [x1op; x2op; x3op];
> 
> u_op = [u1op; u2op];
> 
> y_op = [x1op; x2op; Q13op; Q23op; Q3op];

- `METHOD`(optional): define the discretization method. The following options are valid:
  - 'zoh';
  - 'foh';
  - 'impulse';
  - 'tustin';
  - 'matched';
  - 'euler';
    
- `TSPAN`(optional): define the sampling time of the discretization method. If `METHOD` is passed as input, then `TSPAN` becomes mandatory.

> [!NOTE]
> A continuous model is returned if `METHOD` and `TSPAN` are omitted.

---
### 4.8. The `getStateVariables()` method
This method does not have an input argument. It returns a data table with the values of the state variables. 
```
tts.getStateVariables();
```

---
### 4.9. The `getFlowVariables()` method
This method does not have an input argument. It returns a data table with the values of the flow variables.
```
tts.getFlowVariables();
```

---
### 4.10. The `getSensorMeasurements()` method
This method does not have an input argument. It returns a data table with the values of the measured variables.
```
tts.getSensorMeasurements();
```

---
### 4.11. The `getValveSignals()` method
This method does not have an input argument. It returns a data table with the values of the valve signals.
```
tts.getValveSignals();
```

---
### 4.12. The `getFaultSignals()` method
This method does not have an input argument. It returns a data table with the values of the fault signals.
```
tts.getFaultSignals();
```

## 5. Contributions
Contributions are welcome! Please follow these steps:

1. Fork this repository.
2. Create a branch with your feature:
```
git checkout -b my-feature
```
3. Commit your changes:
```
git commit -m 'feat: add my feature to do something'
```
4. Push to the branch:
```
git push origin my-feature
```

5. Open a Pull Request.

## 6. Citation
If this project has helped you in your research, please consider citing:

```
@article{farias2018sim3tanks,
    title={Sim3Tanks: A benchmark model simulator for process control and monitoring},
    author={Farias, Arllem O. and Queiroz, Gabriel Alisson C. and Bessa, Iury V. and Medeiros, Renan Landau P. and Cordeiro, Lucas C. and Palhares, Reinaldo M.},
    journal={IEEE Access},
    volume={6},
    pages={62234--62254},
    year={2018},
    publisher={IEEE},
    doi={10.1109/ACCESS.2018.2874752}
}
```

## 7. License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
