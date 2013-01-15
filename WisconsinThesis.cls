%% ============================================================================================= %%
%%                                  WisconsinThesis Class                                        %%
%% ============================================================================================= %%
%%
%%  Class:      WisconsinThesis
%%  Parent:     Report (LaTeX2e base)
%%  Author:     Troy C. Haskin (troy@hask.in) and all the other package authors below
%%  Language:   LaTeX2e and TeX (where deemed necessary)
%%  Purpose:    To provide a LaTeX class file for University of Wisconsin-Madison Ph.D. Theses 
%%              that abides by the style guildelines.
%%  Guildlines: http://www.grad.wisc.edu/education/completedegree/pguide.html (as of 2012/01/09) 
%%
%%  Note:      This class is meant to supercede the withesis class on CTAN.
%%


% =============================================================================================== %
%                                            Class Setup                                          %
% =============================================================================================== %

% ------------------------------------------------------------------------------------- %
%                        Class Identification and LaTeX Requirement                     %
% ------------------------------------------------------------------------------------- %

% Identification Commands
\newcommand{\UWMad@ClassName}         {WisconsinThesis}
\newcommand{\UWMad@UniversityLong}    {University of Wisconsin-Madison}
\newcommand{\UWMad@UniversityShort}   {UW-Madison}
\newcommand{\UWMad@ClassVersion}      {v0.1 }
\newcommand{\UWMad@ClassVersionDate}  {2012/01/09 }
\newcommand{\UWMad@TheParentClass}    {report}


% LaTeX Requirement and Class Idetification
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\UWMad@ClassName}[\UWMad@ClassVersionDate \UWMad@ClassVersion | LaTeX2e Thesis Class for \UWMad@UniversityLong]




% ------------------------------------------------------------------------------------- %
%                               Option Declarations                                     %
% ------------------------------------------------------------------------------------- %

% Declare ifs for option switches
\newif\ifUWMad@FrontMatterCommands\UWMad@FrontMatterCommandsfalse
\newif\ifUWMad@IncludeMathCommands\UWMad@IncludeMathCommandstrue
\newif\ifUWMad@NoPDFMetaInfo      \UWMad@NoPDFMetaInfofalse
\newif\ifUWMad@EnableHyperlinking \UWMad@EnableHyperlinkingtrue
\newif\ifUWMad@IsADissertation    \UWMad@IsADissertationtrue

% A command that will warn about certain options (mainly a4paper and twoside) but still
% pass them to the Parent.
\DeclareRobustCommand{\UWMad@StyleWarningButExecute}[1]{
   \ClassWarningNoLine{\UWMad@ClassName}{
        Option '#1' violates UW-Madison Dissertation Guidelines; consider omission
   }
   \PassOptionsToClass{#1}{\UWMad@TheParentClass}
}


\DeclareOption{FrontMatterCommands}{\UWMad@FrontMatterCommandstrue}  %  Define Front Matter sectioning tools as commands instead of environments
\DeclareOption{NoMath}             {\UWMad@IncludeMathCommandsfalse} %  Do not include math related packages of commands
\DeclareOption{NoPDFMeta}          {\UWMad@NoPDFMetatrue}            %  Do not write out PDF meta data for use in hyperref
\DeclareOption{NoLinks}            {\UWMad@EnableHyperlinkingfalse}  %  Do not use hyperlinking at all
\DeclareOption{Prelim}             {\UWMad@IsADissertationfalse}     %  This is a Prelim not a disseration

% These options are caught and warned since they viloate the style guidelines.
\DeclareOption{a4paper}       {\UWMad@StyleWarningButExecute{\CurrentOption}} % Styleguidline: 8.5in x 11in paper
\DeclareOption{twoside}       {\UWMad@StyleWarningButExecute{\CurrentOption}} % Styleguidline: One-sided printing.


% All undeclared options are passed to the Parent at Load
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\UWMad@TheParentClass}}


% Declare default options just before processing.
\ExecuteOptions{oneside,12pt}
\ProcessOptions\relax




% =============================================================================================== %
%                                         Parent Class Load                                       %
% =============================================================================================== %
\LoadClass{\UWMad@TheParentClass}[1995/12/01]




