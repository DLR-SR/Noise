within ;
package Modelica_Noise "Modelica_Noise version 1.0-Beta.1 (Library for random numbers and noise signals; now included in the Modelica Standard Library 3.2.2)"
  extends Modelica.Icons.Package;

  extends Modelica.Icons.ObsoleteModel;





  annotation(preferredView="info",
             version =     "1.0 Beta.1",
             versionDate =  "2015-06-22",
             versionBuild = 0,
             uses(Modelica(version="3.2.1")),
  Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This library contains blocks to generate reproducible noise, as well as various utility functions. These models are now part of the Modelica Standard Library (version 3.2.2).</span></p>
<h4><span style=\"color: #ff0000\">The Modelica_Noise library is obsolete and will be maintained as part of the modelica standard library (from MSL version 3.2.2). </span></h4>
<h4>If your tool supports MSL3.2.2</h4>
<p>Use the noise models provided by the MSL. This package is in this case not needed. </p>
<p>For more advanced noise models (more distributions, continuous, high performance noise), you might want to look at <a href=\"https://github.com/DLR-SR/AdvancedNoise\">AdvancedNoise</a>.</p>
<h4>If your tool supports MSL 3.2.1 or lower</h4>
<p>Use the master branch: <a href=\"https://github.com/DLR-SR/Noise/tree/master\">https://github.com/DLR-SR/Noise/tree/master</a>. This is the version you are currently working with, so no need to update!</p>
<p><span style=\"font-family: MS Shell Dlg 2;\">For more advanced noise models (more distributions, continuous, high performance noise), you might want to look at the MSL321 branch of AdvancedNoise: <a href=\"https://github.com/DLR-SR/AdvancedNoise/tree/MSL321\">https://github.com/DLR-SR/AdvancedNoise/tree/MSL321</a>. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Note that these versions will not be further maintained.</span></p>
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
</html>"));
end Modelica_Noise;
