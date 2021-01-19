This repo is the final (cumulative) project for "Computer Integrated Surgery" (Prof Russel Taylor, Johns Hopkins Department of Computer Science). It was written by John D'Uva and Vivian Looi in the Fall of 2020. While a brief description of the main function and classes can be found below, a deeper discussion can be found in Program_Listing.pdf. An extensive report of the entire program can be found in Report.pdf. 


MATLAB Toolboxes required:

MATLAB                                        	Version 9.8	        (R2020a)
Robotics System Toolbox                       	Version 3.1         	(R2020a)
Statistics and Machine Learning Toolbox     	Version 11.7        	(R2020a)
Symbolic Math Toolbox                        	Version 8.5         	(R2020a)

-----------------------------------------------------------------------------------------------------
Source files

Vector.m                This class represents a 3D vector as a 4D quantity.
Rotation.m              This class represents a 3D rotation (3x3) matrix.
Frame.m                 This class represents a transformation frame as a 4x4 matrix.
main.m                  This executable reads text files specifying sensor values, then outputs the 
			mode weights determined for the deformed atlas, position of sample points 
			in the coordinates of the bone, the points on the surface mesh that are closest 
			to the sample points, and their magnitude differences into a text file.	
				
-----------------------------------------------------------------------------------------------------
Instructions for using main.m

- Place all input text files in a folder named "INPUT", which should be located in the same directory 
  as the folder containing main.m ("PROGRAMS")
- When the program is run, you will be prompted to enter an alphabet from a to k (except i) in the command line. 
  This alphabet identifies the data set to be read
- The program will output a text file named "NAME-OUTPUT.TXT" in a folder named  "OUTPUT", 
  which will be created for you by main.m in the same directory as the folder containing main.m ("PROGRAMS").
  Upon program completion, you will see the following printed in the command window:
  "Results written to: ../OUTPUT/NAME-OUTPUT.TXT". You will also see a plot showing the magnitude difference 
  between of s and c for each iteration of the ICP algorithm.

-----------------------------------------------------------------------------------------------------
Note:

A complete data set should contain the following text files:
- “Problem5-BodyA.txt”          – input file which describes the positions of LED markers in the rigid body A
- “Problem5-BodyB.txt”          – input file which describes the positions of LED markers in the rigid body B
- "Problem5MeshFile.sur"        – input file which describes data of the surface mesh model
- “Problem5Modes.txt”           - the deformed atlas mode file
- “PA5-NAME-SampleReadings.txt” – input file which provides the values read by the optical tracker

