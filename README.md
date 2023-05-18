# EDW
The code is for the article "Effective dose window for containing tumor burden under tolerable level".

Published version: https://doi.org/10.1038/s41540-023-00279-4

Preprint version: https://doi.org/10.1101/2022.03.28.486150

________________________________________________________________

Figure Names -------------- Relevant code
________________________________________________________________

fig07, Sfig04 -------------- AT.m

Sfig05 -------------- AT_Patient2.m

fig02 -------------- bifurcation.m

fig08 -------------- EDW.m

fig09 -------------- tolerableVolumePatient2.m

fig05, fig06, Sfig03_1, Sfig03_2, Sfig03_3 -------------- cmnd_ctrl.m

Sfig02 -------------- fitting_patient1.m

fig03 -------------- fitting_patient3.m, fitting_patient4.m, fitting_patient5.m	

Sfig01 -------------- fitting_patient2.m

fig03 -------------- fitting_patient6.m, fitting_patient7.m, fitting_patient8.m	

fig04 -------------- BasinOfAttraction.m
________________________________________________________________


The longitudinal LDH level data of the eight patients are available in the folder csvData. It worth mention that this data is inherited from https://doi.org/10.3390/cancers13040823. 

We would like to acknowledge the use of Cost function (***Cost.m), Likelihood function (ProfLike.m), and Fisher information matrix (MiniFisher.m) from https://github.com/epimath/param-estimation-SIR/tree/master/Matlab in our scripts "fitting_patient*.m". 

All the contents of this repository come under MIT license. Please refer to the "License" file for details. If you use any part of this code, you are encouraged to cite the relevant article mentioned above.
