%%
%% This is file `UWMadThesis.dtx',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% UWMadThesis.Implementation.dtx  (with options: `Implementation')
%% UWMadThesis.Implementation.dtx  (with options: `Implementation')
%%
%% -----------------------------------------------------------------------
%% UWMadThesis --- A thesis class for the University of Wisconsin-Madison
%% E-mail: UWMadThesis@hask.in
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% -----------------------------------------------------------------------
%%
%% Copyright (C) 2013 by Troy C. Haskin <UWMadThesis@hask.in>
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%%
%% http://www.latex-project.org/lppl.txt
%%
%% This work is "maintained" (as per LPPL maintenance status) by
%% Troy C. Haskin.
%%
%%
%%  Module Name: Programming
%%  Author:
%%      Name:           Troy C. Haskin
%%      E-mail:         UWMadThesis@hask.in
%%  Version:
%%      Number:         1.0
%%      Description:    Initial release
%%      Date:           06/01/2013
%%  Purpose:
%%      Provide a programming layer for the UW-Madison Thesis package
%%      Most of the module is designed to overcome the lack of such a
%%      layer in LaTeX2e.  Some LaTeX3 is being used for certain advanced
%%      features, and this module may become obsolete when/if it is upgraded
%%      to a pure LaTeX3 implementation.
\newcommand{\GlobalNewIf}[1]{%
    \csgdef{#1true}%
        {\global\cslet{if#1}{\iftrue}}
    \csgdef{#1false}%
        {\global\cslet{if#1}{\iffalse}}
}

\newcommand{\IfCommandExists}[3]{%
    \ifcsname#1\endcsname%
        #2%
    \else%
        #3%
    \fi%
}%
\newcommand{\IfCommandDoesNotExist}[3]{%
    \ifcsname#1\endcsname%
        #3%
    \else%
        #2%
    \fi%
}%

\newcommand{\IfGreaterThanEqualTo}[4]{%
    \ifnum#1>#2%
        #3%
    \else%
        \ifnum#1=#2%
            #3%
        \else%
            #4%
        \fi%
    \fi%
}

\newcommand{\IfLessThanEqualTo}[4]{%
    \ifnum#1<#2%
        #3%
    \else%
        \ifnum#1=#2%
            #3%
        \else%
            #4%
        \fi%
    \fi%
}

\newcommand{\IfStringEmpty}[3]{%
    \ifblank{#1}%
        {#2}%
        {#3}%
}

\newcommand{\IfCommandEmpty}[3]{%
    \ifdefempty{#1}%
        {#2}%
        {#3}%
}

\newcommand{\IfMatch}[4]{% #1 = left compare, #2 = right compare, #3 = true code, #4 = false code
    \if #1 #2%
        #3%
    \else%
        #4%
    \fi%
}

\newcommand{\MakeCommand}[2]{%
    %\IfCommandExists{#1}%
        %{\UWMad@ClassWarning{Command '#1' is already defined; could not redefine.}}%
        %{
        \csgdef{#1}{#2}%}%
}
\newcommand{\ReMakeCommand}[2]{
    \IfCommandExists{#1}%
        {\csgdef{#1}{#2}}%
        {\UWMad@ClassWarning{Command '#1' is undefined; could not define.}}%
}
\newcommand{\MakeFullyExpandedCommand}[2]{%
    \csxdef{#1}{#2}%
}
\newcommand{\MakeExpandedCommand}[2]{%
    \protected@csxdef{#1}{#2}%
}
\newcommand{\CopyCommand}[2]{%
    \cslet{#1}{#2}%
}

\newcommand{\MakeCommandGlobal}[2]{\begin{MakeGlobal}\MakeCommand{#1}{#2}\end{MakeGlobal}}

\newcommand{\MakeCommandUndefined}[1]{% #1 = Command name
    \global\csundef{#1}%
}

\newcommand{\MakeCounterUndefined}[1]{% #1 = Counter name
    \MakeCommandUndefined{#1}
}

\newcommand{\DefineNewLength}[2]{
    \newlength{#1}
    \setlength{#1}{#2}
}

\newcommand{\DefineNewCounter}[2]{
    \newcounter{#1}
    \setcounter{#1}{#2}
}

\newcommand{\UWMad@CounterSuffixLocal} {LOCAL COUNTER}
\newcommand{\UWMad@CounterSuffixGlobal}{GLOBAL COUNTER}

\newcommand{\DefineNewLocalCounter}[2]{%
    \MakeCommand{#1\UWMad@CounterSuffixLocal}{}
    \expandafter\newcount\csname#1\endcsname%
    \csname#1\endcsname=#2%
}

\newcommand{\DefineNewGlobalCounter}[2]{%
    \MakeCommand{#1\UWMad@CounterSuffixGlobal}{}%
    \expandafter\newcount\csname#1\endcsname%
    \csname#1\endcsname=#2%
}

\newcommand{\LocalGlobalHandler}[1]{%
    \IfCommandExists{#1\UWMad@CounterSuffixGlobal}%
        {\let\UWMad@PreCounter\global}%
        {\IfCommandExists{#1\UWMad@CounterSuffixLocal}%
            {\let\UWMad@PreCounter\relax}%
            {\UWMad@ClassWarning{This is not a local or global counter '#1'}}}%
}

\newcommand{\AddToCounter}[2]{
    \LocalGlobalHandler{#1}%
    \expandafter\UWMad@PreCounter\expandafter\advance\csname#1\endcsname #2%
}

\newcommand{\StepCounter}[1]{%
    \AddToCounter{#1}{1}%
}

\newcommand{\SetCounter}[2]{
    \LocalGlobalHandler{#1}%
    \expandafter\UWMad@PreCounter\csname#1\endcsname=#2%
}

\newcommand{\SetAndAddToCounter}[3]{%
    \SetCounter{#1}{#2}%
    \AddToCounter{#1}{#3}%
}

\newcommand{\SetAndStepCounter}[2]{%
    \SetCounter{#1}{#2}%
    \AddToCounter{#1}{1}%
}

\newcommand{\CounterValue}[1]{%
    \the\csuse{#1}%
}

\DefineNewGlobalCounter{WorkCounter}{0}

\newenvironment{MakeGlobal}{\globaldefs=1}{\globaldefs=0}

\def\Show#1{
    {
    \edef\ExpandedArgument{#1}
    \show\ExpandedArgument
    }
}

 \newcommand{\Trim}[1]{\ignorespaces#1\unskip}

\GlobalNewIf{UWMad@IsANumber}
\UWMad@IsANumberfalse

\MakeCommand{UWMad@RegisteredNumber0}{0}
\MakeCommand{UWMad@RegisteredNumber1}{1}
\MakeCommand{UWMad@RegisteredNumber2}{2}
\MakeCommand{UWMad@RegisteredNumber3}{3}
\MakeCommand{UWMad@RegisteredNumber4}{4}
\MakeCommand{UWMad@RegisteredNumber5}{5}
\MakeCommand{UWMad@RegisteredNumber6}{6}
\MakeCommand{UWMad@RegisteredNumber7}{7}
\MakeCommand{UWMad@RegisteredNumber8}{8}
\MakeCommand{UWMad@RegisteredNumber9}{9}

\def\UWMad@NumberTokenizer#1#2\Stop{\def\Head{#1}\def\Tail{#2}}

\newcommand{\UWMad@CheckForNumberCore}[1]{%
    \IfEmpty{#1}%
        {\UWMad@IsANumberfalse}%
        {\expandafter\UWMad@NumberTokenizer#1\Stop\relax%
         \IfEmpty{\Head}%
            {}%
            {\IfCommandExists{UWMad@RegisteredNumber\Head}%
                {\UWMad@IsANumbertrue}%
                {\UWMad@IsANumberfalse}%
             \ifUWMad@IsANumber%
                \IfEmpty{\Tail}%
                    {}%
                    {\UWMad@CheckForNumberCore{\Tail}}%
             \fi}}%
}

\newcommand{\UWMad@CheckForNumber}[1]{%
    %{
    \UWMad@CheckForNumberCore{#1}%
    %}
}

\newcommand{\IfNumber}[3]{%
    \UWMad@CheckForNumber{#1}%
    \ifUWMad@IsANumber%
        #2%
    \else%
        #3%
    \fi%
}

\newcommand{\CSVSuffix}{CSV LIST}

\newcommand{\IfCSVExists}[3]{%
    \IfCommandExists{#1\CSVSuffix}%
    {#2}%
    {#3}%
}

\newcommand{\CSVMake}[1]{ % #1 = List name, #2 = Token to push on to right
    \IfCSVExists{#1}
        {\UWMad@ClassWarning{CSV '#1' already exists.}}
        {\MakeCommand{#1\CSVSuffix}{}}
}

\newcommand{\CSVAppend}[2]{ % #1 = List name, #2 = Token to push on to right
     \IfCSVExists{#1}
        {\ifcsempty{#1\CSVSuffix}
            {\protected@csxdef{#1\CSVSuffix}{#2}}
            {\protected@csxdef{#1\CSVSuffix}{\csuse{#1\CSVSuffix},#2}}}
        {\CSVMake{#1}
         \CSVAppend{#1}{#2}}
}

\newcommand{\CSVPrepend}[2]{ % #1 = List name, #2 = Token to push on to left
     \IfCSVExists{#1}
        {\ifcsempty{#1\CSVSuffix}
            {\protected@csxdef{#1\CSVSuffix}{#2}}
            {\protected@csxdef{#1\CSVSuffix}{#2,\csuse{#1\CSVSuffix}}}}
        {\CSVMake{#1}
         \CSVPrepend{#1}{#2}}
}

\newcommand{\CSVGet}[1]{% #1 = List name, #2 = Token to push on to left
     \IfCSVExists{#1}%
        {\csuse{#1\CSVSuffix}}%
        {}%
}


\DefineNewCounter{ArrayWorkCounter}{0}
\newcommand{\ArraySuffix}         {ARRAY}
\newcommand{\ArraySuffixStart}    {\ArraySuffix START   }
\newcommand{\ArraySuffixEnd}      {\ArraySuffix END     }
\newcommand{\ArraySuffixPosition} {\ArraySuffix POSITION}
\newcommand{\ArraySuffixCount}    {\ArraySuffix COUNT   }

\newcommand{\ArrayMake}[1]{% #1 = Array name
    \MakeCommandGlobal{#1\ArraySuffix}             {#1\ArraySuffix}
    \DefineNewGlobalCounter{#1\ArraySuffixPosition} {0}
    \DefineNewGlobalCounter{#1\ArraySuffixStart}    {1}
    \DefineNewGlobalCounter{#1\ArraySuffixEnd}      {0}
    \DefineNewGlobalCounter{#1\ArraySuffixCount}    {0}
}

\newcommand{\ArrayPosition}[1]{#1\ArraySuffixPosition} % #1 = ArrayName
\newcommand{\ArrayStart}   [1]{#1\ArraySuffixStart}    % #1 = ArrayName
\newcommand{\ArrayEnd}     [1]{#1\ArraySuffixEnd}      % #1 = ArrayName
\newcommand{\ArrayCount}   [1]{#1\ArraySuffixCount}    % #1 = ArrayName
\newcommand{\ArrayNumberPosition}[1]{\csname#1\ArraySuffixPosition\endcsname}  % #1 = ArrayName
\newcommand{\ArrayNumberStart}   [1]{\csname#1\ArraySuffixStart\endcsname}    % #1 = ArrayName
\newcommand{\ArrayNumberEnd}     [1]{\csname#1\ArraySuffixEnd\endcsname}      % #1 = ArrayName
\newcommand{\ArrayNumberCount}   [1]{\csname#1\ArraySuffixCount\endcsname}    % #1 = ArrayName
\newcommand{\ArrayDecrementPosition}[1]{\AddToCounter{\ArrayPosition{#1}}{-1}}
\newcommand{\ArrayDecrementStart}   [1]{\AddToCounter{\ArrayStart   {#1}}{-1}}
\newcommand{\ArrayDecrementEnd}     [1]{\AddToCounter{\ArrayEnd     {#1}}{-1}}
\newcommand{\ArrayDecrementCount}   [1]{\AddToCounter{\ArrayCount   {#1}}{-1}}
\newcommand{\ArrayIncrementPosition}[1]{\AddToCounter{\ArrayPosition{#1}}{+1}}
\newcommand{\ArrayIncrementStart}   [1]{\AddToCounter{\ArrayStart   {#1}}{+1}}
\newcommand{\ArrayIncrementEnd}     [1]{\AddToCounter{\ArrayEnd     {#1}}{+1}}
\newcommand{\ArrayIncrementCount}   [1]{\AddToCounter{\ArrayCount   {#1}}{+1}}
\newcommand{\ArrayValuePosition}[1]{\CounterValue{#1\ArraySuffixPosition}} % #1 = Array name
\newcommand{\ArrayValueStart}   [1]{\CounterValue{#1\ArraySuffixStart}}    % #1 = Array name
\newcommand{\ArrayValueEnd}     [1]{\CounterValue{#1\ArraySuffixEnd}}      % #1 = Array name
\newcommand{\ArrayValueCount}   [1]{\CounterValue{#1\ArraySuffixCount}}    % #1 = Array name
\newcommand{\ArrayUse}[2]{\csuse{#1\ArraySuffix\CounterValue{#2}}}

\newcommand{\ArrayDelete}[1]{% #1 = Array name
    \ForEach{#1}{
        \MakeCommandUndefined{#1\ArraySuffix\CounterValue{ForLoopCounter}}
    }
    \MakeCommandUndefined{#1\ArraySuffix}
    \MakeCounterUndefined{#1\ArraySuffixPosition}
    \MakeCounterUndefined{#1\ArraySuffixStart}
    \MakeCounterUndefined{#1\ArraySuffixEnd}
    \MakeCounterUndefined{#1\ArraySuffixCount}
}

\newcommand{\ArrayReset}[1]{% #1 = Array name
    \ForEach{#1}{
        \MakeCommandUndefined{#1\ArraySuffix\CounterValue{ForLoopCounter}}
    }
    \SetCounter{#1\ArraySuffixPosition} {0}
    \SetCounter{#1\ArraySuffixStart}    {1}
    \SetCounter{#1\ArraySuffixEnd}      {0}
    \SetCounter{#1\ArraySuffixCount}    {0}
}

\newcommand{\ArrayPush}[2]{% #1 = Array name, #2 value to push

    % increment counters
    \ArrayIncrementCount{#1}
    \ArrayIncrementEnd  {#1}

    % Naming scheme for the Array storage commands: <Name>\roman{<Counter>}
    \MakeCommand{#1\ArraySuffix\ArrayValueEnd{#1}}{#2}%
}

\newcommand{\ArrayPop}[1]{% #1 = Array name
    \ifnum\ArrayNumberCount{#1}>0%
        \ArrayUse{#1}{\ArrayEnd{#1}}%
        \MakeCommandUndefined{#1\ArraySuffix\ArrayValueEnd{#1}}%
        % decrement counters
        \ArrayDecrementCount{#1}%
        \ArrayDecrementEnd  {#1}%
    \fi%
}

\newcommand{\ArrayPopAndStore}[2]{% #1 = Array name, #2 name of command to store the popped value
    \ifnum\ArrayNumberCount{#1}>0%
        \MakeExpandedCommand{#2}{\ArrayUse{#1}{\ArrayEnd{#1}}}%
        \MakeCommandUndefined{#1\ArraySuffix\ArrayValueEnd{#1}}%
        % decrement counters
        \ArrayDecrementCount{#1}
        \ArrayDecrementEnd  {#1}
    \fi
}

\newcommand{\ArrayGet}[2]{% #1 = Array name, % 2 = Counter Name for index
    %\IfArrayExists{#1}%
        %{\IfArrayIndexDefined{#1}{#2}%
            %{
            %\ArrayUse{#1}{#2}}%
        %    {\UWMad@ClassWarning{Index for array '#1' is undefined.}}}%
        %{}%
    \csname#1\ArraySuffix\CounterValue{#2}\endcsname
}

\newcommand{\IfArrayIndexDefined}[4]{% #1 = Array name, % #2 = numeric value, % #3 = True code, % #4 = False code
    \IfCommandExists{#1\ArraySuffix\CounterValue{#2}}%
        {#3}%
        {#4}%
}

\newcommand{\IfArrayIndexNotDefined}[4]{% #1 = Array name, % #2 = numeric value, % #3 = True code, % #4 = False code
    \IfCommandExists{#1\ArraySuffix\CounterValue{#2}}%
        {#4}%
        {#3}%
}%

\newcommand{\IfArrayExists}[3]{% #1 = Array name, #2 = True code, #3 = False code
    \IfCommandExists{#1\ArraySuffix}%
        {#2}%
        {#3}%
}%


\ExplSyntaxOn

\DeclareDocumentCommand \HashMake {m}%
    {\prop_new:c {g_UWMad_Hash_#1}}

\DeclareDocumentCommand \HashSet {mmm}%
    {\prop_if_exist:cTF {g_UWMad_Hash_#1}%
      {\prop_gput:cnn   {g_UWMad_Hash_#1}{#2}{#3}}%
        {\HashMake{#1}%
         \prop_gput:cnn {g_UWMad_Hash_#1}{#2}{#3}}}

\DeclareDocumentCommand \HashGet {mm}%
    {\prop_if_exist:cTF  {g_UWMad_Hash_#1}%
        {\prop_get:cn {g_UWMad_Hash_#1} {#2}}
        {}}

\cs_generate_variant:Nn \prop_get:cn {cf}

\DeclareExpandableDocumentCommand \HashExpandableGet {mm}%
    {\prop_if_exist:cTF  {g_UWMad_Hash_#1}%
        {\prop_get:cf {g_UWMad_Hash_#1} {#2}}
        {}}

\DeclareDocumentCommand \HashUnset {mm}%
    {\prop_if_exist:cTF    {g_UWMad_Hash_#1}%
        {\prop_get:cnNTF   {g_UWMad_Hash_#1} {#2} \l_UWMad_Hash_Value_tl%
            {\prop_gdel:cn {g_UWMad_Hash_#1} {#2}}
            {}}}

\DeclareDocumentCommand \IfHashKeySet {mmmm}%
    {\prop_if_exist:cTF {g_UWMad_Hash_#1}%
        {\prop_if_in:cnTF {g_UWMad_Hash_#1} {#2}
            {#3}
            {#4}}
        {}}

\DeclareDocumentCommand \HashDelete {m}%
    {\prop_if_exist:cTF {g_UWMad_Hash_#1}%
        {\prop_gclear:c {g_UWMad_Hash_#1}%
         \cs_undefine:c {g_UWMad_Hash_#1}}
        {}}

\ExplSyntaxOff


\newcommand{\ForLoopRecursion}{}

\DefineNewLocalCounter{ForLoopCounter}{0}

\newcommand{\For}[4][1]{%
    {%
    % Arguments
    %   #1 = increment (optional)
    %   #2 = start value
    %   #3 = end value
    %   #4 = <code>
    % Redefine the command used for recursion
    \renewcommand{\ForLoopRecursion}{%
        #4%                                         % Excute <code>
        \AddToCounter{ForLoopCounter}{#1}%          % Increment the counter
        \For[#1]{\number\ForLoopCounter}{#3}{#4}%   % Recurse
    }%
    %
    % Set the counter to the start value
    % After the recursion begins, #2 is the current value of the counter and not the start value.
    \SetCounter{ForLoopCounter}{#2}%
    %
    % Switch to deal with positive vs. negative increments (decrements).
    \ifnum #1 > 0%                                    % If positive increment
        \IfLessThanEqualTo{\ForLoopCounter}{#3}{%     % Execute while the LoopCounter is less than or equal to the end value
            \ForLoopRecursion%
        }{}%
    \else%                                                   % If negative increment
        \IfGreaterThanEqualTo{\ForLoopCounter}{#3}{%   % Execute while the LoopCounter is greater than or equal to the end value
            \ForLoopRecursion%
        }{}%
    \fi%
    }%
}

\newcommand{\ForEach}[3][1]{
    %
    \IfCommandExists{#2\ArraySuffix}{%
        \For[#1]{\ArrayNumberStart{#2}}{\ArrayNumberEnd{#2}}{#3}%
    }{%
        %\IfCommandExists{#2\HashSuffix}{%
        %    \For[#1]{\ArrayNumberStart{#2\HashSuffixKeys}}{\ArrayNumberEnd{#2\HashSuffixKeys}}{#3}%
        %}{%
            \UWMad@ClassWarning{Could not find Array or Hash named '#2'}%
        %}%
    }%
}
%%
%%  Module Name: Programming
%%  Author:
%%      Name:           Troy C. Haskin
%%      E-mail:         UWMadThesis@hask.in
%%  Version:
%%      Number:         1.0
%%      Description:    Initial release
%%      Date:           06/01/2013
%%  Purpose:
%%      Provide a programming layer for the UW-Madison Thesis package
%%      Most of the module is designed to overcome the lack of such a
%%      layer in LaTeX2e.  Some LaTeX3 is being used for certain advanced
%%      features, and this module may become obsolete when/if it is upgraded
%%      to a pure LaTeX3 implementation.
\newcommand{\GlobalNewIf}[1]{%
    \csgdef{#1true}%
        {\global\cslet{if#1}{\iftrue}}
    \csgdef{#1false}%
        {\global\cslet{if#1}{\iffalse}}
}

\newcommand{\IfCommandExists}[3]{%
    \ifcsname#1\endcsname%
        #2%
    \else%
        #3%
    \fi%
}%
\newcommand{\IfCommandDoesNotExist}[3]{%
    \ifcsname#1\endcsname%
        #3%
    \else%
        #2%
    \fi%
}%

\newcommand{\IfGreaterThanEqualTo}[4]{%
    \ifnum#1>#2%
        #3%
    \else%
        \ifnum#1=#2%
            #3%
        \else%
            #4%
        \fi%
    \fi%
}

\newcommand{\IfLessThanEqualTo}[4]{%
    \ifnum#1<#2%
        #3%
    \else%
        \ifnum#1=#2%
            #3%
        \else%
            #4%
        \fi%
    \fi%
}

\newcommand{\IfStringEmpty}[3]{%
    \ifblank{#1}%
        {#2}%
        {#3}%
}

\newcommand{\IfCommandEmpty}[3]{%
    \ifdefempty{#1}%
        {#2}%
        {#3}%
}

\newcommand{\IfMatch}[4]{% #1 = left compare, #2 = right compare, #3 = true code, #4 = false code
    \if #1 #2%
        #3%
    \else%
        #4%
    \fi%
}

\newcommand{\MakeCommand}[2]{%
    %\IfCommandExists{#1}%
        %{\UWMad@ClassWarning{Command '#1' is already defined; could not redefine.}}%
        %{
        \csgdef{#1}{#2}%}%
}
\newcommand{\ReMakeCommand}[2]{
    \IfCommandExists{#1}%
        {\csgdef{#1}{#2}}%
        {\UWMad@ClassWarning{Command '#1' is undefined; could not define.}}%
}
\newcommand{\MakeFullyExpandedCommand}[2]{%
    \csxdef{#1}{#2}%
}
\newcommand{\MakeExpandedCommand}[2]{%
    \protected@csxdef{#1}{#2}%
}
\newcommand{\CopyCommand}[2]{%
    \cslet{#1}{#2}%
}

\newcommand{\MakeCommandGlobal}[2]{\begin{MakeGlobal}\MakeCommand{#1}{#2}\end{MakeGlobal}}

\newcommand{\MakeCommandUndefined}[1]{% #1 = Command name
    \global\csundef{#1}%
}

\newcommand{\MakeCounterUndefined}[1]{% #1 = Counter name
    \MakeCommandUndefined{#1}
}

\newcommand{\DefineNewLength}[2]{
    \newlength{#1}
    \setlength{#1}{#2}
}

\newcommand{\DefineNewCounter}[2]{
    \newcounter{#1}
    \setcounter{#1}{#2}
}

\newcommand{\UWMad@CounterSuffixLocal} {LOCAL COUNTER}
\newcommand{\UWMad@CounterSuffixGlobal}{GLOBAL COUNTER}

\newcommand{\DefineNewLocalCounter}[2]{%
    \MakeCommand{#1\UWMad@CounterSuffixLocal}{}
    \expandafter\newcount\csname#1\endcsname%
    \csname#1\endcsname=#2%
}

\newcommand{\DefineNewGlobalCounter}[2]{%
    \MakeCommand{#1\UWMad@CounterSuffixGlobal}{}%
    \expandafter\newcount\csname#1\endcsname%
    \csname#1\endcsname=#2%
}

\newcommand{\LocalGlobalHandler}[1]{%
    \IfCommandExists{#1\UWMad@CounterSuffixGlobal}%
        {\let\UWMad@PreCounter\global}%
        {\IfCommandExists{#1\UWMad@CounterSuffixLocal}%
            {\let\UWMad@PreCounter\relax}%
            {\UWMad@ClassWarning{This is not a local or global counter '#1'}}}%
}

\newcommand{\AddToCounter}[2]{
    \LocalGlobalHandler{#1}%
    \expandafter\UWMad@PreCounter\expandafter\advance\csname#1\endcsname #2%
}

\newcommand{\StepCounter}[1]{%
    \AddToCounter{#1}{1}%
}

\newcommand{\SetCounter}[2]{
    \LocalGlobalHandler{#1}%
    \expandafter\UWMad@PreCounter\csname#1\endcsname=#2%
}

\newcommand{\SetAndAddToCounter}[3]{%
    \SetCounter{#1}{#2}%
    \AddToCounter{#1}{#3}%
}

\newcommand{\SetAndStepCounter}[2]{%
    \SetCounter{#1}{#2}%
    \AddToCounter{#1}{1}%
}

\newcommand{\CounterValue}[1]{%
    \the\csuse{#1}%
}

\DefineNewGlobalCounter{WorkCounter}{0}

\newenvironment{MakeGlobal}{\globaldefs=1}{\globaldefs=0}

\def\Show#1{
    {
    \edef\ExpandedArgument{#1}
    \show\ExpandedArgument
    }
}

 \newcommand{\Trim}[1]{\ignorespaces#1\unskip}

\GlobalNewIf{UWMad@IsANumber}
\UWMad@IsANumberfalse

\MakeCommand{UWMad@RegisteredNumber0}{0}
\MakeCommand{UWMad@RegisteredNumber1}{1}
\MakeCommand{UWMad@RegisteredNumber2}{2}
\MakeCommand{UWMad@RegisteredNumber3}{3}
\MakeCommand{UWMad@RegisteredNumber4}{4}
\MakeCommand{UWMad@RegisteredNumber5}{5}
\MakeCommand{UWMad@RegisteredNumber6}{6}
\MakeCommand{UWMad@RegisteredNumber7}{7}
\MakeCommand{UWMad@RegisteredNumber8}{8}
\MakeCommand{UWMad@RegisteredNumber9}{9}

\def\UWMad@NumberTokenizer#1#2\Stop{\def\Head{#1}\def\Tail{#2}}

\newcommand{\UWMad@CheckForNumberCore}[1]{%
    \IfEmpty{#1}%
        {\UWMad@IsANumberfalse}%
        {\expandafter\UWMad@NumberTokenizer#1\Stop\relax%
         \IfEmpty{\Head}%
            {}%
            {\IfCommandExists{UWMad@RegisteredNumber\Head}%
                {\UWMad@IsANumbertrue}%
                {\UWMad@IsANumberfalse}%
             \ifUWMad@IsANumber%
                \IfEmpty{\Tail}%
                    {}%
                    {\UWMad@CheckForNumberCore{\Tail}}%
             \fi}}%
}

\newcommand{\UWMad@CheckForNumber}[1]{%
    %{
    \UWMad@CheckForNumberCore{#1}%
    %}
}

\newcommand{\IfNumber}[3]{%
    \UWMad@CheckForNumber{#1}%
    \ifUWMad@IsANumber%
        #2%
    \else%
        #3%
    \fi%
}

\newcommand{\CSVSuffix}{CSV LIST}

\newcommand{\IfCSVExists}[3]{%
    \IfCommandExists{#1\CSVSuffix}%
    {#2}%
    {#3}%
}

\newcommand{\CSVMake}[1]{ % #1 = List name, #2 = Token to push on to right
    \IfCSVExists{#1}
        {\UWMad@ClassWarning{CSV '#1' already exists.}}
        {\MakeCommand{#1\CSVSuffix}{}}
}

\newcommand{\CSVAppend}[2]{ % #1 = List name, #2 = Token to push on to right
     \IfCSVExists{#1}
        {\ifcsempty{#1\CSVSuffix}
            {\protected@csxdef{#1\CSVSuffix}{#2}}
            {\protected@csxdef{#1\CSVSuffix}{\csuse{#1\CSVSuffix},#2}}}
        {\CSVMake{#1}
         \CSVAppend{#1}{#2}}
}

\newcommand{\CSVPrepend}[2]{ % #1 = List name, #2 = Token to push on to left
     \IfCSVExists{#1}
        {\ifcsempty{#1\CSVSuffix}
            {\protected@csxdef{#1\CSVSuffix}{#2}}
            {\protected@csxdef{#1\CSVSuffix}{#2,\csuse{#1\CSVSuffix}}}}
        {\CSVMake{#1}
         \CSVPrepend{#1}{#2}}
}

\newcommand{\CSVGet}[1]{% #1 = List name, #2 = Token to push on to left
     \IfCSVExists{#1}%
        {\csuse{#1\CSVSuffix}}%
        {}%
}


\DefineNewCounter{ArrayWorkCounter}{0}
\newcommand{\ArraySuffix}         {ARRAY}
\newcommand{\ArraySuffixStart}    {\ArraySuffix START   }
\newcommand{\ArraySuffixEnd}      {\ArraySuffix END     }
\newcommand{\ArraySuffixPosition} {\ArraySuffix POSITION}
\newcommand{\ArraySuffixCount}    {\ArraySuffix COUNT   }

\newcommand{\ArrayMake}[1]{% #1 = Array name
    \MakeCommandGlobal{#1\ArraySuffix}             {#1\ArraySuffix}
    \DefineNewGlobalCounter{#1\ArraySuffixPosition} {0}
    \DefineNewGlobalCounter{#1\ArraySuffixStart}    {1}
    \DefineNewGlobalCounter{#1\ArraySuffixEnd}      {0}
    \DefineNewGlobalCounter{#1\ArraySuffixCount}    {0}
}

\newcommand{\ArrayPosition}[1]{#1\ArraySuffixPosition} % #1 = ArrayName
\newcommand{\ArrayStart}   [1]{#1\ArraySuffixStart}    % #1 = ArrayName
\newcommand{\ArrayEnd}     [1]{#1\ArraySuffixEnd}      % #1 = ArrayName
\newcommand{\ArrayCount}   [1]{#1\ArraySuffixCount}    % #1 = ArrayName
\newcommand{\ArrayNumberPosition}[1]{\csname#1\ArraySuffixPosition\endcsname}  % #1 = ArrayName
\newcommand{\ArrayNumberStart}   [1]{\csname#1\ArraySuffixStart\endcsname}    % #1 = ArrayName
\newcommand{\ArrayNumberEnd}     [1]{\csname#1\ArraySuffixEnd\endcsname}      % #1 = ArrayName
\newcommand{\ArrayNumberCount}   [1]{\csname#1\ArraySuffixCount\endcsname}    % #1 = ArrayName
\newcommand{\ArrayDecrementPosition}[1]{\AddToCounter{\ArrayPosition{#1}}{-1}}
\newcommand{\ArrayDecrementStart}   [1]{\AddToCounter{\ArrayStart   {#1}}{-1}}
\newcommand{\ArrayDecrementEnd}     [1]{\AddToCounter{\ArrayEnd     {#1}}{-1}}
\newcommand{\ArrayDecrementCount}   [1]{\AddToCounter{\ArrayCount   {#1}}{-1}}
\newcommand{\ArrayIncrementPosition}[1]{\AddToCounter{\ArrayPosition{#1}}{+1}}
\newcommand{\ArrayIncrementStart}   [1]{\AddToCounter{\ArrayStart   {#1}}{+1}}
\newcommand{\ArrayIncrementEnd}     [1]{\AddToCounter{\ArrayEnd     {#1}}{+1}}
\newcommand{\ArrayIncrementCount}   [1]{\AddToCounter{\ArrayCount   {#1}}{+1}}
\newcommand{\ArrayValuePosition}[1]{\CounterValue{#1\ArraySuffixPosition}} % #1 = Array name
\newcommand{\ArrayValueStart}   [1]{\CounterValue{#1\ArraySuffixStart}}    % #1 = Array name
\newcommand{\ArrayValueEnd}     [1]{\CounterValue{#1\ArraySuffixEnd}}      % #1 = Array name
\newcommand{\ArrayValueCount}   [1]{\CounterValue{#1\ArraySuffixCount}}    % #1 = Array name
\newcommand{\ArrayUse}[2]{\csuse{#1\ArraySuffix\CounterValue{#2}}}

\newcommand{\ArrayDelete}[1]{% #1 = Array name
    \ForEach{#1}{
        \MakeCommandUndefined{#1\ArraySuffix\CounterValue{ForLoopCounter}}
    }
    \MakeCommandUndefined{#1\ArraySuffix}
    \MakeCounterUndefined{#1\ArraySuffixPosition}
    \MakeCounterUndefined{#1\ArraySuffixStart}
    \MakeCounterUndefined{#1\ArraySuffixEnd}
    \MakeCounterUndefined{#1\ArraySuffixCount}
}

\newcommand{\ArrayReset}[1]{% #1 = Array name
    \ForEach{#1}{
        \MakeCommandUndefined{#1\ArraySuffix\CounterValue{ForLoopCounter}}
    }
    \SetCounter{#1\ArraySuffixPosition} {0}
    \SetCounter{#1\ArraySuffixStart}    {1}
    \SetCounter{#1\ArraySuffixEnd}      {0}
    \SetCounter{#1\ArraySuffixCount}    {0}
}

\newcommand{\ArrayPush}[2]{% #1 = Array name, #2 value to push

    % increment counters
    \ArrayIncrementCount{#1}
    \ArrayIncrementEnd  {#1}

    % Naming scheme for the Array storage commands: <Name>\roman{<Counter>}
    \MakeCommand{#1\ArraySuffix\ArrayValueEnd{#1}}{#2}%
}

\newcommand{\ArrayPop}[1]{% #1 = Array name
    \ifnum\ArrayNumberCount{#1}>0%
        \ArrayUse{#1}{\ArrayEnd{#1}}%
        \MakeCommandUndefined{#1\ArraySuffix\ArrayValueEnd{#1}}%
        % decrement counters
        \ArrayDecrementCount{#1}%
        \ArrayDecrementEnd  {#1}%
    \fi%
}

\newcommand{\ArrayPopAndStore}[2]{% #1 = Array name, #2 name of command to store the popped value
    \ifnum\ArrayNumberCount{#1}>0%
        \MakeExpandedCommand{#2}{\ArrayUse{#1}{\ArrayEnd{#1}}}%
        \MakeCommandUndefined{#1\ArraySuffix\ArrayValueEnd{#1}}%
        % decrement counters
        \ArrayDecrementCount{#1}
        \ArrayDecrementEnd  {#1}
    \fi
}

\newcommand{\ArrayGet}[2]{% #1 = Array name, % 2 = Counter Name for index
    %\IfArrayExists{#1}%
        %{\IfArrayIndexDefined{#1}{#2}%
            %{
            %\ArrayUse{#1}{#2}}%
        %    {\UWMad@ClassWarning{Index for array '#1' is undefined.}}}%
        %{}%
    \csname#1\ArraySuffix\CounterValue{#2}\endcsname
}

\newcommand{\IfArrayIndexDefined}[4]{% #1 = Array name, % #2 = numeric value, % #3 = True code, % #4 = False code
    \IfCommandExists{#1\ArraySuffix\CounterValue{#2}}%
        {#3}%
        {#4}%
}

\newcommand{\IfArrayIndexNotDefined}[4]{% #1 = Array name, % #2 = numeric value, % #3 = True code, % #4 = False code
    \IfCommandExists{#1\ArraySuffix\CounterValue{#2}}%
        {#4}%
        {#3}%
}%

\newcommand{\IfArrayExists}[3]{% #1 = Array name, #2 = True code, #3 = False code
    \IfCommandExists{#1\ArraySuffix}%
        {#2}%
        {#3}%
}%


\ExplSyntaxOn

\DeclareDocumentCommand \HashMake {m}%
    {\prop_new:c {g_UWMad_Hash_#1}}

\DeclareDocumentCommand \HashSet {mmm}%
    {\prop_if_exist:cTF {g_UWMad_Hash_#1}%
      {\prop_gput:cnn   {g_UWMad_Hash_#1}{#2}{#3}}%
        {\HashMake{#1}%
         \prop_gput:cnn {g_UWMad_Hash_#1}{#2}{#3}}}

\DeclareDocumentCommand \HashGet {mm}%
    {\prop_if_exist:cTF  {g_UWMad_Hash_#1}%
        {\prop_get:cn {g_UWMad_Hash_#1} {#2}}
        {}}

\cs_generate_variant:Nn \prop_get:cn {cf}

\DeclareExpandableDocumentCommand \HashExpandableGet {mm}%
    {\prop_if_exist:cTF  {g_UWMad_Hash_#1}%
        {\prop_get:cf {g_UWMad_Hash_#1} {#2}}
        {}}

\DeclareDocumentCommand \HashUnset {mm}%
    {\prop_if_exist:cTF    {g_UWMad_Hash_#1}%
        {\prop_get:cnNTF   {g_UWMad_Hash_#1} {#2} \l_UWMad_Hash_Value_tl%
            {\prop_gdel:cn {g_UWMad_Hash_#1} {#2}}
            {}}}

\DeclareDocumentCommand \IfHashKeySet {mmmm}%
    {\prop_if_exist:cTF {g_UWMad_Hash_#1}%
        {\prop_if_in:cnTF {g_UWMad_Hash_#1} {#2}
            {#3}
            {#4}}
        {}}

\DeclareDocumentCommand \HashDelete {m}%
    {\prop_if_exist:cTF {g_UWMad_Hash_#1}%
        {\prop_gclear:c {g_UWMad_Hash_#1}%
         \cs_undefine:c {g_UWMad_Hash_#1}}
        {}}

\ExplSyntaxOff


\newcommand{\ForLoopRecursion}{}

\DefineNewLocalCounter{ForLoopCounter}{0}

\newcommand{\For}[4][1]{%
    {%
    % Arguments
    %   #1 = increment (optional)
    %   #2 = start value
    %   #3 = end value
    %   #4 = <code>
    % Redefine the command used for recursion
    \renewcommand{\ForLoopRecursion}{%
        #4%                                         % Excute <code>
        \AddToCounter{ForLoopCounter}{#1}%          % Increment the counter
        \For[#1]{\number\ForLoopCounter}{#3}{#4}%   % Recurse
    }%
    %
    % Set the counter to the start value
    % After the recursion begins, #2 is the current value of the counter and not the start value.
    \SetCounter{ForLoopCounter}{#2}%
    %
    % Switch to deal with positive vs. negative increments (decrements).
    \ifnum #1 > 0%                                    % If positive increment
        \IfLessThanEqualTo{\ForLoopCounter}{#3}{%     % Execute while the LoopCounter is less than or equal to the end value
            \ForLoopRecursion%
        }{}%
    \else%                                                   % If negative increment
        \IfGreaterThanEqualTo{\ForLoopCounter}{#3}{%   % Execute while the LoopCounter is greater than or equal to the end value
            \ForLoopRecursion%
        }{}%
    \fi%
    }%
}

\newcommand{\ForEach}[3][1]{
    %
    \IfCommandExists{#2\ArraySuffix}{%
        \For[#1]{\ArrayNumberStart{#2}}{\ArrayNumberEnd{#2}}{#3}%
    }{%
        %\IfCommandExists{#2\HashSuffix}{%
        %    \For[#1]{\ArrayNumberStart{#2\HashSuffixKeys}}{\ArrayNumberEnd{#2\HashSuffixKeys}}{#3}%
        %}{%
            \UWMad@ClassWarning{Could not find Array or Hash named '#2'}%
        %}%
    }%
}
%%
%% Copyright (C) 2013 by Troy C. Haskin <UWMadThesis@hask.in>
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%%
%% http://www.latex-project.org/lppl.txt
%%
%% This work is "maintained" (as per LPPL maintenance status) by
%% Troy C. Haskin.
%%
%%
%% End of file `UWMadThesis.dtx'.
