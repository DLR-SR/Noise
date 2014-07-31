within Noise;
block TimeBasedNoise
  "A noise generator based on the simulation time (without events)"
  extends Modelica.Blocks.Interfaces.SO;

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// We require an inner globalSeed
  outer GlobalSeed globalSeed;

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Define a seeding function (this is hidden from the user)

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Define distribution (implicitly contains the default random number generator)

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Call the distribution function to fill the buffer

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Define interpolation

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Call the interpolation with the buffer as input

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// The random number generator
// There is the general distinction between sampled and sample-free methods
// This switches two RNG selectors for convenience
// It also (de)activates sampling later on...
// The internal functions are used later in redeclarations
public
  parameter Boolean useSampleBasedMethods =  false
    "Use a random number generator with sampling"
    annotation(Dialog(tab = "Advanced", group = "RNG: Random Number Generator. (This has influences on simulation speed and the quality of the random numbers.)"));
  replaceable function SampleBasedRNG =
      Noise.Generators.LinearCongruentialGenerator
    constrainedby Noise.Utilities.Interfaces.SampleBasedRNG
    "Choice of sample based methods for RNG"
    annotation(choicesAllMatching=true, Dialog(tab = "Advanced", group = "RNG: Random Number Generator. (This has influences on simulation speed and the quality of the random numbers.)", enable=useSampleBasedMethods),
    Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>", info="<html>
<p>This replaceable model is used, if the useSampleBased switch is set to true. You can redeclare any SampleBased RNG from here: <a href=\"Noise.RNG.SampleBased\">Noise.RNG.SampleBased</a>.</p>
</html>"));
  replaceable function SampleFreeRNG =  Noise.Generators.SampleFree.RNG_DIRCS
    constrainedby Noise.Utilities.Interfaces.SampleFreeRNG
    "Choice of sample free methods for RNG"
    annotation(choicesAllMatching=true, Dialog(tab = "Advanced", group = "RNG: Random Number Generator. (This has influences on simulation speed and the quality of the random numbers.)",enable=not useSampleBasedMethods),
    Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>", info="<html>
<p>This replaceable model is used, if the useSampleBased switch is set to false. You can redeclare any SampleFree RNG from here: <a href=\"Noise.RNG.SampleFree\">Noise.RNG.SampleFree</a>.</p>
</html>"));
protected
  function SampleBasedRNG0 = SampleBasedRNG;
  function SampleFreeRNG0 =  SampleFreeRNG;

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// The probability density function
// We have to keep going with two lines (sample based / sample free) because there
// is no such thing as "conditional redeclaration".
// The internal functions are used later in redeclarations
public
  replaceable function PDF = Noise.Distributions.Uniform
    constrainedby Noise.Utilities.Interfaces.Distribution
    "Choice of various PDFs"
    annotation(choicesAllMatching=true, Dialog(tab = "Advanced", group = "PDF: Probability Density Function. (This specifies the distribution of the generated random values.)"),
    Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>", info="<html>
<p>This replaceable function is used to design the distribution of values generated by the PRNG block. You can redeclare any function from here: <a href=\"Noise.PDF\">Noise.PDF</a>.</p>
</html>"));
protected
  function SampleBasedPDF0 = PDF(redeclare function RNG = SampleBasedRNG0);
  function SampleFreePDF0 =  PDF(redeclare function RNG = SampleFreeRNG0);

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// The spectral density function
// There is an additional switch to activate infinite frequency
// This has to be handled differently in the calls to the function
// For convenience, we use a third internal function here
public
  parameter Boolean infiniteFreq =  false
    "Use unfiltered white noise with infinite frequency"
    annotation(Dialog(tab = "Advanced", group = "PSD: Power Spectral Density. (This specifies the frequency characteristics of the random signal.)", enable = not useSampleBasedMethods));
protected
  parameter Modelica.SIunits.Frequency freq = 0.5*1/samplePeriod
    "Cut-off frequency. Period = 1/(2*freq)"
    annotation(Dialog(tab = "Advanced", group = "PSD: Power Spectral Density. (This specifies the frequency characteristics of the random signal.)", enable = not infiniteFreq or useSampleBasedMethods));
public
  replaceable function PSD = Noise.Filters.SampleAndHold
                                                      constrainedby
    Noise.Utilities.Interfaces.Filter
    "Choice of various filters for the frequency domain"
    annotation(choicesAllMatching=true, Dialog(tab = "Advanced", group = "PSD: Power Spectral Density. (This specifies the frequency characteristics of the random signal.)", enable = not infiniteFreq or useSampleBasedMethods),
    Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>", info="<html>
<p>This replaceable function is used to design the distribution of frequencies generated by the PRNG block. You can redeclare any function from here: <a href=\"Noise.PSD\">Noise.PSD</a>.</p>
</html>"));
protected
  function SampleBasedPSD0 =
    PSD (                    redeclare function PDF=SampleBasedPDF0);
  function SampleFreePSD0 =
    PSD (                    redeclare function PDF=SampleFreePDF0);
  function InfiniteFreqPSD0 =
    Noise.Filters.SampleAndHold (
                             redeclare function PDF=SampleFreePDF0);

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Set up the sampling rate of the block
public
  parameter Modelica.SIunits.Time startTime = 0 "Start time of the sampling"
    annotation(Dialog(group = "(Pseudo-) Sampling"));
  parameter Modelica.SIunits.Time samplePeriod = 0.01
    "Period for (pseudo-)sampling the raw random numbers"
    annotation(Dialog(group = "(Pseudo-) Sampling"));

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Set up the enable/disable flags
public
  parameter Boolean enable = true "Whether or not to enable this block"
    annotation(Dialog(group = "Enable/Disable"),choices(checkBox=true));
  parameter Real y_off = 0 "Value to output, when disabled"
    annotation(Dialog(group = "Enable/Disable"));

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// The seeding function
  replaceable function Seed = Noise.Seed.MRG (    real_seed=0.0) constrainedby
    Noise.Utilities.Interfaces.Seed "Choice of the seeding function"
    annotation(choicesAllMatching=true, Dialog(tab = "Advanced", group = "Seed (This specifies how local and global seed should be combined and the intial state vector should be filled.)"),
    Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>", info="<html>
<p>This replaceable function is used to seed the RNG used in the PRNG block. You can redeclare any function from here: <a href=\"Noise.Seed\">Noise.Seed</a>.</p>
</html>"));

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Initialize the RNG state
// The state can be more than one-sized, because there are RNG
// methods other than the LCG out there, which use more states.
// The parameter state_size should be set, so that it is big enough to hold the maximum.
// This should not influence the speed too much, because the variables are just passed around.
protected
  parameter Integer state_size = 33
    "The number of internal (sample-based) RNG states";
  Integer state[state_size] "The internal state of the (sample-based) RNG";
  Real t_last "The last time a random number was generated";
public
  parameter Integer localSeed = 123456789
    "The local seed to the RNG initialization" annotation(Dialog(group = "Initialization"),choices(checkBox=true));
  parameter Boolean useGlobalSeed = true
    "Combine local seed value with global seed" annotation(choices(checkBox=true),Dialog(group = "Initialization"));
  final parameter Integer seed=if useGlobalSeed then
      Noise.Utilities.Auxiliary.combineSeedLCG(localSeed, globalSeed.seed)
       else localSeed;
initial equation
  if useSampleBasedMethods then
    pre(state)  = Seed(local_seed=localSeed, global_seed=if useGlobalSeed then globalSeed.seed else 0, n=state_size, real_seed=0.0);
    pre(t_last) = floor(time/DT)*DT;
  end if;

//
//
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Generate random numbers
public
  final parameter Real DT = 1/(2*freq)
    "The period of of the random signal (1/(2*DT) = cut-off frequency)";
public
  output Real y_hold
    "The random number held for the period DT. Use this for checking the PSD methods.";
protected
  discrete Real dummy1;
  discrete Real dummy2;
equation

  // Disable the block, if requested
  if not enable then
    y=y_off;
    y_hold=y_off;
    t_last=0;
    dummy1=0;
    dummy2=0;
    state = zeros(state_size);

  // Go for the actual random numbers
  else

    // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
    // Sample-based methods will sample the time and advance the internal state each time
    // The PSD method will be evaluated continuously
    if useSampleBasedMethods then
      when sample(0,DT) then
        t_last = time;
        (dummy1,dummy2,state) = SampleBasedPSD0( t=time, dt=DT, t_last=pre(t_last), states_in=pre(state));
        //Modelica.Utilities.Streams.print("muh" + String(time));
      end when;
      (y_hold,y)              = SampleBasedPSD0( t=time, dt=DT, t_last=    t_last,  states_in=    state);

    // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
    // Sample-free methods will continuously produce random numbers
    // The internal state is only used for seeding
    else

      // Dummy variables from the sampled implementation are meaningless
      when initial() then
        dummy1 = 0;
        dummy2=0;
      end when;

      // Fill the state with a seed and make sure, the t_last is never smaller than time
      state  = Seed(local_seed=localSeed, global_seed=if useGlobalSeed then globalSeed.seed else 0, n=state_size, real_seed=0.0);
      t_last = noEvent(2*abs(time)+1);

      // Generate a held output value. This might actually have larger steps than DT!
      // y_hold           = SampleFreePSD0(  t=noEvent(floor(time/DT)*DT), dt=DT, t_last=    t_last,  states_in=    state);

      // Use direct continuous PSD for infiniteFrequency
      if infiniteFreq then
        (y_hold,y)              = InfiniteFreqPSD0(t=time,                       dt=0,  t_last=    t_last,  states_in=    state);
      else
        (y_hold,y)              = SampleFreePSD0(  t=time,                       dt=DT, t_last=    t_last,  states_in=    state);
      end if;
    end if;

  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Rectangle(
          extent={{-80,-10},{-100,10}},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,-10},{-80,58}},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-20,-78},{-40,10}},
          lineThickness=0.5,
          fillColor={50,50,50},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-40,-60},{-60,10}},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{60,-62},{40,8}},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{40,-10},{20,88}},
          lineThickness=0.5,
          fillColor={238,238,238},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{0,-10},{-20,76}},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-10},{0,58}},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{80,-10},{60,76}},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{100,-10},{80,56}},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-94,-2},{-74,18},{-56,-42},{-30,-68},{-14,38},{6,12},{26,58},
              {46,-42},{68,38},{96,-2}},
          color={255,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier)}),
             defaultComponentName = "prng",
    Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>",
        info="<html>