% =============================================================================================== %
%                                          Package Loads                                          %
% =============================================================================================== %
\RequirePackage{fixltx2e}  % Provides fixes from the LaTeX Team that address certain issues
%\RequirePackage{ifetex}    % Check for etex availablity
\RequirePackage{array}
\RequirePackage{graphicx}  % 
\RequirePackage{subfig}    % Provides the ability to make figures wrappable
\RequirePackage[usenames,dvipsnames,svgnames,table,hyperref]{xcolor}    % Provides enhanced color support
\RequirePackage{setspace}  % Provides easy control of LaTeX line spacing
\RequirePackage{ifthen}    % Provides if-then-else commands and comparisons 
\RequirePackage{geometry}  % Provides easy control of LaTeX page layout
\RequirePackage{xspace}    % Small module defining xspace (used for properly inserting a space at the end of a text 'storage' command
\RequirePackage{caption}

\ifUWMad@IncludeMathCommands
    \RequirePackage[intlimits,sumlimits]{amsmath}   % Provides AMS math fixes and features for math typesetting
    \RequirePackage{amssymb}   % Symbols
    \RequirePackage{amsfonts}  % Fonts
\fi

\ifUWMad@EnableHyperlinking
    \RequirePackage{bookmark}  % Provides an improvement to hyperref
\fi

\RequirePackage[noabbrev]{cleveref}



% =============================================================================================== %
%                                          Utility Commands                                       %
% =============================================================================================== %
\InputIfFileExists{WisconsinThesis.Module.Programming}{}{
   \ClassWarningNoLine{\UWMad@ClassName}{
        Could not locate Programming module.
   }
}


% \newcommand{\MakeCommand}[2]{
%     \expandafter\newcommand\csname #1\endcsname{#2}
% }
% 
% \newcommand{\ReMakeCommand}[2]{
%     \expandafter\renewcommand\csname #1\endcsname{#2}
% }
%

\DeclareRobustCommand{\UWMad@ClassMessage}[1]{
   \typeout{Class \UWMad@ClassName\space Message: #1}
}





% =============================================================================================== %
%                                          Page Layout                                            %
% =============================================================================================== %
\geometry{
    margin      = 1.0in,        % Define: margins
    includehead = true,         % Option: Include header height in the margin calculations
    paper       = letterpaper   % Define: paper size (8.5in x 11 in.)
}

\creflabelformat{equation}{#2#1#3}

\captionsetup[table]{
    format=hang,
    labelsep=colon,
    justification=justified,
    labelfont={sl},
    textfont=sl,
    font={sc,small,stretch=1.1},
    width=0.9\textwidth,
    position=above,
    skip=0.25em
}

\captionsetup[figure]{
    format=hang,
    labelsep=colon,
    justification=justified,
    labelfont={sl},
    textfont=sl,
    font={small,stretch=1.1},
    width=0.9\textwidth,
    position=above,
    skip=0.5em
}

\pagestyle{myheadings}        % Set: Place page number in the upper-right corner of the page
\pagenumbering{roman}         % Set: Page numbering defaults to roman (this switches to arabic upon first unstarred \chapter{} )
\doublespacing                % Set: Doublespace the document
\setlength{\parindent}{ 0pt}  % Set: No paragraph indentation
\setlength{\parskip}  {10pt}  % Set: Separation between paragraphs
\setlength{\headsep}  {15pt}  % Set: Distance between bottom of header and top of page body




% =============================================================================================== %
%                                          Sectioning Module                                      %
% =============================================================================================== %
\InputIfFileExists{WisconsinThesis.Module.Sectioning}{}{
   \ClassWarningNoLine{\UWMad@ClassName}{
        Could not locate Sectioning module.
   }
}





% =============================================================================================== %
%                          Hyperref SetUp and PDF Meta-Information Commands                       %
% =============================================================================================== %
\definecolor{MyGreen}{rgb}{0,0.7,0}
% Default hyperref behavior that is *not* PDF Metadata
\hypersetup{
    colorlinks         = true   ,  % Makes links colored and not boxed
    linkcolor          = blue   ,  % link color to blue
    citecolor          = MyGreen,  % cite color
    urlcolor           = violet,   % URL color
    pdfdisplaydoctitle = true,     % Show title instead of filename
    pdfview            = {FitH} ,  % Should (but does not always) put the PDF zoom to pade width upon open
    pdfstartview       = {FitH} ,  % Should (but does not always) put the PDF zoom to pade width upon open
    pdfpagelayout      = OneColumn,
    plainpages         = false  ,  % Makes Hyperref follow the page numbering styles in the link definitions 
    hypertexnames      = true   ,  % Makes Hyperref used 'intuitive' choices for its link anchors
    bookmarksopenlevel = 3      ,  % Will expand the bookmark structure down to the subsubsection level
    bookmarksopen      = true   ,  % Opens the bookmark menu
    unicode
}


% ------------------------------------------------------------------------ %
%                    Metadata Writing/Importing Routines                   %
% ------------------------------------------------------------------------ %
%
%   Since the metadata (i.e., properties) of a PDF must be set in the preamble
%   but typically a user defines them in the document, these routines write the
%   supported metadata that a user may define to an auxiliary file that is
%   then imported upon recompilation.  It uses the CSV commands above to define
%   and build the CSV list, and then uses the TeX \write to dump it to the file.
%   

% Used to determine is the list was created
\newif\ifUWMad@MetaDataListInitialized\UWMad@MetaDataListInitializedfalse


% Command used to append the data to the CSV list.  It is called in the 
% metadata commands below
\newcommand{\PushPDFMetaDataToList}[2]{
    \ifUWMad@MetaDataListInitialized             % Test:    Is the list created?
        \MetaDataListAppend{#1={#2}}             % True:    Append the data
    \else                                        % False:
        \CSVMake{MetaDataList}{#1={#2}}          %          Create the list.
        \UWMad@MetaDataListInitializedtrue       %          Switch to true.
    \fi
}


% If the auxiliary file exists, just import it.
\InputIfFileExists{UWMad.PDFMetaData.aux}{}{}


% Command that writes the auxiliary file; it is called with \AtEndDocument such that
% metadata can be defined anywhere in the document.
\DeclareRobustCommand{\WriteOutMetaData}{
    \newwrite\HyperSetupWrite
    \immediate\openout\HyperSetupWrite=UWMad.PDFMetaData.aux
    \immediate\write\HyperSetupWrite{\noexpand\hypersetup {\MetaDataList}}
    \immediate\closeout\HyperSetupWrite
}


% End-of-Document Commands
\AtEndDocument{
    \@ifundefined{MetaDataList}
        {}
        {\WriteOutMetaData}
}



% ------------------------------------------------------------------------ %
%           Metadata Defining/Storing Commands (User's Interface)          %
% ------------------------------------------------------------------------ %
% These commands hold the actual information that will be displayed upon typesetting.
\newcommand{\TheTitle}      {}
\newcommand{\TheSubtitle}   {}
\newcommand{\TheAuthor}     {}
\newcommand{\TheDate}       {}
\newcommand{\TheDepartment} {}
\newcommand{\TheDegree}     {}
\newcommand{\TheSpecialty}  {}
\newcommand{\TheAdvisor}    {}
\newcommand{\TheUniversity} {}
\newcommand{\TheKeywords}   {}
\newcommand{\TheSubject}    {}
\newcommand{\TheProducer}   {}
\newcommand{\TheCreator}    {}
\newcommand{\Title}      [1] {\renewcommand{\TheTitle}      {#1\xspace}    \PushPDFMetaDataToList{pdftitle}    {#1}}
\newcommand{\Author}     [1] {\renewcommand{\TheAuthor}     {#1\xspace}    \PushPDFMetaDataToList{pdfauthor}   {#1}}
\newcommand{\Subject}    [1] {\renewcommand{\TheSubject}    {#1\xspace}    \PushPDFMetaDataToList{pdfsubject}  {#1}}
\newcommand{\Producer}   [1] {\renewcommand{\TheProducer}   {#1\xspace}    \PushPDFMetaDataToList{pdfproducer} {#1}}
\newcommand{\Creator}    [1] {\renewcommand{\TheCreator}    {#1\xspace}    \PushPDFMetaDataToList{pdfcreator}  {#1}}
\newcommand{\Keywords}   [1] {\renewcommand{\TheKeywords}   {#1\xspace}    \PushPDFMetaDataToList{pdfkeywords} {#1}}
\newcommand{\Subtitle}   [1] {\renewcommand{\TheSubtitle}   {#1\xspace}}
\newcommand{\Date}       [1] {\renewcommand{\TheDate}       {#1\xspace}}
\newcommand{\Department} [1] {\renewcommand{\TheDepartment} {#1\xspace}}
\newcommand{\Degree}     [1] {\renewcommand{\TheDegree}     {#1\xspace}}
\newcommand{\Specialty}  [1] {\renewcommand{\TheSpecialty}  {#1\xspace}}
\newcommand{\Advisor}    [1] {\renewcommand{\TheAdvisor}    {#1\xspace}}
\newcommand{\University} [1] {\renewcommand{\TheUniversity} {#1\xspace}}

% These commands are used to assign the information to the above commands






% =============================================================================================== %
%                                      Thesis Committee Commands                                  %
% =============================================================================================== %

% Member counter
\DefineNewCounter{CommitteeMemberCount}{0}


% Pushes Committee Members' names and descriptions into the proper storage commands
%   Notes: 
%       o   The commands' \TheCommitteeNames and \TheCommitteeDescriptions arguments are wrapped in { } to protect commas supplied in both by the user.
%       o   The names and descriptions will be popped by a ##display command name## below in a FIFO sense.
%
\newcommand{\CommitteeMember}[2]{

    % If statement that handles if the member popped is the first or not.
        \ifthenelse{\arabic{CommitteeMemberCount}=0}
        {
        % The first use initializes the Names and Descriptions commands
            \CSVMake{TheCommitteeNames}       {{#1}}
            \CSVMake{TheCommitteeDescriptions}{{#2}}
        }{ 
        % Subsequent uses append the new data to the initialized commands in a CSV list.
            \TheCommitteeNamesAppend{{#1}}
            \TheCommitteeDescriptionsAppend{{#2}}
        }
        % Step the counter
        \stepcounter{CommitteeMemberCount}

}



%%% =============================================================================================== %
%%%                                       Nomenclature Commands                                     %
%%% =============================================================================================== %
%%
%%% Member counter
%%\DefineNewCounter{NomenclatureCount}{0}
%%
%%
%%% Pushes Committee Members' names and descriptions into the proper storage commands
%%%   Notes: 
%%%       o   The commands' \TheCommitteeNames and \TheCommitteeDescriptions arguments are wrapped in { } to protect commas supplied in both by the user.
%%%       o   The names and descriptions will be popped by a ##display command name## below in a FIFO sense.
%%%
%%\newcommand{\Nomenclature}[2]{
%%
%%    % If statement that handles if the member popped is the first or not.
%%      \ifthenelse{\arabic{NomenclatureCount}=0}
%%      {
%%      % The first use initializes the Names and Descriptions commands
%%          \CSVMake{TheNomenclatureNames}       {{#1}}
%%          \CSVMake{TheNomenclatureDescriptions}{{#2}}
%%      }{
%%      % Subsequent uses appends the new data to the initialized commands into a CSV list.
%%          \TheNomenclatureNamesAppend       {{#1}}
%%          \TheNomenclatureDescriptionsAppend{{#2}}
%%      }
%%      % Step the counter
%%      \stepcounter{NomenclatureCount}
%%
%%}











% =============================================================================================== %
%                                      Title Page                                                 %
% =============================================================================================== %
% That phrase that occurs on every title page design the class author has seen
\DeclareRobustCommand{\ThatOddPhrase}{\setstretch{1.1}
    \ifUWMad@IsADissertation
        A dissertation submitted in partial fulfillment of the requirements for the degree of
    \else
        A preliminary report submitted in partial fulfillment of the requirements for the degree of
    \fi
}

\DeclareRobustCommand{\MakeTitlePageTitleBlock}{
    \vspace{0.3in}
    \LARGE
    \textsc{\TheTitle}~\\[0.2in]
    by~\\[0.2in]
    \Large
    \TheAuthor
}

\DeclareRobustCommand{\MakeTitlePageDegreeBlock}{
    \Large
    \ThatOddPhrase~\\[0.2in]
    \TheDegree \\[0.1in]
    \TheSpecialty
}

\DeclareRobustCommand{\MakeTitlePageUniversityBlock}{
    \Large
    at \\[0.4in]
    \textsc{\TheUniversity} \\[0.1in]
    \the\year
}


\DeclareRobustCommand{\MakeTitlePage}{
    \thispagestyle{empty}
    \begin{center}
        \MakeTitlePageTitleBlock
        \null\vfill
        \MakeTitlePageDegreeBlock
        \null\vfill
        \MakeTitlePageUniversityBlock
    \end{center}
    \clearpage
}





% =============================================================================================== %
%                                     LicensePage Module                                          %
% =============================================================================================== %
\InputIfFileExists{WisconsinThesis.Module.LicensePage}{}{
   \ClassWarningNoLine{\UWMad@ClassName}{
        Could not locate LicensePage module.
   }
}



% =============================================================================================== %
%                                     Math Module                                                 %
% =============================================================================================== %
\InputIfFileExists{WisconsinThesis.Module.Math}{}{
   \ClassWarningNoLine{\UWMad@ClassName}{
        Could not locate Math module.
   }
}




% =============================================================================================== %
%                                Relative Directory Input Commands                                %
% =============================================================================================== %

\newif\ifUWMad@DefaultFileNameDefined\UWMad@DefaultFileNameDefinedfalse
\newcommand{\TheDefaultFileName}    {}
\newcommand{\DefaultFileName}   [1] {\renewcommand{\TheDefaultFileName}{#1}\UWMad@DefaultFileNameDefinedtrue}

\newcommand{\DirectoryPrefixChapter} {Chapter-}
\newcommand{\DirectoryPrefixAppendix}{Appendix-}
\newcommand{\DirectoryPrefixSections}{Sections}

%\newcommand{\CurrentFileName}  {}
%\global\def\CurrentFileName{}
\newcommand{\ChapterDirectory} {}
\newcommand{\AppendixDirectory}{}
\newcommand{\SectionsDirectory}{}

\newcommand{\UpdateChapterDirectory} [1]{\renewcommand{\ChapterDirectory} {\DirectoryPrefixChapter#1} }
\newcommand{\UpdateAppendixDirectory}[1]{\renewcommand{\AppendixDirectory}{\DirectoryPrefixAppendix#1}}
\newcommand{\UpdateSectionsDirectory}[1]{\renewcommand{\SectionsDirectory}{\DirectoryPrefixSections#1}}

\newif\ifUWMad@LoadUnsuccessful\UWMad@LoadUnsuccessfultrue
\newif\ifUWMad@NotAlreadyLoaded\UWMad@NotAlreadyLoadedfalse

\newcommand{\InputIfFileExistsAndIsNotCurrentFile}[3]{
    
    \@ifundefined{#1FileLoaded}{

        \InputIfFileExists{#1}{
            \MakeCommand{#1FileLoaded}{}
            #2
            \UWMad@ClassMessage{Loaded #1.}
        }{
            \UWMad@ClassMessage{The file #1.tex does not exist.}
            #3
        }
        
    }{
        \UWMad@NotAlreadyLoadedfalse
        \ClassWarning{\UWMad@ClassName}{The File #1 was already input. It was not input again.}
    }
}

\newcommand{\AttemptToLoadFile}[2]{ % #1 = path, #2 = FileName

    \UWMad@LoadUnsuccessfultrue                                     % Set load to unsuccessful

    \edef\TheFile{#1/#2}
    \InputIfFileExistsAndIsNotCurrentFile{\TheFile}{                 % Look for ./Path/FileName.tex
        \UWMad@LoadUnsuccessfulfalse                                % Load was successful
    }{
        \ifUWMad@DefaultFileNameDefined
            \edef\TheFile{#1/\TheDefaultFileName}                                   
            \InputIfFileExistsAndIsNotCurrentFile{\TheFile}{    % Look for ./Path/DefaultFileName.tex
                \UWMad@LoadUnsuccessfulfalse                    % Load was successful
            }{
                \edef\TheFile{#2}                                   
                \InputIfFileExistsAndIsNotCurrentFile{\TheFile}{    % Look for ./FileName.tex
                    \UWMad@LoadUnsuccessfulfalse                    % Load was successful
                }{
                    % ****** NOT FOUND AT ALL ****** %
                }
            }

        \else
            \edef\TheFile{#2}                                   
            \InputIfFileExistsAndIsNotCurrentFile{\TheFile}{    % Look for ./FileName.tex
                \UWMad@LoadUnsuccessfulfalse                   % Load was successful
            }{
                % ****** NOT FOUND AT ALL ****** %
            }
        \fi
    }
}


\newcommand{\InputChapter}[2]{
    \UWMad@NotAlreadyLoadedtrue
    \UpdateChapterDirectory{#1}             % Update the current Chapter Directory
    \AttemptToLoadFile{\ChapterDirectory}{#2} % Attempt to input the file

    \ifUWMad@LoadUnsuccessful
        \ifUWMad@NotAlreadyLoaded
            \ClassWarning{\UWMad@ClassName}{Did not find #2.tex in \ChapterDirectory\space directory or in the parent directory.}
        \fi
    \fi 

}

\newcommand{\InputAppendix}[1]{
    % The appendix is a special kind of chapter, so the commands are not duplicated.
    \renewcommand{\DirectoryPrefixChapter}{\DirectoryPrefixAppendix}    % Redefine the prefix
    \InputChapter{#1}                                                   % Call the chapter input command
}

\newcommand{\InputSection}[1]{
    \UWMad@NotAlreadyLoadedtrue
    \AttemptToLoadFile{\ChapterDirectory}{#1}
    
    \ifUWMad@LoadUnsuccessful
        \AttemptToLoadFile{\ChapterDirectory/\DirectoryPrefixSections}{#1}
        
        \ifUWMad@LoadUnsuccessful
            \UpdateSectionsDirectory{-#1}
            \AttemptToLoadFile{\ChapterDirectory/\SectionsDirectory}{#1}

            \ifUWMad@LoadUnsuccessful
                \ifUWMad@NotAlreadyLoaded
                    \ClassWarning{\UWMad@ClassName}{Could not find nor load section #1.}
                \fi
            \fi

        \fi
    \fi

}






% ===================================================================================== %
%                                     <= and >= Commands                                %
% ===================================================================================== %
\newcommand{\IfGreaterThanEqualTo}[4]{
    \ifnum#1>#2
        #3
    \else
        \ifnum#1=#2
            #3
        \else
            #4
        \fi
    \fi
}

\newcommand{\IfLessThanEqualTo}[4]{
    \ifnum#1<#2
        #3
    \else
        \ifnum#1=#2
            #3
        \else
            #4
        \fi
    \fi
}





% ===================================================================================== %
%                   Make greek letters work in and out of MathMode                      %
% ===================================================================================== %

    \let\Oldalpha     \alpha     \renewcommand{\alpha}     {\ensuremath{\Oldalpha     }\xspace}
    \let\Oldbeta      \beta      \renewcommand{\beta}      {\ensuremath{\Oldbeta      }\xspace}
    \let\Oldgamma     \gamma     \renewcommand{\gamma}     {\ensuremath{\Oldgamma     }\xspace}
    \let\Olddelta     \delta     \renewcommand{\delta}     {\ensuremath{\Olddelta     }\xspace}
    \let\Oldepsilon   \epsilon   \renewcommand{\epsilon}   {\ensuremath{\Oldepsilon   }\xspace}
    \let\Oldvarepsilon\varepsilon\renewcommand{\varepsilon}{\ensuremath{\Oldvarepsilon}\xspace}
    \let\Oldzeta      \zeta      \renewcommand{\zeta}      {\ensuremath{\Oldzeta      }\xspace}
    \let\Oldeta       \eta       \renewcommand{\eta}       {\ensuremath{\Oldeta       }\xspace}
    \let\Oldtheta     \theta     \renewcommand{\theta}     {\ensuremath{\Oldtheta     }\xspace}
    \let\Oldvartheta  \vartheta  \renewcommand{\vartheta}  {\ensuremath{\Oldvartheta  }\xspace}
    \let\Oldkappa     \kappa     \renewcommand{\kappa}     {\ensuremath{\Oldkappa     }\xspace}
    \let\Oldlambda    \lambda    \renewcommand{\lambda}    {\ensuremath{\Oldlambda    }\xspace}
    \let\Oldmu        \mu        \renewcommand{\mu}        {\ensuremath{\Oldmu        }\xspace}
    \let\Oldnu        \nu        \renewcommand{\nu}        {\ensuremath{\Oldnu        }\xspace}
    \let\Oldxi        \xi        \renewcommand{\xi}        {\ensuremath{\Oldxi        }\xspace}
    \let\Oldpi        \pi        \renewcommand{\pi}        {\ensuremath{\Oldpi        }\xspace}
    \let\Oldvarpi     \varpi     \renewcommand{\varpi}     {\ensuremath{\Oldvarpi     }\xspace}
    \let\Oldrho       \rho       \renewcommand{\rho}       {\ensuremath{\Oldrho       }\xspace}
    \let\Oldvarrho    \varrho    \renewcommand{\varrho}    {\ensuremath{\Oldvarrho    }\xspace}
    \let\Oldsigma     \sigma     \renewcommand{\sigma}     {\ensuremath{\Oldsigma     }\xspace}
    \let\Oldvarsigma  \varsigma  \renewcommand{\varsigma}  {\ensuremath{\Oldvarsigma  }\xspace}
    \let\Oldtau       \tau       \renewcommand{\tau}       {\ensuremath{\Oldtau       }\xspace}
    \let\Oldupsilon   \upsilon   \renewcommand{\upsilon}   {\ensuremath{\Oldupsilon   }\xspace}
    \let\Oldphi       \phi       \renewcommand{\phi}       {\ensuremath{\Oldphi       }\xspace}
    \let\Oldvarphi    \varphi    \renewcommand{\varphi}    {\ensuremath{\Oldvarphi    }\xspace}
    \let\Oldchi       \chi       \renewcommand{\chi}       {\ensuremath{\Oldchi       }\xspace}
    \let\Oldpsi       \psi       \renewcommand{\psi}       {\ensuremath{\Oldpsi}\xspace}
    \let\Oldomega     \omega     \renewcommand{\omega}     {\ensuremath{\Oldomega     }\xspace}
    \let\OldGamma     \Gamma     \renewcommand{\Gamma}     {\ensuremath{\OldGamma     }\xspace}
    \let\OldLambda    \Lambda    \renewcommand{\Lambda}    {\ensuremath{\OldLambda    }\xspace}
    \let\OldSigma     \Sigma     \renewcommand{\Sigma}     {\ensuremath{\OldSigma     }\xspace}
    \let\OldPsi       \Psi       \renewcommand{\Psi}       {\ensuremath{\OldPsi       }\xspace}
    \let\OldDelta     \Delta     \renewcommand{\Delta}     {\ensuremath{\OldDelta     }\xspace}
    \let\OldXi        \Xi        \renewcommand{\Xi}        {\ensuremath{\OldXi        }\xspace}
    \let\OldUpsilon   \Upsilon   \renewcommand{\Upsilon}   {\ensuremath{\OldUpsilon   }\xspace}
    \let\OldOmega     \Omega     \renewcommand{\Omega}     {\ensuremath{\OldOmega     }\xspace}
    \let\OldTheta     \Theta     \renewcommand{\Theta}     {\ensuremath{\OldTheta     }\xspace}
    \let\OldPi        \Pi        \renewcommand{\Pi}        {\ensuremath{\OldPi        }\xspace}
    \let\OldPhi       \Phi       \renewcommand{\Phi}       {\ensuremath{\OldPhi       }\xspace}



% ===================================================================================== %
%                               Nomenclature Environment                                %
% ===================================================================================== %

\DefineNewLength{\WidestSymbol}{0pt}            % Will have the value of the widest symbol for spacing
\DefineNewLength{\WidestSymbolTest}{0pt}        % Used to test for the widest symbol
\DefineNewLength{\NomenclatureTitleSkip}{1em}        % Used for title spacing
\DefineNewLength{\NomenclaturePrintSkip}{1em}        % Used for spacing after nomenclature is printed
\DefineNewLength{\SymbolWidth}          {0em}
\DefineNewLength{\DescriptionWidth}     {0em}
\DefineNewLength{\EntryLeftPad}         {0.2em}
\DefineNewCounter{SubNomenclatureCounter}{0}    % Number of Subnomenclatures

\newif\ifUWMad@PrintTheNomenclature\UWMad@PrintTheNomenclaturetrue

\newcommand{\DoNoPrintTheNomenclature}{
    \begin{MakeGlobal}
        \UWMad@PrintTheNomenclaturefalse
    \end{MakeGlobal}
}

\newcommand{\GeneralAdd}[4]{ % #1 = Symbol array name, #2 = Description array name, #3 = symbol, #4 = description
    \ArrayPush{#1}{#3}
    \ArrayPush{#2}{#4}
     
    \settowidth{\WidestSymbolTest}{#3}
    \ifdim\WidestSymbol<\WidestSymbolTest
        \setlength{\WidestSymbol}{\WidestSymbolTest}
    \fi
}

\newcommand{\NomenclaturePrint}[3]{ % #1 = Nomenclature name, #2 = Symbol array name, #3 = Description array name
        \ifnum\value{#2\ArrayCountSuffix}>0
            \setlength{\SymbolWidth}{\WidestSymbol+1em}
            \setlength{\DescriptionWidth}{\textwidth-\SymbolWidth-\EntryLeftPad}
            \setlength{\DescriptionWidth}{0.90\DescriptionWidth}
    %
            \begin{spacing}{1.1}
                \begin{tabular}{p{\EntryLeftPad} p{\SymbolWidth} p{\DescriptionWidth}}
                    \multicolumn{3}{l}{#1}\\[1em]
                    \UWMadFor[1]{1}{\value{#2\ArrayCountSuffix}}{
                        &\ArrayGet{#2}{\value{ForLoopCounter}}&\ArrayGet{#3}{\value{ForLoopCounter}}\\
                    }
                \end{tabular}
            \end{spacing}
        \fi
}


\newcommand{\Add}{}

\newcommand{\MakeNomenclatureTitle}[1]{
    \ifx \UWMad@NomenclatureTitleMade \UWMad@Undefined
        \chapter*{#1}\UWMad@FrontMatterRegister{#1}     % Couldn't get any of the conditionals to behave globally
        \global\def\UWMad@NomenclatureTitleMade{}       % So I instituted this hack.
    \fi
}

% Nomenclature environment ----------------------------------------------------
\newenvironment{Nomenclature}[1][Nomenclature]{
    
    \newcommand{\NomenclatureTitle}{#1}
    \setlength{\parindent}{0pt}

    \renewcommand{\Add}[2]{\GeneralAdd{NomenclatureSymbol}{NomenclatureDescription}{##1}{##2}}

    \ArrayMake{NomenclatureSymbol}
    \ArrayMake{NomenclatureDescription}
    \let\item\Add

}{
    \ifUWMad@PrintTheNomenclature
        \setlength{\NomenclatureTitleSkip}{0em}
        \setlength{\NomenclaturePrintSkip}{1em}
        \NomenclaturePrint{\MakeNomenclatureTitle{\NomenclatureTitle}}{NomenclatureSymbol}{NomenclatureDescription}
        \setlength{\WidestSymbol}{0pt}
    \fi
}

\newcommand{\UWMad@Acronym}{Acronym}
\newcommand{\UWMad@MakeAcronym}[2]{% #1 = Acronym , #2 = Full Expansion
    \DefineNewCounter{#1AcronymUsage}{0}
    \globaldefs=1
    \MakeCommand{#1Acronym}{\ifnum\value{#1AcronymUsage}>0 #1\else #2 (#1)\fi\stepcounter{#1AcronymUsage}}
    \globaldefs=0
}
% #1 = Acronym
\newcommand{\Acronym}[1]{\ifUWMad@PrintTheNomenclature\hyperref[Acronym:#1]{\textcolor{black}{\csname#1Acronym\endcsname}}\else\csname#1Acronym\endcsname\fi}



% SubNomenclature environment ----------------------------------------------------
\newenvironment{SubNomenclature}[1][SubNomenclature]{
    
    \addtocounter{SubNomenclatureCounter}{1}
    \def\ThisSubNomenclature           {SubNomenclature\roman{SubNomenclatureCounter}}
    \def\ThisSubNomenclatureSymbol     {SubNomenclature\roman{SubNomenclatureCounter}Symbol}
    \def\ThisSubNomenclatureDescription{SubNomenclature\roman{SubNomenclatureCounter}Description}
    \def\ThisSubNomenclatureTitle      {#1}
    
    \setlength{\parindent}{0pt}
    
    \ArrayMake{\ThisSubNomenclatureSymbol}
    \ArrayMake{\ThisSubNomenclatureDescription}
    
    \ifthenelse{\equal{#1}{\UWMad@Acronym}}{
        \renewcommand{\Add}[2]{
            \GeneralAdd{\ThisSubNomenclatureSymbol}{\ThisSubNomenclatureDescription}{##1\label{Acronym:##1}}{##2}
            \UWMad@MakeAcronym{##1}{##2}
        }
    }{
        \renewcommand{\Add}[2]{\GeneralAdd{\ThisSubNomenclatureSymbol}{\ThisSubNomenclatureDescription}{##1}{##2}}
    }
    
    \let\item\Add
}{

    \ifUWMad@PrintTheNomenclature
        \ifnum\value{NomenclatureSymbol\ArrayCountSuffix}=0
            \MakeNomenclatureTitle{\NomenclatureTitle}
        \else
            \setlength{\NomenclatureTitleSkip}{0em}
            \setlength{\NomenclaturePrintSkip}{1em}
            \NomenclaturePrint{\MakeNomenclatureTitle{\NomenclatureTitle}}{NomenclatureSymbol}{NomenclatureDescription}
        \fi
        
        \setlength{\NomenclatureTitleSkip}{-0.4em}
        \setlength{\NomenclaturePrintSkip}{2em}
        \NomenclaturePrint{\textbf{\ThisSubNomenclatureTitle}}{\ThisSubNomenclatureSymbol}{\ThisSubNomenclatureDescription}
        \setlength{\WidestSymbol}{0pt}
    \fi
}



