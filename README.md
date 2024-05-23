# Sim3Tanks: A Benchmark Model Simulator for Process Control and Monitoring
Sim3Tanks is suitable for studying and developing process control, fault detection and diagnosis, and fault-tolerant control strategies for nonlinear multivariable systems. This new release was developed in the MATLAB environment, version 9.11.0 (2021b), and can be used via command-line script <`file.m`>. Future releases will include versions for using the simulator via Simulink block diagram <`file.slx`> and graphical user interface <`file.fig`>.

The original paper that publishes the simulator can be accessed at <http://dx.doi.org/10.1109/ACCESS.2018.2874752>.

## Sim3Tanks Plant
Sim3Tanks simulates the dynamic behavior of the following plant:

<img src="/assets/images/three_tank_system.jpg">

## Sim3Tanks Object
To create a Sim3Tanks object it is necessary to use the function **createSim3Tanks()** as shown below:

- `objSim3Tanks = createSim3Tanks();`

From now on, **objSim3Tanks** has the following fields and methods:

>**Model**: `objSim3Tanks.Model.(***)`
> in this field the settings and the values of the parameters are defined.
>> **PhysicalParam**: `objSim3Tanks.Model.PhysicalParam.(***)`
>>> **TankRadius**: must be real and greater than 0.
>>> **TankHeight**: must be real and greater than 0.
>>> **PipeRadius**: must be real and greater than 0 and less than TankRadius.
>>> **TransPipeHeight**: must be real and greater than 0 and less than TankHeight.
>>> **CorrectionTerm**: must be real and greater than 0.
>>> **GravityConstant**: must be real and greater than 0.
>>> **PumpMinFlow**: must be real and greater than or equal to 0.
>>> **PumpMaxFlow**: must be real and greater than PumpMinFlow.
>>
>> **ValveSettings**: `objSim3Tanks.Model.ValveSettings.(***)`
>>> **K**: {for K = Kp1, Kp2, Kp3, Ka, Kb, K13, K23, K1, K2, K3}
>>>> **OperationMode**: must be set to 'Open' or 'Closed'.
>>>> **EnableControl**: must be set to a logical value (true or false).
>>>> **OpeningRate**: must be real and belong to the range [0,1].
>>
>> **FaultSettings**: `objSim3Tanks.Model.FaultSettings.(***)`
>>> **f**: {for f = f1, f2, ... , f23}
>>>> **EnableSignal**: must be set to a logical value (true or false).
>>>> **Magnitude**: must be real and belong to the range [0,1].
>>
>> **ProcessNoise**: `objSim3Tanks.Model.ProcessNoise.(***)`
>>> **EnableSignal**: must be set to a logical value (true or false).
>>> **Magnitude**: must be a row or column vector with three real and finite elements (w = [h1 h2 h3]).
>>
>> **MeasurementNoise**: `objSim3Tanks.Model.MeasurementNoise.(***)`
>>> **EnableSignal**: must be set to a logical value (true or false).
>>> **Magnitude**: must be a row or column vector with thirteen real and finite elements (v = [h1 h2 h3 Q1in Q2in Q3in Qa Qb Q13 Q23 Q1 Q2 Q3]).
>>
>> **InitialCondition**: `objSim3Tanks.Model.InitialCondition = [40 25 20]`
>>  This field must be filled with a row vector of three elements (x0 = [h1 h2 h3]).
>>
> **simulateModel()**: this method simulates the dynamic behavior of the three-tank system.
> - > `[y,x,q] = objSim3Tanks.simulateModel(Qp1,Qp2,Qp3,Tspan)`
>>
> **resetModel()**: this function restores all variables and settings.
> - > `objSim3Tanks.resetModel()`
>>
> **resetVariables()**: this method resets all state variables, valve, fault and flow signals, and the measurement data of the sensors.
> - > `objSim3Tanks.resetVariables()`
>>
> **setDefaultModel()**: this method configures a Sim3Tanks object to the default model.
> - > `objSim3Tanks.setDefaultModel()`
>>
> **getStates()**: this method returns a data table with the values of the state variables. 
> - > `X = objSim3Tanks.getStates()`
>>
> **getFlows()**: this method returns a data table with the values of the flow variables.
> - > `Q = objSim3Tanks.getFlows()`
>>
> **getMeasurements()**: this method returns a data table with the values of the measured variables.
> - > `Y = objSim3Tanks.getMeasurements()`
>>
> **getValves()**: this method returns a data table with the values of the valve signals.
> - > `K = objSim3Tanks.getValves()`
>>
> **getFaults()**: this method returns a data table with the values of the fault signals.
> - > `F = objSim3Tanks.getFaults()`

## Fault Symbols
The following table describes the faults modeled in Sim3Tanks.

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
| `f11` | Level sensor fault `h1`. |
| `f12` | Level sensor fault `h2`. |
| `f13` | Level sensor fault `h3`. |
| `f14` | Flow sensor fault `Q1in`. |
| `f15` | Flow sensor fault `Q2in`. |
| `f16` | Flow sensor fault `Q2in`. |
| `f17` | Flow sensor fault `Qa`. |
| `f18` | Flow sensor fault `Qb`. |
| `f19` | Flow sensor fault `Q13`. |
| `f20` | Flow sensor fault `Q23`. |
| `f21` | Flow sensor fault `Q1`. |
| `f22` | Flow sensor fault `Q2`. |
| `f23` | Flow sensor fault `Q3`. |
