This code is a close implementation of [1]. Some loops are replaced with matrix calculations to increase the code execution in Matlab.

File "Synth.m" include a simple code that call the clustering function using normalized S1 dataset. Load the "SDataset.mat" first before running the code. Please make sure the expected format for input data is used to call HyCARCE.

Inputdata format: (v1,v2,..,vD,1(reserved),weight,clusterlabel)
Weight can be a natural number that gives a weight to some of the samples and it only work for 2D data. In all other cases this field should be 1


[1] "Masud Moshtaghi, Sutharshan Rajasegarar, Christopher Leckie, Shanika Karunasekera, "An Efficient Hyperellipsoidal Clustering Algorithm for Resource-Constrained Environments", Accepted in Pattern Recognition, March 2011"