within Modelica_Noise.Blocks.Examples.NoiseExamples.Utilities.Parts;
model Controller "Simple position controller for actuator"

  Modelica.Blocks.Continuous.PI speed_PI(k=10, T=5e-2,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Feedback speedFeedback
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Continuous.Derivative positionToSpeed(initType=Modelica.Blocks.Types.Init.InitialOutput,
      T=0.01)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Interfaces.RealInput positionMeasured
    "Position signal of motor"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput positionReference "Reference position"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput y1 "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Continuous.PI position_PI(T=5e-1, k=3,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Math.Feedback positionFeedback
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Blocks.Continuous.FirstOrder busdelay(T=1e-3, initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(speedFeedback.y, speed_PI.u) annotation (Line(
      points={{-1,0},{14,0},{18,0}},
      color={0,0,127}));
  connect(positionFeedback.u2, positionToSpeed.u) annotation (Line(
      points={{-80,52},{-80,-60},{-62,-60}},
      color={0,0,127}));
  connect(positionReference, positionFeedback.u1) annotation (Line(
      points={{-120,60},{-88,60}},
      color={0,0,127}));
  connect(positionFeedback.y, position_PI.u) annotation (Line(
      points={{-71,60},{-62,60}},
      color={0,0,127}));
  connect(position_PI.y, speedFeedback.u1) annotation (Line(
      points={{-39,60},{-30,60},{-30,0},{-18,0}},
      color={0,0,127}));
  connect(speed_PI.y, busdelay.u) annotation (Line(
      points={{41,0},{58,0}},
      color={0,0,127}));
  connect(y1, busdelay.y) annotation (Line(
      points={{110,0},{81,0}},
      color={0,0,127}));
  connect(positionMeasured, positionToSpeed.u) annotation (Line(
      points={{-120,-60},{-62,-60}},
      color={0,0,127}));
  connect(positionToSpeed.y, speedFeedback.u2) annotation (Line(
      points={{-39,-60},{-10,-60},{-10,-8}},
      color={0,0,127}));
  annotation ( Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,50},{40,-30}},
          lineColor={0,0,255},
          textString="PI"),             Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),
    Documentation(revisions="<html>
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
</html>", info="<html>
<p>
A simple position controller for a drive system.
This controller is used in the
<a href=\"modelica://Modelica_Noise.Blocks.Examples.NoiseExamples.ActuatorWithNoise\">Examples.NoiseExamples.ActuatorWithNoise</a>
actuator example
</p>
</html>"));
end Controller;
