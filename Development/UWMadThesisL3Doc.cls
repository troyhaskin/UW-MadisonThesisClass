\RequirePackage{expl3}[2013/07/28]
\@ifpackagelater{expl3}{2013/07/28} {} {%
    \PackageError{UWMadThesis}{Version of l3kernel is too old}
      {%
        Please install an up to date version of l3kernel\MessageBreak
        using your TeX package manager or from CTAN.
      }%
    \endinput
}%
\ProvidesExplClass
    {UWMadThesisL3Doc}{2014/03/13}{1.0}{Documentation class for UWMadThesis}
\ProcessOptions\relax
\LoadClass[l3doc,full]{UWMadThesis}[2014/04/01]
%
%
%
\geometry{
%    includemp      = true,
    left           = 1.93in,
    right          = 0.25in,
    top            = 1in,
    bottom         = 1in,
    marginparwidth = 1.92in,
    includehead    = true,
    paper          = letterpaper
}
%
%
%
%
%
%
    \int_new:N \g__UWMad_Sectioning_Part_int
    \int_new:N \g__UWMad_Sectioning_Module_int
    \int_new:N \g__UWMad_Sectioning_SubModule_int
    \int_new:N \g__UWMad_Sectioning_SubSubModule_int
    \int_new:N \g__UWMad_Sectioning_Feature_int
    \int_new:N \g__UWMad_Sectioning_SubFeature_int
    \int_new:N \g__UWMad_Sectioning_SubSubFeature_int

    \tl_new:N \g__UWMad_ThePart_tl
    \tl_new:N \g__UWMad_TheModule_tl
    \tl_new:N \g__UWMad_TheSubModule_tl
    \tl_new:N \g__UWMad_TheSubSubModule_tl
    \tl_new:N \g__UWMad_TheFeature_tl
    \tl_new:N \g__UWMad_TheSubFeature_tl
    \tl_new:N \g__UWMad_TheSubSubFeature_tl

    \tl_gset:Nn \g__UWMad_ThePart_tl {
        \int_to_Roman:n{\g__UWMad_Sectioning_Part_int}
    }
    \tl_gset:Nn \g__UWMad_TheModule_tl {
        \int_to_arabic:n{\g__UWMad_Sectioning_Module_int}
    }
    \tl_gset:Nn \g__UWMad_TheSubModule_tl {
        \g__UWMad_TheModule_tl.
        \int_to_arabic:n{\g__UWMad_Sectioning_SubModule_int}
    }
    \tl_gset:Nn \g__UWMad_TheSubSubModule_tl {
        \g__UWMad_TheSubModule_tl.
        \int_to_arabic:n{\g__UWMad_Sectioning_SubSubModule_int}
    }
    \tl_gset:Nn \g__UWMad_TheFeature_tl {
        \int_to_arabic:n{\g__UWMad_Sectioning_Feature_int}
    }
    \tl_gset:Nn \g__UWMad_TheSubFeature_tl {
        \g__UWMad_TheFeature_tl.
        \int_to_arabic:n{\g__UWMad_Sectioning_SubFeature_int}
    }
    \tl_gset:Nn \g__UWMad_TheSubSubFeature_tl {
        \g__UWMad_TheSubFeature_tl.
        \int_to_arabic:n{\g__UWMad_Sectioning_SubSubFeature_int}
    }

