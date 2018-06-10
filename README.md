Detect outlier hyperellipsoidal clusters using ENOF

# Introduction: 

1. Computationally efficient clustering algorithm: Hyperellipsoidal Clustering for Resource-Constrained En- vironments (HyCARCE). File "Synth.m" include a simple code that call the clustering function using normalized S1 dataset. Load the "SDataset.mat" first before running the code. Please make sure the expected format for input data is used to call HyCARCE. This code is a close implementation of [1]. Some loops are replaced with matrix calculations to increase the code execution in Matlab.
[1] "Masud Moshtaghi, Sutharshan Rajasegarar, Christopher Leckie, Shanika Karunasekera, "An Efficient Hyperellipsoidal Clustering Algorithm for Resource-Constrained Environments", Accepted in Pattern Recognition, March 2011"

2. Efficient outlier scoring mechanism for hyperellipsoidal clusters: Ellipsoidal Neighbourhood Outlier Factor (ENOF). The aim of ENOF is to identify the ellipsoids that are outlying relative to their close neighbourhood, with respect to the densities of the neighbourhood. In particular, an ellipsoid that belongs to a dense group of ellipsoids has a smaller outlier score than an ellipsoid that is far from this group of ellipsoids. This is a ratio between the average neighbourhood reachability density of the neighbours and the ellipsoids’ own neighbourhood reachability density. It can be observed that the ratio becomes 1 when an ellipsoid becomes comparable to its neighbouring ellipsoids. For the faraway ellipsoids from their neighbours, the ENOF becomes significantly higher than 1. In order to determine the anomalous clusters using ENOF scores, a Threshold is computed using the standard deviation of the ENOF scores SDENOF and a parameter z ∈ {1, 2, 3}, which determines the sensitivity of the detector. The clusters that have ENOF scores more than the Threshold = 1+z×SDENOF are identified as anomalous clusters. Another parameter of this algorithm is the number of nearest neighbour ellipsoids k, which can be set as a given percentage of the total number of ellipsoids produced.

# How to run:

To detect the outlier hyperellipsoidal clusters using ENOF:

1. run HyCARCE clustering algorithm
```
inpData format: (v1,v2,..,vD,1(reserved),weight,clusterlabel)

Weight can be a natural number that gives a weight to some of the samples and it only work for 2D data. In all other cases this field should be 1

D=2;

Estep=0.95;  

gridcellsize=0.05;

[matA center clusterindex dCountHistory] = HyCARCE_llv(inpData,D,gridcellsize,EStep)
```

2. run ENOF
```

numrow = size(matA,1);

nn= round(0.25*numrow); %k: nearest neighbour ellipsoids, 25% coverage

z=1; %determines the sensitivity of the detector.

effRadiusTH = chi2inv(0.99,D);

[ENOF]=ENOF_llv(matA,center);

% Plot labelled ellipses 

s = find(ENOF <= 1+ z*std(ENOF))  % normal ellipse

q = find(ENOF > 1 + z*std(ENOF)) %Anomalous ellipse
```
# Requirements:
- Matlab

# Bibtex:
Remember to cite the following papers if you use any of the code:
```
@article{lyu2017fog,
  title={Fog-Empowered Anomaly Detection in IoT Using Hyperellipsoidal Clustering},
  author={Lyu, Lingjuan and Jin, Jiong and Rajasegarar, Sutharshan and He, Xuanli and Palaniswami, Marimuthu},
  journal={IEEE Internet of Things Journal},
  volume={4},
  number={5},
  pages={1174--1184},
  year={2017},
  publisher={IEEE}
}

@article{moshtaghi2011efficient,
  title={An efficient hyperellipsoidal clustering algorithm for resource-constrained environments},
  author={Moshtaghi, Masud and Rajasegarar, Sutharshan and Leckie, Christopher and Karunasekera, Shanika},
  journal={Pattern Recognition},
  volume={44},
  number={9},
  pages={2197--2209},
  year={2011},
  publisher={Elsevier}
}

@article{rajasegarar2014ellipsoidal, 
title={Ellipsoidal neighbourhood outlier factor for distributed anomaly detection in resource constrained networks}, 
author={Rajasegarar, Sutharshan and Gluhak, Alexander and Imran, Muhammad Ali and Nati, Michele and Moshtaghi, Masud and Leckie, Christopher and Palaniswami, Marimuthu}, 
journal={Pattern recognition}, 
volume={47}, 
number={9}, 
pages={2867--2879}, 
year={2014}, 
publisher={Elsevier} }

```
