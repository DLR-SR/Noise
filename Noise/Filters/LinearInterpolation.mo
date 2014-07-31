within Noise.Filters;
function LinearInterpolation "Linear interpolation between the noise samples"
  extends ArbitraryInterpolation(kernel = Kernels.Linear, n=1);
  annotation (Icon(graphics={Line(
          points={{-60,-60},{60,60}},
          color={255,0,0}),
        Ellipse(
          extent={{-64,-56},{-56,-64}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{56,64},{64,56}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"));
end LinearInterpolation;