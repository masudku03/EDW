# EDW
The code for the article "Effective dose window for containing tumor burden under tolerable level".

Published version:

Preprint version: https://www.biorxiv.org/content/10.1101/2022.03.28.486150v1.abstract


Figure Names -------------- Relevant code

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

The scripts "fitting_patient*.m" uses cost function (***Cost.m), likelihood function (ProfLike.m), and Fisher information matrix (MiniFisher.m) from https://github.com/epimath/param-estimation-SIR/tree/master/Matlab.

If you use any part of this code, you are encouraged to cite the relevant article mentioned above.
