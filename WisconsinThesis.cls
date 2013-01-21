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
\newcommand{\UWMad@ClassVersion}      {v0.1}
\newcommand{\UWMad@ClassVersionDate}  {2012/01/09}
\newcommand{\UWMad@TheParentClass}    {report}


% LaTeX Requirement and Class Idetification
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\UWMad@ClassName}[\UWMad@ClassVersionDate\space\UWMad@ClassVersion\space| LaTeX2e Thesis Class for \UWMad@UniversityLong]




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
\RequirePackage{array}
\RequirePackage{graphicx}  % 
\RequirePackage{subfig}    % Provides the ability to make figures wrappable
\RequirePackage[usenames,dvipsnames,svgnames,table,hyperref]{xcolor} % Provides enhanced color support
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
%                                     Typeout Commands                                            %
% =============================================================================================== %

% Generic message typeout
\DeclareRobustCommand{\UWMad@ClassMessage}[1]{%
   \typeout{Class \UWMad@ClassName\space Message: #1}
}


% Official class warning typeout
\DeclareRobustCommand{\UWMad@ClassWarning}[1]{%
   \ClassWarning{\UWMad@ClassName}{#1}
}

% =============================================================================================== %
%                                   Module Loader Commands                                        %
% =============================================================================================== %
\newcommand{\ModulePrefix}{WisconsinThesis.Module.}
\newcommand{\ModuleSuffix}{}

\DeclareRobustCommand{\LoadIfModuleExists}[1]{
    
    \edef\TheModule{\ModulePrefix#1\ModuleSuffix}
    
    \InputIfFileExists{\TheModule}{}{
        \UWMad@ClassWarning{Could not locate #1 module.}
    }
}


% =============================================================================================== %
%                                     Module Loads                                                %
% =============================================================================================== %
\LoadIfModuleExists{Programming}
\LoadIfModuleExists{LayoutAndStyle}
\LoadIfModuleExists{Sectioning}
\LoadIfModuleExists{PDFDataAndMetadata}
\LoadIfModuleExists{LicensePage}
\LoadIfModuleExists{Math}
\LoadIfModuleExists{RelativeDirectoryInput}




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




% ===================================================================================== %
%                               Nomenclature Environment                                %
% ===================================================================================== %

\DefineNewLength{\WidestSymbol}         {0pt}        % Will have the value of the widest symbol for spacing
\DefineNewLength{\WidestSymbolTest}     {0pt}        % Used to test for the widest symbol
\DefineNewLength{\NomenclatureTitleSkip}{1em}        % Used for title spacing
\DefineNewLength{\NomenclaturePrintSkip}{1em}        % Used for spacing after nomenclature is printed
\DefineNewLength{\SymbolWidth}          {0em}
\DefineNewLength{\DescriptionWidth}     {0em}
\DefineNewLength{\EntryMarginLeft}      {1em}
\DefineNewLength{\EntryMarginBottom}    {0.25em}
\DefineNewLength{\SymbolMarginRight}    {0.75em}
\DefineNewCounter{SubNomenclature}      {0}    % Number of Subnomenclatures

\newif\ifUWMad@PrintTheNomenclature\UWMad@PrintTheNomenclaturetrue
%
% Global version of the above
\GlobalNewIf{UWMad@PrintMainNomenclature}
\UWMad@PrintMainNomenclaturefalse
%
%
\GlobalNewIf{UWMad@PrintMainNomenclatureTitle}
\UWMad@PrintMainNomenclatureTitlefalse

\newcommand*{\UpdateWidestSymbol}[1]{
    \settowidth{\WidestSymbolTest}{#1}
    \ifdim\WidestSymbol<\WidestSymbolTest
        \setlength{\WidestSymbol}{\WidestSymbolTest}
    \fi
}

\newcommand{\GeneralAdd}[4]{ % #1 = Symbol array name, #2 = Description array name, #3 = symbol, #4 = description
    \ArrayPush{#1}{#3}
    \ArrayPush{#2}{#4}
    \UpdateWidestSymbol{#3}
}

\newcommand{\NomenclatureEntry}[2]{%
    \setstretch{1.1}%
    \hspace{\EntryMarginLeft}%
    \begin{minipage}[t]{\SymbolWidth}%
        #1%
    \end{minipage}%
    \begin{minipage}[t]{\DescriptionWidth}%
        #2%
    \end{minipage}%
    \vskip\EntryMarginBottom
}

\newcommand{\NomenclaturePrint}[3]{% #1 = Nomenclature name, 
                                   % #2 = Symbol array name, 
                                   % #3 = Description array name
                                   %
        \ifnum\ArrayValueCount{#2}>0%
            %
            % Define Symbol minipage width
            \setlength  {\SymbolWidth}{\WidestSymbol}%
            \addtolength{\SymbolWidth}{\SymbolMarginRight}%
            %
            % Define Description minipage width
            \setlength  {\DescriptionWidth}{\textwidth}%
            \addtolength{\DescriptionWidth}{-\SymbolWidth}%
            \addtolength{\DescriptionWidth}{-\EntryMarginLeft}%
            \setlength  {\DescriptionWidth}{0.98\DescriptionWidth}%
            %
            % Print the passed Nomenclature name (which is possibly styled)
            #1
            \ForEach[1]{#2}{%
                \NomenclatureEntry%
                {\ArrayGet{#2}{ForLoopCounter}}%
                {\ArrayGet{#3}{ForLoopCounter}}%
            }%
        \fi%
}

\newcommand{\MainNomenclatureTitle}[2]{%
    \ifUWMad@PrintMainNomenclatureTitle%
        \csname#1\endcsname*{#2}%
        \UWMad@FrontMatterRegister[#1]{#2}% % Couldn't get any of the conditionals to behave globally
    \fi%
}
\newcommand{\SubNomenclatureTitle}[2]{%
    \csname#1\endcsname*{#2}%
    \UWMad@FrontMatterRegister[#1]{#2}% % Couldn't get any of the conditionals to behave globally
}


\newcommand{\TheNomenclatureName}{Nomenclature}
\newcommand{\NomenclatureName}[1]{\renewcommand{\NomenclatureName}{#1}}

% Nomenclature environment ----------------------------------------------------
\newenvironment{Nomenclature}[1][chapter]{
    \UWMad@PrintMainNomenclaturetrue
    \UWMad@PrintMainNomenclatureTitletrue
    \newcommand{\NomenclatureSectionLevel}{#1}
    \ArrayMake{NomenclatureSymbol}
    \ArrayMake{NomenclatureDescription}
    \newcommand{\Add}[2]{\GeneralAdd{NomenclatureSymbol}{NomenclatureDescription}{##1}{##2}}
    \let\item\Add
    \let\Entry\Add
}{%
    \setlength{\NomenclatureTitleSkip}{0em}%
    \setlength{\NomenclaturePrintSkip}{1em}%
    \NomenclaturePrint%
        {\MainNomenclatureTitle%
            {\NomenclatureSectionLevel}%
            {\TheNomenclatureName}%
        }%
        {NomenclatureSymbol}%
        {NomenclatureDescription}%
    \setlength{\WidestSymbol}{0pt}%
    \ArrayClear{NomenclatureSymbol}%
    \ArrayClear{NomenclatureDescription}%
    \UWMad@PrintMainNomenclaturefalse%
    \UWMad@PrintMainNomenclatureTitlefalse
}


% SubNomenclature environment ----------------------------------------------------
\newenvironment{SubNomenclature}[2][section]{%
    \newcommand{\SubNomenclatureSectionLevel}{#1}%
    \addtocounter{SubNomenclature}           {+1}%
    \newcommand*{\TheSubNomenclatureName}    {#2}%
    \ArrayMake{SubNomenclatureSymbol}%
    \ArrayMake{SubNomenclatureDescription}%
    %
    \ifUWMad@PrintMainNomenclature% % This means we're in a Nomenclature Environment
        % Save defintions from Main
        \let\MainAdd\Add%
        \let\MainItem\item%
        \let\MainEntry\Entry%
        %
        % Print the main Nomenclature
        \setlength{\NomenclatureTitleSkip}{0em}%
        \setlength{\NomenclaturePrintSkip}{1em}%
        \NomenclaturePrint%
            {\MainNomenclatureTitle%
                {\NomenclatureSectionLevel}%
                {\TheNomenclatureName}%
            }%
            {NomenclatureSymbol}%
            {NomenclatureDescription}%
        \setlength{\WidestSymbol}{0pt}%
        \ArrayReset{NomenclatureSymbol}%
        \ArrayReset{NomenclatureDescription}%
        \UWMad@PrintMainNomenclatureTitlefalse
        %
        % Put in new definitions
        \renewcommand{\Add}[2]%
            {\GeneralAdd%
                {SubNomenclatureSymbol}%
                {SubNomenclatureDescription}%
                {##1}{##2}%
            }%
    \else
        \newcommand{\Add}[2]%
            {\GeneralAdd%
                {SubNomenclatureSymbol}%
                {SubNomenclatureDescription}%
                {##1}{##2}%
            }%
    \fi
    \let\item\Add%
    \let\Entry\Add%
}{%
    \setlength{\parindent}{0pt}
    \setlength{\NomenclatureTitleSkip}{-0.4em}%
    \setlength{\NomenclaturePrintSkip}{2em}%
    \NomenclaturePrint%
        {\SubNomenclatureTitle%
            {\SubNomenclatureSectionLevel}%
            {\TheSubNomenclatureName}%
        }%
        {SubNomenclatureSymbol}
        {SubNomenclatureDescription}%
    \begin{MakeGlobal}%
        \setlength{\WidestSymbol}{0pt}%
    \end{MakeGlobal}%
    \ArrayClear{SubNomenclatureSymbol}%
    \ArrayClear{SubNomenclatureDescription}%
    \let\Add\MainAdd%
    \let\item\MainItem%
    \let\Entry\MainEntry%
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
