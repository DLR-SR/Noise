**_The Modelica_Noise library is obsolete and will be maintained as part of the modelica standard library (from MSL version 3.2.2)._** 

## If your tool supports MSL 3.2.2 or higher
Use the noise models provided by the [Modelica Standard Library (MSL)](https://github.com/modelica/Modelica). This package is in this case not needed. 

For more advanced noise models (more distributions, continuous, high performance noise), you might want to look at [AdvancedNoise](https://github.com/DLR-SR/AdvancedNoise).

## If your tool supports MSL 3.2.1 or lower
Use the master branch: https://github.com/DLR-SR/Noise/tree/master. This is the version you are looking at.

For more advanced noise models (more distributions, continuous, high performance noise), you might want to look at the MSL321 branch of AdvancedNoise: https://github.com/DLR-SR/AdvancedNoise/tree/MSL321. 

Note that these versions will not be further maintained.


Modelica_Noise
=====

Modelica library for generating stochastic signals now included in the Modelica Standard Library. 

This library contains standard models for generating random numbers in Modelica. More advanced noise features building on this library can be found in the [AdvancedNoise](https://github.com/DLR-SR/AdvancedNoise) library.

The library contains the following elements:
- a standard sampled noise source using the xorshift random number generator suite
- some commonly used probability distributions
- some statistical analysis blocks

Main features of the elements provided are:
- statistical quality of the random numbers by using the xorshift suite
- reproducability of the random sequences by providing a global and a local seed
- versatility by replaceable probability distributions for the generated noise
- mathematically correct statistical properties by using standard procedures only

Potential applications of the provided elements are:
- correctly modeling sensor noise by using the provided distributions
- stochastic excitations such as turbulence by filtering band-limited white noise
- any other application by providing easy-to-use basic functions.

## Current release

Download  [Noise 1.0 Beta.1 (2015-09-07)](../../archive/v1.0-beta.1.zip)

## License

This Modelica package is free software and the use is completely at your own risk;
it can be redistributed and/or modified under the terms of the [Modelica License 2](https://modelica.org/licenses/ModelicaLicense2).


Copyright (C) 2015, **DLR** German Aerospace Center

## Development and contribution


The library is developed by the **DLR** German Aerospace Center contributors:

 - Andreas Klöckner
 - Franciscus van der Linden
 - Dirk Zimmer
 - Martin Otter