<p>This block is used to generate stochastic signals based on pseudo-random numbers.</p>
<p>By default the block generates a discrete signal changing at the frequency of 100Hz with uniformly distributed random numbers between 0 and 1.</p>
<p>To change the default behavior, you can choose a different random number generator, a different probability distribution or a different power spectral density.</p>
<h4><span style=\"color:#008000\">Choosing the random number generator (RNG)</span></h4>
<p>Determine the function used to generate the pseudo-random numbers. All of these functions are designed in such a way that they return a pseudo-random number between 0 and 1 with an approximate uniform distribution.</p>
<p>There are two types of random number generators: Sample-Based RNGs and Sample Free RNGs.</p>
<ol>
<li>Sample-Based RNGs are based on a discrete state value that is changed at certain sample times. Hence these generators cause many time events.</li>
<li>Sample-Free RNGs are based on the continuous time signal and transform it into a pseudo-random signal. These generators do not cause events.</li>
</ol>
<p>Whether to better use sample-free or sample-based generators is dependent on the total system at hand and cannot be generically answered. If, however, the resulting signal shall be continuous (due to applying a PSD) then we propose to use sample-free RNGs.</p>
<h4><span style=\"color:#008000\">Choosing the probability distribution function (PDF)</span></h4>
<p>The pseudo-random numbers are per se uniformly distributed between 0 and 1. To change the distribution of the pseudo-random number generators you can choose an appropriate function.</p>
<p>Each function may have its individual parameters for defining the characteristics of the corresponding PDF. </p>
<h4><span style=\"color:#008000\">Choosing the power spectral density (PSD)</span></h4>
<p>The power spectral density function defines the spectral characteristics of the output signal. In many cases it is used to generate a continuous pseudo-random signal by interpolation or filtering with certain charactistics w.r.t frequency and variance.</p>
<p>Many Ready-to-use PSD are offered. The advantage to use a PDF to a classic PT1-element is that no continuous time states are added to the system. The PSD implementation is based on discrete convolution and the use of a PSD may change the characteristics of the PDF. For more information see the reference included below.</p>
<h4><span style=\"color:#008000\">Determine the sample frequency</span></h4>
<p>The sample frequency determines the frequency of changes of the pseudo-random numbers. </p>
<p>For sample-free generators it is possible to apply an infinite frequency. Here the change is only limited by the numerical precision and determined by the step-size control of the applied ODE-solver. When using infinite frequency, PSDs cannot be meaningfully applied anymore.</p>
<p>The sample start time is only relevant if a sample-based generator is used.</p>
<h4><span style=\"color:#008000\">Enable/Disable the block</span></h4>
<p>The block can be disabled by the Boolean flag enable. A constant output value is then used instead.</p>
<h4><span style=\"color:#008000\">Determine the seed values</span></h4>
<p>All RNGs need to be seeded. With the same seed value an RNG will generate the same signal every simulation run. If you want to do multiple simulation runs for stochastic analysis, you have to determine a different seed for each run.</p>
<p>The seed value is determined by a local seed value. This value may be combined with a global seed value from the outer model &QUOT;globalSeed&QUOT;. </p>
<p>The use of the local seed value is to make different instances of the PRNG block to generate different (uncorrelated) random signals. The use of the global seed value is to determine a new seeding for the complete system.</p>
<h4><span style=\"color:#008000\">Background Information</span></h4>
<p>To get better understanding, you may look at the examples or refer to the paper:</p>
<p>Kl&ouml;ckner, A., van der Linden, F., &AMP; Zimmer, D. (2014), <a href=\"http://www.ep.liu.se/ecp/096/087/ecp14096087.pdf\">Noise Generation for Continuous System Simulation</a>.<br/>In <i>Proceedings of the 10th International Modelica Conference</i>, Lund, Sweden. </p>
<p>This publication can also be cited when you want to refer to this library.</p>
</html>"));
end TimeBasedNoise;