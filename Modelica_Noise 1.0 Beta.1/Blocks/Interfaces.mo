within Modelica_Noise.Blocks;
package Interfaces "Collection of interface definitions for noise blocks"
  extends Modelica.Icons.InterfacesPackage;

  partial block PartialNoise "Partial noise generator"
    import generator = Modelica_Noise.Math.Random.Generators.Xorshift128plus;
    import Modelica_Noise.Math.Random.Utilities.impureRandomInteger;
    extends Modelica.Blocks.Interfaces.SO;

    // Main dialog menu
    parameter Modelica.SIunits.Period samplePeriod(start=0.01)
      "Period for sampling the raw random numbers"
      annotation(Dialog(enable=enableNoise));

    // Advanced dialog menu: Noise generation
    parameter Boolean enableNoise = true
      "=true: y = noise, otherwise y = y_off"
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group="Noise generation"));
    parameter Real y_off = 0.0
      "Output y = y_off if enableNoise=false (or time<startTime, see below)"
      annotation(Dialog(tab="Advanced",group="Noise generation"));

    // Advanced dialog menu: Initialization
    parameter Boolean useGlobalSeed = true
      "= true: use global seed, otherwise ignore it"
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
    parameter Boolean useAutomaticLocalSeed = true
      "= true: use automatic local seed, otherwise use fixedLocalSeed"
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
    parameter Integer fixedLocalSeed = 1 "Local seed (any Integer number)"
      annotation(Dialog(tab="Advanced",group = "Initialization",enable=enableNoise and not useAutomaticLocalSeed));
    parameter Modelica.SIunits.Time startTime = 0.0
      "Start time for sampling the raw random numbers"
      annotation(Dialog(tab="Advanced", group="Initialization",enable=enableNoise));

    // Generate the actually used local seed
    discrete Integer localSeed "The actual localSeed";
  equation
    when initial() then
      localSeed = if useAutomaticLocalSeed then impureRandomInteger(globalSeed.id_impure) else fixedLocalSeed;
    end when;

    // Retrieve values from outer global seed
  protected
    outer Modelica_Noise.Blocks.Noise.GlobalSeed globalSeed
      "Definition of global seed via inner/outer";
    parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
      "The global seed, which is atually used";
    parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise
      "= true if noise shall be generated, otherwise no noise";

    // Declare state and random number variables
    Integer state[generator.nState] "Internal state of random number generator";
    discrete Real r "Random number according to the desired distribution";
    discrete Real r_raw "Uniform random number in the range (0,1]";

  initial equation
     pre(state) = generator.initialState(localSeed, actualGlobalSeed);
     r_raw = generator.random(pre(state));

  equation
    // Draw random number at sample times
    when generateNoise and sample(startTime, samplePeriod) then
      (r_raw, state) = generator.random(pre(state));
    end when;

    // Generate noise if requested
    y = if not generateNoise or time < startTime then y_off else r;

      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
          Polygon(
            points={{-76,90},{-84,68},{-68,68},{-76,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
          Line(points={{-86,-14},{72,-14}},
                                        color={192,192,192}),
          Polygon(
            points={{94,-14},{72,-6},{72,-22},{94,-14}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(visible = enableNoise,
             points={{-76,-19},{-62,-19},{-62,-3},{-54,-3},{-54,-51},{-46,-51},{-46,
                -29},{-38,-29},{-38,55},{-30,55},{-30,23},{-30,23},{-30,-37},{-20,
                -37},{-20,-19},{-10,-19},{-10,-47},{0,-47},{0,35},{6,35},{6,49},{12,
                49},{12,-7},{22,-7},{22,5},{28,5},{28,-25},{38,-25},{38,47},{48,47},
                {48,13},{56,13},{56,-53},{66,-53}}),
          Text(
            extent={{-150,-110},{150,-150}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            textString="%samplePeriod s"),
          Line(visible=not enableNoise,
            points={{-76,48},{72,48}}),
          Text(visible=not enableNoise,
            extent={{-75,42},{95,2}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            textString="%y_off"),
          Text(visible=enableNoise and not useAutomaticLocalSeed,
            extent={{-92,20},{98,-22}},
            lineColor={238,46,47},
            textString="%fixedLocalSeed")}),
      Documentation(info="<html>
<p>
Partial base class of noise generators defining the common features
of noise blocks.
</p>
</html>",   revisions="<html>
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
</html>"));
  end PartialNoise;
  annotation (Documentation(info="<html>
<p>This package provides general interface definitions for noise blocks.</p>
</html>"));
end Interfaces;
