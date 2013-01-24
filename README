The WisconsinThesis LaTeX Class
=================================

**Maintainer:** Troy C. Haskin  


Purpose
-------
The University of Wisconsin-Madison has a number of requirements for a thesis to be properly formatted.
This LaTeX class is written to abide by those requirements in a (hopefully) seamless manner to the user.
Additionally, the class intends to provide a rich and powerful environment for writing long documents that are heavy of cross-referencing and mathematical formulas.

The [`withesis` class on CTAN](http://www.ctan.org/tex-archive/macros/latex/contrib/withesis "withesis CTAN link") was written to perform this task, but it is rather old and doesn't follow many of the LaTeX2e class conventions of recent years.
As such, the `WisconsinThesis` LaTeX Class is meant to supercede the `withesis` class for theses and disserataions.
Lastly, since the base class loaded by this class (`report`) is mutable, there is a hope that future releases will permit excellent generation of shorter, article-style reports.

Development
-----------
Current development of all desire feature is still a work in progress, and with each additional feature, a test `*.tex` file is added to the tests directory.
Once all desired features are input and tested to satisfaction, documentation will be produced through the `docstrip` utility.


Important Notes
---------------

### eTeX Assumed ###
The eTeX engine is assumed. Explicit consideration for systems without eTeX will be made if absolutely needed in the future.
However, since LaTeX3 is expected to be the successor of LaTeX2e, eTeX will hopefully become a universal default and no (if few) problems are expected.
Although TeX will be defaulted to when LaTeX is lacking, eTeX will be used when it is deemed sufficintly superior to a TeX version.  Instances of eTeX usage will be noted here:  
* `Programming::\IfCommandExists` &ndash; eTeX `\ifcsname#1\endcsname` used.
* `Programming::\GlobalNewIf`