%^^A =================================================================== %
%^^A                      Implementation Sectioning                      %
%^^A =================================================================== %
    \cs_new:Nn \__UWMad_Sectioning_Module:nn {
        \clearpage

        \int_incr:N \g__UWMad_Sectioning_Module_int
        \int_set:Nn \g__UWMad_Sectioning_SubModule_int    {0}
        \int_set:Nn \g__UWMad_Sectioning_SubSubModule_int {0}

        \group_begin:
            \phantomsection
            \tex_hbox:D{}
            \skip_vertical:n{2.5em}
            \textbf{
                \Large{
                    Module~\g__UWMad_TheModule_tl
                }
            }
            \skip_vertical:n{1em}
            \textbf{\LARGE{#2}}
        \group_end:
        \addcontentsline{toc}{section}{
            \protect\numberline{\g__UWMad_TheModule_tl}
            #1
        }
        \label{Module:#1}
        \skip_vertical:n{1em}
        \par
    }

    \cs_new:Nn \__UWMad_Sectioning_SubModule:nn {

        \skip_vertical:n {2em}

        \int_set:Nn \g__UWMad_Sectioning_SubSubModule_int {0}
        \int_incr:N \g__UWMad_Sectioning_SubModule_int

        \group_begin:
            \phantomsection
            \tex_hbox:D{}
            \skip_vertical:n{1em}
            \textbf{
                \Large{
                    \g__UWMad_TheSubModule_tl
                    \skip_horizontal:n{0.5em}
                    #2
                }
            }
        \group_end:
        \addcontentsline{toc}{subsection}{
            \protect\numberline{\g__UWMad_TheSubModule_tl}
            #1
        }
        \label{SubModule:#1}
        \skip_vertical:n{0.25em}
        \par
    }

    \cs_new:Nn \__UWMad_Sectioning_SubSubModule:nn {

        \skip_vertical:n {2em}

        \int_incr:N \g__UWMad_Sectioning_SubSubModule_int

        \group_begin:
            \phantomsection
            \tex_hbox:D{}
            \skip_vertical:n{1em}
            \textbf{
                \large{
                    \g__UWMad_TheSubSubModule_tl
                    \skip_horizontal:n{0.5em}
                    #2
                }
            }
        \group_end:
        \addcontentsline{toc}{subsubsection}{
            \protect\numberline{\g__UWMad_TheSubSubModule_tl}
            #1
        }
        \label{SubSubModule:#1}
        \skip_vertical:n{0.25em}
        \par
    }


    \DeclareDocumentCommand \UWModule { o m } {
        \IfNoValueTF {#1} {
            \__UWMad_Sectioning_Module:nn{#2}{#2}
        } {
            \__UWMad_Sectioning_Module:nn{#1}{#2}
        }
    }

    \DeclareDocumentCommand \UWSubModule { o m } {
        \IfNoValueTF {#1} {
            \__UWMad_Sectioning_SubModule:nn{#2}{#2}
        } {
            \__UWMad_Sectioning_SubModule:nn{#1}{#2}
        }
    }

    \DeclareDocumentCommand \UWSubSubModule { o m } {
        \IfNoValueTF {#1} {
            \__UWMad_Sectioning_SubSubModule:nn{#2}{#2}
        } {
            \__UWMad_Sectioning_SubSubModule:nn{#1}{#2}
        }
    }


%^^A =================================================================== %
%^^A                     Implementation Referencing                      %
%^^A =================================================================== %
    \DeclareDocumentCommand \RefModule { o m } {
        \IfNoValueTF {#1} {
            \hyperref[Module:#2]{#2}
        } {
            \hyperref[Module:#2]{#1}
        }
    }
    \DeclareDocumentCommand \RefSubModule { o m } {
        \IfNoValueTF {#1} {
            \hyperref[SubModule:#2]{#2}
        } {
            \hyperref[SubModule:#2]{#1}
        }
    }
    \DeclareDocumentCommand \RefSubSubModule { o m } {
        \IfNoValueTF {#1} {
            \hyperref[SubSubModule:#2]{#2}
        } {
            \hyperref[SubSubModule:#2]{#1}
        }
    }



%^^A =================================================================== %
%^^A                         User Guide Sectioning                       %
%^^A =================================================================== %
    \cs_new:Nn \__UWMad_Sectioning_Feature:nn {
        \clearpage

        \int_incr:N \g__UWMad_Sectioning_Feature_int
        \int_set:Nn \g__UWMad_Sectioning_SubFeature_int    {0}
        \int_set:Nn \g__UWMad_Sectioning_SubSubFeature_int {0}

        \group_begin:
            \phantomsection
            \tex_hbox:D{}
            \skip_vertical:n{2.5em}
            \textbf{
                \Large{
                    Feature~Set~\g__UWMad_TheFeature_tl
                }
            }
            \skip_vertical:n{1em}
            \textbf{\LARGE{#2}}
        \group_end:
        \addcontentsline{toc}{section}{
            \protect\numberline{\g__UWMad_TheFeature_tl}
            #1
        }
        \label{Feature:#1}
        \skip_vertical:n{1em}
        \par
    }

    \cs_new:Nn \__UWMad_Sectioning_SubFeature:nn {

        \int_incr:N \g__UWMad_Sectioning_SubFeature_int
        \int_set:Nn \g__UWMad_Sectioning_SubSubFeature_int {0}

        \group_begin:
            \phantomsection
            \tex_hbox:D{}
            \skip_vertical:n{1em}
            \textbf{
                \Large{
                    \g__UWMad_TheSubFeature_tl
                    \skip_horizontal:n{0.5em}
                    #2
                }
            }
        \group_end:
        \addcontentsline{toc}{subsection}{
            \protect\numberline{\g__UWMad_TheSubFeature_tl}
            #1
        }
        \label{SubFeature:#1}
        \skip_vertical:n{0.25em}
        \par
    }

    \cs_new:Nn \__UWMad_Sectioning_SubSubFeature:nn {

        \int_incr:N \g__UWMad_Sectioning_SubSubFeature_int

        \group_begin:
            \phantomsection
            \tex_hbox:D{}
            \skip_vertical:n{1em}
            \textbf{
                \large{
                    \g__UWMad_TheSubSubFeature_tl
                    \skip_horizontal:n{0.5em}
                    #2
                }
            }
        \group_end:
        \addcontentsline{toc}{subsubsection}{
            \protect\numberline{\g__UWMad_TheSubSubFeature_tl}
            #1
        }
        \label{SubSubFeature:#1}
        \skip_vertical:n{0.25em}
        \par
    }


    \DeclareDocumentCommand \UWFeature { o m } {
        \IfNoValueTF {#1} {
            \__UWMad_Sectioning_Feature:nn{#2}{#2}
        } {
            \__UWMad_Sectioning_Feature:nn{#1}{#2}
        }
    }

    \DeclareDocumentCommand \UWSubFeature { o m } {
        \IfNoValueTF {#1} {
            \__UWMad_Sectioning_SubFeature:nn{#2}{#2}
        } {
            \__UWMad_Sectioning_SubFeature:nn{#1}{#2}
        }
    }

    \DeclareDocumentCommand \UWSubSubFeature { o m } {
        \IfNoValueTF {#1} {
            \__UWMad_Sectioning_SubSubFeature:nn{#2}{#2}
        } {
            \__UWMad_Sectioning_SubSubFeature:nn{#1}{#2}
        }
    }
%
%
%
%^^A =================================================================== %
%^^A                       User Guide Referencing                        %
%^^A =================================================================== %
    \DeclareDocumentCommand \RefFeature { o m } {
        \IfNoValueTF {#1} {
            \hyperref[Feature:#2]{#2}
        } {
            \hyperref[Feature:#2]{#1}
        }
    }
    \DeclareDocumentCommand \RefSubFeature { o m } {
        \IfNoValueTF {#1} {
            \hyperref[SubFeature:#2]{#2}
        } {
            \hyperref[SubFeature:#2]{#1}
        }
    }
    \DeclareDocumentCommand \RefSubSubFeature { o m } {
        \IfNoValueTF {#1} {
            \hyperref[SubSubFeature:#2]{#2}
        } {
            \hyperref[SubSubFeature:#2]{#1}
        }
    }
%
%
%
%
%
%
    \DeclareDocumentCommand   \UWPart { m } {
        \int_incr:N \g__UWMad_Sectioning_Part_int
        \cleardoublepage
        \group_begin:
            \phantomsection
            \tex_hbox:D{}
            \skip_vertical:n{1em}
            \textbf{
                \huge{Part~\g__UWMad_ThePart_tl}
                \skip_vertical:n{1em}
                \Huge{#1}
            }
        \addcontentsline{toc}{part}{
            \protect\numberline{\g__UWMad_ThePart_tl}
            #1
        }
        \group_end:
        \skip_vertical:n{2em}
    }

% Define some lengths for the documentation.
    \setstretch{1.30}
    \setlength{\parindent}{0pt}

    % Play with macrocode env. formatting
    \let\BeginMacroCode\macrocode
    \let\EndMacroCode\endmacrocode

    \renewcommand{\macrocode}{
        \skip_vertical:n {-0.8em}
        %\textsc{macrocode}:
        \BeginMacroCode
        \skip_vertical:n {-1.1em}
        \setlength{\parskip}{0em}
        \setstretch{1.0}
    }
    \renewcommand{\endmacrocode}{
        \EndMacroCode
        \vspace*{0.5em}
    }

    % Define the Usage environment
    \newenvironment{Usage}
        {   \vskip 0.6em
            \textsl{Usage}:
            \begin{list}
                {}
                {   \setstretch{1}
                    \setlength{\topsep}{0em}
                    \setlength{\itemsep}{0em}
                    \setlength{\parsep}{0em}
                    \setlength{\leftmargin}{1em}}}
        {   \end{list}}
%
%
%
%
\cs_undefine:N \TableOfContents
\DeclareDocumentCommand \TableOfContents { } {

    \tl_gset_eq:NN \contentsname \g__UWMad_TOC_Name_TOC_tl

    \group_begin:
        \setstretch{1.05}
        \phantomsection
        \ExplSyntaxOff
            \TableOfContentsDefault
        \ExplSyntaxOn
        \clearpage
    \group_end:
}
%
%
%
%
%
%
\UWMad_Hook_Prepend:Nn \@verbatim {
    \setlength{\topsep}{0pt}
    \setlength{\partopsep}{0pt}
    \setstretch{0.90}
}
\UWMad_Hook_Prepend:Nn \macrocode {
    \skip_vertical:n {1em}
}
