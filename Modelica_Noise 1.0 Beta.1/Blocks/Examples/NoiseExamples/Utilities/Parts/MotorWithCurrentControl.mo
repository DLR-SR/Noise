within Modelica_Noise.Blocks.Examples.NoiseExamples.Utilities.Parts;
model MotorWithCurrentControl
  "Synchronous induction machine with current controller and measurement noise"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";

  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
    smpm(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lszero=smpmData.Lszero,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    wMechanical(fixed=true),
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    phiMechanical(fixed=true),
    TsOperational=293.15,
    alpha20s=smpmData.alpha20s,
    TrOperational=293.15,
    alpha20r=smpmData.alpha20r)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurrent(final m=m)
    annotation (Placement(transformation(
        origin={-10,50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
    annotation (Placement(transformation(extent={{-10,80},{-30,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(
        origin={-50,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.CurrentController currentController(p=smpm.p)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,-10})));
  Modelica.Electrical.Analog.Basic.Ground groundM
    annotation (Placement(transformation(
        origin={-80,-28},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y") annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p)
    annotation (Placement(transformation(
        origin={30,-50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,0})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,-20})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-2})));
  Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-10})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        origin={-10,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.29)
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false) "Data for motor"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Modelica.Blocks.Sources.Constant id(k=0)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Modelica.Blocks.Interfaces.RealInput iq_rms1 annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}),iconTransformation(extent={{-140,40},
            {-100,80}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
    "Right flange of shaft"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi
    "Absolute angle of flange as output signal" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={110,80}), iconTransformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Interfaces.RealOutput phi_motor(unit="rad", displayUnit="deg")
    "Rotational position"
    annotation (Placement(transformation(extent={{60,20},{80,40}}),
        iconTransformation(extent={{90,40},{90,40}})));
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s") "Rotational speed"
    annotation (Placement(transformation(extent={{60,0},{80,20}}),
        iconTransformation(extent={{90,40},{90,40}})));
  Modelica.Blocks.Math.Add addNoise
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Noise.UniformNoise uniformNoise(
    samplePeriod=1/200,
    y_min=-0.01,
    y_max=0.01) annotation (Placement(transformation(extent={{26,76},{46,96}})));
equation
  connect(star.pin_n, ground.p) annotation (Line(points={{-30,90},{-40,90}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
        points={{36,-40},{36,-30},{-16,-30},{-16,-40}}, color={0,0,255}));
  connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation (Line(
        points={{24,-40},{-4,-40}}, color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{-16,-36},{-16,-40}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{-4,-36},{-4,-40}},
      color={0,0,255}));
  connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{0,-50},{20,-50}}));
  connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
      points={{-10,60},{-10,90}},
      color={0,0,255}));
  connect(angleSensor.flange, rotorDisplacementAngle.flange) annotation (Line(
      points={{10,-10},{10,-50},{20,-50}}));
  connect(angleSensor.phi, currentController.phi) annotation (Line(
      points={{10,11},{10,30},{-40,30},{-40,38}},
      color={0,0,127}));
  connect(groundM.p, terminalBox.starpoint) annotation (Line(
      points={{-70,-28},{-70,-34},{-19,-34}},
      color={0,0,255}));
  connect(smpm.flange, torqueSensor.flange_a) annotation (Line(
      points={{0,-50},{10,-50},{10,-20},{40,-20}}));
  connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply) annotation (
      Line(
      points={{-20,-10},{-10,-10},{-10,-34}},
      color={0,0,255}));
  connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
      points={{-50,-10},{-40,-10}},
      color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(
      points={{-70,-10},{-70,-28}},
      color={0,0,255}));
  connect(currentController.y, signalCurrent.i) annotation (Line(
      points={{-29,50},{-24,50},{-17,50}},
      color={0,0,127}));
  connect(speedSensor.flange, smpm.flange) annotation (Line(
      points={{30,-12},{30,-20},{10,-20},{10,-50},{0,-50}}));
  connect(torqueSensor.flange_b, inertiaLoad.flange_a) annotation (Line(
      points={{60,-20},{70,-20}}));
  connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p) annotation (
     Line(
      points={{-10,40},{-10,20}},
      color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p)
    annotation (Line(
      points={{-10,0},{-10,-10},{-20,-10}},
      color={0,0,255}));
  connect(id.y, currentController.id_rms) annotation (Line(
      points={{-69,70},{-60,70},{-60,56},{-52,56}},
      color={0,0,127}));
  connect(currentController.iq_rms, iq_rms1) annotation (Line(
      points={{-52,44},{-100,44},{-100,60},{-120,60}},
      color={0,0,127}));
  connect(inertiaLoad.flange_b, flange) annotation (Line(
      points={{90,-20},{90,0},{100,0}}));
  connect(angleSensor.phi, addNoise.u2) annotation (Line(
      points={{10,11},{10,30},{50,30},{50,74},{58,74}},
      color={0,0,127}));
  connect(addNoise.y, phi) annotation (Line(
      points={{81,80},{110,80}},
      color={0,0,127}));
  connect(uniformNoise.y, addNoise.u1) annotation (Line(
      points={{47,86},{58,86}},
      color={0,0,127}));
  connect(speedSensor.w, w) annotation (Line(points={{30,9},{30,10},{70,10}},
                color={0,0,127}));
  connect(angleSensor.phi, phi_motor) annotation (Line(points={{10,11},{10,30},{70,30}},
                                    color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
A synchronous induction machine with permanent magnets, current controller and
measurement noise of &plusmn;0.01 rad accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are converted to three-phase currents,
and fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.
</p>

<p>
Default machine parameters of model
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>
are used.
</p>

<p>
This motor is used in the
<a href=\"modelica://Modelica_Noise.Blocks.Examples.NoiseExamples.ActuatorWithNoise\">Examples.NoiseExamples.ActuatorWithNoise</a>
actuator example
</p>
</html>", revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{40,50},{-100,100}},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),           Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}));
end MotorWithCurrentControl;
