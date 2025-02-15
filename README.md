Crisp Boundary Detection
================================================
This repo is a MATLAB R2019b version of the `crisp-boundaries` repository. Original Repo by authors is here: https://github.com/phillipi/crisp-boundaries

### Note:
Due to github push size limitations, one of the files in `/caches/ii_jj_caches` could not be uploaded. Instead you would find a `zip` file in the same directory. Please unzip it after cloning this repositiory. 

This software package implements the method described in:

"Crisp Boundary Detection Using Pointwise Mutual Information"
Phillip Isola, Daniel Zoran, Dilip Krishnan, and Edward H. Adelson
ECCV, 2014

The code takes an image as input and will attempt to find object boundaries in that image. The code can also be used to segment an image into coherent regions. For more details, please visit the project page here: http://web.mit.edu/phillipi/crisp_boundaries

Additional Dependencies
-----------------------

- Requires 'Image Processing Toolbox' (can be downloaded while installing matlab (preffered) or later too)
- On MATLAB R2019b, function names and definitions need to be replaced at respective places since the code uses functions originally from earlier versions which have now deprecated. 
- On MATLAB R2015b, the code runs as is, once other dependencies have been taken care of.
- A specific version of gcc is required by the code (for some reason). Due to this, it failed on linux even after trying multiple gcc versions.
- On Windows, the gcc version is taken care of by MATLAB itself (since it comes with it).


Installation
------------

To use this software, you first need to compile it. To do so, run: 

    $ cd /path/to/crisp-boundaries
    $ matlab
    >> compile

If you run into trouble compiling, please see ./installation_issues.text.


Usage
-----

To detect boundaries in an image, use the "findBoundaries()" function:

    >> I = imread('/path/to/image');
    >> E = findBoundaries(I);
    >> imshow(1-mat2gray(E));

These commands should take around 1 minute or less for a medium sized image (400x400 pixels) on a typical machine (circa 2014).

More examples are given in demo.m. Please see that file to learn how to adjust parameters, segment an image, etc.


Bundled Libraries
-----------------

This package includes code from a few other libraries in the "toolboxes" folder. These are:

1. The Kernel Density Estimation Toolbox of Ihler and Mandel (http://www.ics.uci.edu/ihler/code/kde.html)
2. The Multigrid Multiscale spectral clustering algorithm of Maire and Yu (https://github.com/mmaire/ae-multigrid)
3. The DNcuts algorithm from Arbelaez et al. (http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/mcg/) -- this wasn't used in the paper, but speeds up spectral clustering quite a lot without sacrificing much accuracy
4. Selected files from the Berkeley Segmentation code base (http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html)

Some of these files were modified for crisp boundaries. Please see notes in the Readme files under each toolbox subdirectory. Further code credit is given at the top of each source file.


Questions and Comments
----------------------

If you have any feedback, please write to Phillip Isola at <phillipi@mit.edu>.