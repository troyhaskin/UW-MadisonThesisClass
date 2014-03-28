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
    {UWMadThesis}{2013/08/21}{1.0}{LaTeX2e+~Thesis~Class~for~UW-Madison}
\tl_const:Nn \c_UWMad_ClassName_tl        {UWMadThesis}
\tl_const:Nn \c_UWMad_UniversityLong_tl   {University~of~Wisconsin-Madison}
\tl_const:Nn \c_UWMad_UniversityShort_tl  {UW-Madison}
\tl_const:Nn \c_UWMad_ClassVersion_tl     {1.0}
\tl_const:Nn \c_UWMad_ClassVersionDate_tl {2012/01/09}
\cs_new_eq:NN \UWMadClassName    \c_UWMad_ClassName_tl
\cs_new_eq:NN \UWMadClass        \c_UWMad_ClassName_tl
\cs_new_eq:NN \UWMadLong         \c_UWMad_UniversityLong_tl
\cs_new_eq:NN \UWMadShort        \c_UWMad_UniversityShort_tl
\cs_new_eq:NN \UWMadClassVersion \c_UWMad_ClassVersion_tl
\cs_new_eq:NN \UWMadClassDate    \c_UWMad_ClassVersionDate_tl
\tl_new:N   \g_UWMad_ParentClass_tl
\tl_gset:Nn \g_UWMad_ParentClass_tl {report}
\msg_new:nnn{UWMadThesis}{Options/StyleViolation}{
    Option~'#1'~violates~\c_UWMadUniversityShort_tl{}~
    Dissertation~Guidelines;~consider~omission
}
\cs_new:Nn \__UWMad_FrontMatter_StyleWarning:n {
    \msg_warning{UWMadThesis}{Options/StyleViolation}
        {#1}
   \PassOptionsToClass{#1}{\g_UWMad_ParentClass_tl}
}
\cs_new:Nn \__UWMad_ThrowWarnings:NTF {
    \bool_if:NTF \g__UWMad_ThrowWarnings_bool {
        \bool_if:NTF #1 {
            #2
        } {
            #3
        }
    } {}
}
\cs_new:Nn \__UWMad_ThrowWarnings:TF {
    \bool_if:NTF \g__UWMad_ThrowWarnings_bool {
        #1
    } {
        #2
    }
}
\bool_new:N       \g__UWMad_MathTweaks_bool
\bool_gset_true:N \g__UWMad_MathTweaks_bool
\bool_new:N       \g__UWMad_ThrowWarnings_bool
\bool_gset_true:N \g__UWMad_ThrowWarnings_bool
\bool_new:N       \g__UWMad_Hyperlinks_bool
\bool_gset_true:N \g__UWMad_Hyperlinks_bool
\DeclareOption{NoMath} {
    \bool_gset_false:N \g__UWMad_MathTweaks_bool
}
\DeclareOption{NoLinks} {
    \bool_gset_false:N \g__UWMad_Hyperlinks_bool
}
\DeclareOption{Quiet} {
    \bool_gset_false:N \g__UWMad_ThrowWarnings_bool
}
\DeclareOption{a4paper} {
    \__UWMad_ThrowWarnings:TF {
        \__UWMad_FrontMatter_StyleWarning:n {\CurrentOption}
    } { }
}
\DeclareOption{twoside} {
    \__UWMad_ThrowWarnings:TF {
        \__UWMad_FrontMatter_StyleWarning:n {\CurrentOption}
    } { }
}
\DeclareOption{article} {
    \tl_gset:Nn \g_UWMad_ParentClass_tl {article}
}
\DeclareOption{l3doc} {
    \tl_gset:Nn \g_UWMad_ParentClass_tl {l3doc}
    \tl_const:cn {ver@thumbpdf.sty} {}
}
\DeclareOption*{
    \PassOptionsToClass
        {\CurrentOption}{\g_UWMad_ParentClass_tl}
}
\ExecuteOptions{oneside,12pt}
\ProcessOptions\relax
\LoadClass{\g_UWMad_ParentClass_tl}[1995/12/01]
\RequirePackage{xparse}
\RequirePackage{fixltx2e}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{geometry}
\bool_if:NTF \g__UWMad_MathTweaks_bool {
    \RequirePackage{amsmath}
    \RequirePackage{amsfonts}
    \RequirePackage{amssymb}
    \RequirePackage{mathtools}
} { }
\RequirePackage[noabbrev,nameinlink]{cleveref}
\RequirePackage[usenames,dvipsnames,svgnames,table,hyperref]{xcolor}
\RequirePackage{subfig}
\RequirePackage{caption}
\bool_if:NTF \g__UWMad_Hyperlinks_bool {
    \RequirePackage{hyperref}
    \RequirePackage{bookmark}
} {
    \DeclareDocumentCommand \href { o m m } {
        #3
    }
    \cs_gset_eq:NN \phantomsection \relax
}
\msg_new:nnn {UWMadThesis} {Programming/UnregisteredVariable} {
    `#1'~is~not~a~registered~#2.~~The~#2~must~be~defined~
    before~usage~by~the~function~\string\UWMad_#2_DefineLocal:n~or~
    \string\UWMad_#2_DefineGlobal:n.
}
\msg_new:nnn {UWMadThesis} {Programming/Undefined} {
    The~#2~`#1'~is~undefined.~~The~#2~must~be~defined~
    before~usage~by~the~function~\string\UWMad_#2_Define:n.
}
\msg_new:nnn {UWMadThesis} {Programming/Defined} {
    The~#2~`#1'~is~already~defined~and~will~not~altered.
}
\cs_new:Nn \UWMad_Hook_Prepend:nn{
    \cs_new_eq:cc  {#1-Default:} {#1}
    \cs_gset:cn    {#1:}         {#2 \cs:w #1-Default:\cs_end:}
    \cs_undefine:c {#1}
    \cs_new_eq:cc  {#1}          {#1:}
}
\cs_new:Nn \UWMad_Hook_Append:nn{
    \cs_new_eq:cc  {#1-Default:} {#1}
    \cs_gset:cn    {#1:}        {\cs:w #1-Default:\cs_end: #2}
    \cs_undefine:c {#1}
    \cs_new_eq:cc  {#1}          {#1:}
}
\cs_new:Nn \UWMad_Hook_Prepend:Nn{
    \cs_new_eq:cN  {\string#1-Default:} #1
    \cs_gset:cn    {\string#1:}         {#2 \cs:w\string#1-Default:\cs_end:}
    \cs_undefine:N  #1
    \cs_new_eq:Nc   #1          {\string#1:}
}
\cs_new:Nn \UWMad_Hook_Append:Nn{
    \cs_new_eq:cN  {\string#1-Default:} #1
    \cs_gset:cn    {\string#1:}         {\cs:w\string#1-Default:\cs_end: #2}
    \cs_undefine:N  #1
    \cs_new_eq:Nc   #1          {\string#1:}
}
\cs_new:Nn \__UWMad_Definition_Swap:Nn {
    \cs_new_eq:cN  {\string#1-Default:}  #1
    \cs_new:cn     {\string#1-Swap:}    {#2}
    \cs_undefine:N  #1
    \cs_gset_eq:Nc  #1          {\string#1-Swap:}
}
\cs_new:Nn \__UWMad_Definition_Swap:cn {
    \cs_new_eq:cc  {#1-Default:} {#1}
    \cs_new:cn     {#1-Swap:}    {#2}
    \cs_undefine:c {#1}
    \cs_gset_eq:cc {#1}          {#1-Swap:}
}
\cs_new:Nn \UWMad_Definition_Swap:cn {
    \cs_if_exist:cTF {#1} {
        \__UWMad_Definition_Swap:cn{#1}{#2}

        \cs_if_exist:cTF {end#1} {
            \__UWMad_Definition_Swap:cn{end#1}{#2}
        }{}
    } {
        \cs_new:cn {#1} {#2}
    }
}
\cs_new:Nn \UWMad_Definition_Reset:c {
    \cs_if_exist:cTF {#1-Default:} {
        \cs_gset_eq:cc  {#1}          {#1-Default:}
        \cs_undefine:c  {#1-Default:}

        \cs_if_exist:cTF {end#1-Default:} {
            \cs_gset_eq:cc  {#1}          {end#1-Default:}
            \cs_undefine:c  {end#1-Default:}
        }{}
    } {}
}
\cs_new:Nn \UWMad_Definition_Swap:Nn {
    \cs_if_exist:NTF #1 {
        \__UWMad_Definition_Swap:Nn #1 {#2}
    } {
        \cs_new:Nn #1 {#2}
    }
}
\cs_new:Nn \UWMad_Definition_Reset:N {
    \cs_if_exist:cTF {\string#1-Default:} {
        \cs_gset_eq:Nc  #1  {\string#1-Default:}
        \cs_undefine:c      {\string#1-Default:}
    } {}
}
\cs_new:Nn \__UWMad_IfDefined:nnnnT{
    \cs_if_exist:cTF {#1#2#3} {
        #5
    }{
            \msg_error:nnnn
                {UWMadThesis}
                {Programming/Undefined}
                {#2}
                {#4}
    }
}
\cs_new:Nn \__UWMad_IfUndefined:nnnnT{
    \cs_if_free:cTF {#1#2#3} {
        #5
    }{
            \msg_warning:nnnn
                {UWMadThesis}
                {Programming/Defined}
                {#2}
                {#4}
    }
}
\cs_new:Nn \__UWMad_IfDefined:nT{
    \_UWMad_IfDefined:nnnnT{#1}{}{}{command}{#2}
}
\cs_new:Nn \__UWMad_IfUndefined:nT{
    \_UWMad_IfUndefined:nnnnT{#1}{}{}{command}{#2}
}
\cs_new:Nn \__UWMad_IfLocal:nnnTF {
    \cs_if_exist:cTF     {#1#2_Local}{
        #4
    }{
        \cs_if_exist:cTF {#1#2_Global}{
            #5
        }{
            \msg_error:nnnn
                {UWMadThesis}
                {Programming/UnregisteredVariable}
                {#2}
                {#3}
        }
    }
}
\cs_new:Nn \__UWMad_Boolean_IfLocal:nTF {
    \__UWMad_IfLocal:nnnTF
        {g__UWMad_Boolean_}{#1}{Boolean}{#2}{#3}
}
\cs_new:Nn \__UWMad_Boolean_IfUndefined:nnT{
    \__UWMad_IfUndefined:nnnnT
        {g__UWMad_Boolean_}{#1}{#2}{Boolean}{#3}
}
\cs_new:Nn \UWMad_Boolean_DefineLocal:n {
    \__UWMad_Boolean_IfUndefined:nnT {#1} {_Local} {
        \bool_new:c {g__UWMad_Boolean_#1_Local}
    }
}
\cs_new:Nn \UWMad_Boolean_DefineGlobal:n {
    \__UWMad_Boolean_IfUndefined:nnT {#1} {_Global} {
        \bool_new:c {g__UWMad_Boolean_#1_Global}
    }
}
\cs_new:Nn \UWMad_Boolean_DefineLocalSetTrue:n {
    \__UWMad_Boolean_IfUndefined:nnT {#1} {_Local} {
        \bool_new:c       {g__UWMad_Boolean_#1_Local}
        \bool_gset_true:c {g__UWMad_Boolean_#1_Local}
    }
}
\cs_new:Nn \UWMad_Boolean_DefineLocalSetFalse:n {
    \__UWMad_Boolean_IfUndefined:nnT {#1} {_Local} {
        \bool_new:c        {g__UWMad_Boolean_#1_Local}
        \bool_gset_false:c {g__UWMad_Boolean_#1_Local}
    }
}
\cs_new:Nn \UWMad_Boolean_Delete:n {
    \__UWMad_Boolean_IfLocal:nTF {#1} {
        \cs_undefine:c {g__UWMad_Boolean_#1_Local}
    } {
        \cs_undefine:c {g__UWMad_Boolean_#1_Global}
    }
}
\cs_new:Nn \UWMad_Boolean_DefineGlobalSetTrue:n {
    \__UWMad_Boolean_IfUndefined:nnT {#1} {_Global} {
        \bool_new:c       {g__UWMad_Boolean_#1_Global}
        \bool_gset_true:c {g__UWMad_Boolean_#1_Global}
    }
}
\cs_new:Nn \UWMad_Boolean_DefineGlobalSetFalse:n {
    \__UWMad_Boolean_IfUndefined:nnT {#1} {_Global} {
        \bool_new:c        {g__UWMad_Boolean_#1_Global}
        \bool_gset_false:c {g__UWMad_Boolean_#1_Global}
    }
}
\cs_new:Nn \UWMad_Boolean_SetTrue:n {
    \__UWMad_Boolean_IfLocal:nTF {#1} {
        \bool_set_true:c  {g__UWMad_Boolean_#1_Local}
    }{
        \bool_gset_true:c {g__UWMad_Boolean_#1_Global}
    }
}
\cs_new:Nn \UWMad_Boolean_SetFalse:n {
    \__UWMad_Boolean_IfLocal:nTF {#1} {
        \bool_set_false:c  {g__UWMad_Boolean_#1_Local}
    }{
        \bool_gset_false:c {g__UWMad_Boolean_#1_Global}
    }
}
\cs_new:Nn \UWMad_Boolean_IfTrue:nTF {
    \__UWMad_Boolean_IfLocal:nTF {#1} {
        \bool_if:cTF {g__UWMad_Boolean_#1_Local}
    }{
        \bool_if:cTF {g__UWMad_Boolean_#1_Global}
    }
    {#2}
    {#3}
}
\cs_new:Nn \UWMad_Boolean_IfFalse:nTF {
    \__UWMad_Boolean_IfLocal:nTF {#1} {
        \bool_if:cTF {g__UWMad_Boolean_#1_Local}
    }{
        \bool_if:cTF {g__UWMad_Boolean_#1_Global}
    }
    {#3}
    {#2}
}
\cs_new:Nn \__UWMad_Length_IfLocal:nTF {
    \__UWMad_IfLocal:nnnTF
        {g__UWMad_Length_}{#1}{Length}{#2}{#3}
}
\cs_new:Nn \__UWMad_Length_IfUndefined:nnT{
    \__UWMad_IfUndefined:nnnnT{g__UWMad_Length_}{#1}{#2}{Length}{#3}
}
\cs_new:Nn \UWMad_Length_DefineLocal:nn {
    \__UWMad_Length_IfUndefined:nnT {#1} {_Local} {
        \dim_new:c   {g__UWMad_Length_#1_Local}
        \dim_gset:cn {g__UWMad_Length_#1_Local} {#2}
    }
}
\cs_new:Nn \UWMad_Length_DefineGlobal:nn {
    \__UWMad_Length_IfUndefined:nnT {#1} {_Global} {
        \dim_new:c   {g__UWMad_Length_#1_Global}
        \dim_gset:cn {g__UWMad_Length_#1_Global} {#2}
    }
}
\cs_new:Nn \UWMad_Length_Add:nn {
    \__UWMad_Length_IfLocal:nTF {#1} {
        \dim_add:cn  {g__UWMad_Length_#1_Local}  {#2}
    }{
        \dim_gadd:cn {g__UWMad_Length_#1_Global} {#2}
    }
}
\cs_new:Nn \UWMad_Length_Set:nn {
    \__UWMad_Length_IfLocal:nTF {#1} {
        \dim_set:cn  {g__UWMad_Length_#1_Local}  {#2}
    }{
        \dim_gset:cn {g__UWMad_Length_#1_Global} {#2}
    }
}
\cs_new:Nn \UWMad_Length_Of:n {
    \__UWMad_Length_IfLocal:nTF {#1} {
        \dim_use:c {g__UWMad_Length_#1_Local}
    }{
        \dim_use:c {g__UWMad_Length_#1_Global}
    }
}
\cs_new:Nn \UWMad_Length_If:nnnTF {
    \dim_compare:nTF{ \UWMad_Length_Of:n{#1} #2 #3 }{
        #4
    }{
        #5
    }
}
\cs_new:Nn \__UWMad_Counter_IfLocal:nTF {
    \__UWMad_IfLocal:nnnTF
        {g__UWMad_Counter_}{#1}{Counter}{#2}{#3}
}
\cs_new:Nn \__UWMad_Counter_IfUndefined:nnT{
    \__UWMad_IfUndefined:nnnnT{g__UWMad_Counter_}{#1}{#2}{Counter}{#3}
}
\cs_new:Nn \UWMad_Counter_DefineLocal:nn {
    \__UWMad_Counter_IfUndefined:nnT {#1} {_Local} {
        \int_new:c   {g__UWMad_Counter_#1_Local}
        \int_gset:cn {g__UWMad_Counter_#1_Local} {#2}
    }
}
\cs_new:Nn \UWMad_Counter_DefineGlobal:nn {
    \__UWMad_Counter_IfUndefined:nnT {#1} {Global} {
        \int_new:c   {g__UWMad_Counter_#1_Global}
        \int_gset:cn {g__UWMad_Counter_#1_Global} {#2}
    }
}
\cs_new:Nn \UWMad_Counter_Add:nn {
    \__UWMad_Counter_IfLocal:nTF {#1} {
        \int_add:cn  {g__UWMad_Counter_#1_Local}  {#2}
    }{
        \int_gadd:cn {g__UWMad_Counter_#1_Global} {#2}
    }
}
\cs_new:Nn \UWMad_Counter_Step:n {
    \UWMad_Counter_Add:nn{#1}{1}
}
\cs_new:Nn \UWMad_Counter_Set:nn {
    \__UWMad_Counter_IfLocal:nTF {#1} {
        \int_set:cn  {g__UWMad_Counter_#1_Local}  {#2}
    }{
        \int_gset:cn {g__UWMad_Counter_#1_Global} {#2}
    }
}
\cs_new:Nn \UWMad_Counter_SetAndAdd:nnn {
    \UWMad_Counter_Set:nn{#1}{#2}
    \UWMad_Counter_Add:nn{#1}{#3}
}
\cs_new:Nn \UWMad_Counter_SetAndStep:nn {
    \UWMad_Counter_SetAndAdd:nnn {#1}{#2}{1}
}
\cs_new:Nn \UWMad_Counter_Value:n {
    \__UWMad_Counter_IfLocal:nTF {#1} {
        \int_use:c {g__UWMad_Counter_#1_Local}
    }{
        \int_use:c {g__UWMad_Counter_#1_Global}
    }
}
\cs_new:Nn \UWMad_Counter_Compare:nnnTF {
    \int_compare:nTF {\UWMad_Counter_Value:n{#1} #2 #3} {
        #4
    }{
        #5
    }
}
\cs_new:Nn \UWMad_Counter_arabic:n {
    \int_to_arabic:n {\UWMad_Counter_Value:n{#1}}
}
\cs_new:Nn \UWMad_Counter_alpha:n {
    \int_to_alph:n {\UWMad_Counter_Value:n{#1}}
}
\cs_new:Nn \UWMad_Counter_Alpha:n {
    \int_to_Alph:n {\UWMad_Counter_Value:n{#1}}
}
\cs_new:Nn \UWMad_Counter_roman:n {
    \int_to_roman:n {\UWMad_Counter_Value:n{#1}}
}
\cs_new:Nn \UWMad_Counter_Roman:n {
    \int_to_Roman:n {\UWMad_Counter_Value:n{#1}}
}
\cs_new:Nn \__UWMad_CSV_IfDefined:nT {
    \__UWMad_IfDefined:nnnnT{g__UWMad_CSV_}{#1}{}{CSV}{#2}
}
\cs_new:Nn \__UWMad_CSV_IfUndefined:nT{
    \__UWMad_IfUndefined:nnnnT{g__UWMad_CSV_}{#1}{}{CSV}{#2}
}
\cs_new:Nn \UWMad_CSV_Define:n {
    \__UWMad_CSV_IfUndefined:nT {#1} {
        \clist_new:c {g__UWMad_CSV_#1}
    }
}
\cs_new:Nn \UWMad_CSV_Clear:n {
    \__UWMad_CSV_IfDefined:nT {#1} {
        \clist_gclear:c {g__UWMad_CSV_#1}
    }
}
\cs_new:Nn \UWMad_CSV_Delete:n {
    \__UWMad_CSV_IfDefined:nT {#1} {
        \clist_gclear:c {g__UWMad_CSV_#1}
        \cs_undefine:c  {g__UWMad_CSV_#1}
    }
}
\cs_new:Nn \UWMad_CSV_Append:nn {
    \__UWMad_CSV_IfDefined:nT {#1} {
        \clist_gput_right:cn {g__UWMad_CSV_#1} {#2}
    }
}
\cs_new:Nn \UWMad_CSV_Prepend:nn {
    \__UWMad_CSV_IfDefined:nT {#1} {
        \clist_gput_left:cn {g__UWMad_CSV_#1} {#2}
    }
}
\cs_new:Nn \UWMad_CSV_Get:n {
    \__UWMad_CSV_IfDefined:nT {#1} {
        \use:c {g__UWMad_CSV_#1}
    }
}
\cs_new:Nn \UWMad_CSV_IfNotEmpty:nTF {
    \__UWMad_CSV_IfDefined:nT {#1} {
        \clist_if_empty:cTF {g__UWMad_CSV_#1} {
            #3
        }{
            #2
        }
    }
}
\cs_new:Nn \__UWMad_Stack_IfDefined:nT {
    \__UWMad_IfDefined:nnnnT{g__UWMad_Stack_}{#1}{}{Stack}{#2}
}
\cs_new:Nn \__UWMad_Stack_IfUndefined:nT{
    \__UWMad_IfUndefined:nnnnT{g__UWMad_Stack_}{#1}{}{Stack}{#2}
}
\cs_new:Nn \UWMad_Stack_Define:n {
    \__UWMad_Stack_IfUndefined:nT {#1} {
        \tl_new:c {g__UWMad_Stack_#1}
    }
}
\cs_new:Nn \UWMad_Stack_Clear:n {
    \__UWMad_Stack_IfDefined:nT {#1} {
        \tl_gclear:c   {g__UWMad_Stack_#1}
    }
}
\cs_new:Nn \UWMad_Stack_Delete:n {
    \__UWMad_Stack_IfDefined:nT {#1} {
        \tl_gclear:c   {g__UWMad_Stack_#1}
        \cs_undefine:c {g__UWMad_Stack_#1}
    }
}
\cs_new:Nn \UWMad_Stack_Push:nn {
    \__UWMad_Stack_IfDefined:nT {#1} {
        \tl_gput_left:cn {g__UWMad_Stack_#1} {#2}
    }
}
\cs_generate_variant:Nn \tl_head:N { c }
\cs_generate_variant:Nn \tl_tail:N { c }
\cs_new:Nn \UWMad_Stack_Pop:n {
    \__UWMad_Stack_IfDefined:nT {#1} {
        \tl_set:Nf \l_tmpa_tl          {\tl_head:c {g__UWMad_Stack_#1}}
        \tl_set:cf {g__UWMad_Stack_#1} {\tl_tail:c {g__UWMad_Stack_#1}}
        \tl_use:N \l_tmpa_tl
    }
}
\cs_new:Nn \UWMad_Stack_Walk:nn {
    \tl_map_inline:cn {g__UWMad_Stack_#1} {#2}
}
\cs_new:Nn \__UWMad_Queue_IfDefined:nT {
    \__UWMad_IfDefined:nnnnT{g__UWMad_Queue_}{#1}{}{Queue}{#2}
}
\cs_new:Nn \__UWMad_Queue_IfUndefined:nT{
    \__UWMad_IfUndefined:nnnnT{g__UWMad_Queue_}{#1}{}{Queue}{#2}
}
\cs_new:Nn \UWMad_Queue_Define:n {
    \__UWMad_Queue_IfUndefined:nT {#1} {
        \tl_new:c {g__UWMad_Queue_#1}
    }
}
\cs_new:Nn \UWMad_Queue_Clear:n {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \tl_gclear:c {g__UWMad_Queue_#1}
    }
}
\cs_new:Nn \UWMad_Queue_Delete:n {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \tl_gclear:c    {g__UWMad_Queue_#1}
         \cs_undefine:c {g__UWMad_Queue_#1}
    }
}
\cs_new:Nn \UWMad_Queue_Push:nn {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \tl_gput_left:cn {g__UWMad_Queue_#1} {{#2}}
    }
}
\cs_generate_variant:Nn \tl_head:N { c }
\cs_generate_variant:Nn \tl_tail:N { c }
\cs_new:Nn \UWMad_Queue_Pop:n {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \tl_reverse:c   {g__UWMad_Queue_#1}
        \tl_set:Nf \l_tmpa_tl
            {\tl_head:c {g__UWMad_Queue_#1}}
        \tl_set:cf      {g__UWMad_Queue_#1}
            {\tl_tail:c {g__UWMad_Queue_#1}}
        \tl_reverse:c   {g__UWMad_Queue_#1}
        \tl_use:N \l_tmpa_tl
    }
}
\cs_new:Nn \UWMad_Queue_Walk:nn {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \group_begin:
            \tl_reverse:c     {g__UWMad_Queue_#1}
            \tl_map_inline:cn {g__UWMad_Queue_#1} {#2}
        \group_end:
    }
}
\cs_new:Nn \UWMad_Queue_IfEmpty:nTF {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \tl_if_empty:cTF {g__UWMad_Queue_#1}{
            #2
        }{
            #3
        }
    }
}
\cs_new:Nn \__UWMad_Deque_IfDefined:nT {
    \__UWMad_IfDefined:nnnnT{g__UWMad_Deque_}{#1}{}{Deque}{#2}
}
\cs_new:Nn \__UWMad_Deque_IfUndefined:nT{
    \__UWMad_IfUndefined:nnnnT{g__UWMad_Deque_}{#1}{}{Deque}{#2}
}
\cs_new:Nn \UWMad_Deque_Define:n {
    \__UWMad_Deque_IfUndefined:nT {#1} {
        \seq_new:c {g__UWMad_Deque_#1}
    }
}
\cs_new:Nn \UWMad_Deque_Clear:n {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \seq_gclear:c  {g__UWMad_Deque_#1}
    }
}
\cs_new:Nn \UWMad_Deque_Delete:n {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \seq_gclear:c  {g__UWMad_Deque_#1}
        \cs_undefine:c {g__UWMad_Deque_#1}
    }
}
\cs_new:Nn \UWMad_Deque_PushLeft:nn {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \seq_gput_left:cn  {g__UWMad_Deque_#1} {#2}
    }
}
\cs_new:Nn \UWMad_Deque_PushRight:nn {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \seq_gput_right:cn {g__UWMad_Deque_#1} {#2}
    }
}
\cs_new:Nn \UWMad_Deque_PopLeft:n {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \seq_gpop_left:cN  {g__UWMad_Deque_#1} \l_tmpa_tl
        \tl_use:N \l_tmpa_tl
    }
}
\cs_new:Nn \UWMad_Deque_PopRight:n {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \seq_gpop_right:cN {g__UWMad_Deque_#1} \l_tmpa_tl
        \tl_use:N \l_tmpa_tl
    }
}
\cs_new:Nn \UWMad_Deque_WalkLeftToRight:nn {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \seq_map_inline:cn {g__UWMad_Deque_#1} {#2}
    }
}
\cs_generate_variant:Nn \seq_reverse:N {c}
\cs_new:Nn \UWMad_Deque_WalkRightToLeft:nn {
    \__UWMad_Deque_IfDefined:nT {#1} {
        \group_begin:
            \seq_reverse:c     {g__UWMad_Deque_#1}
            \seq_map_inline:cn {g__UWMad_Deque_#1} {#2}
        \group_end:
    }
}
\cs_generate_variant:Nn \prop_gput:Nnn   { c x n   }
\cs_generate_variant:Nn \prop_if_in:NnTF { c x TF  }
\cs_generate_variant:Nn \prop_if_in:NnTF { c f TF  }
\cs_generate_variant:Nn \prop_get:Nn     { c x     }
\cs_generate_variant:Nn \prop_get:Nn     { c f     }
\cs_generate_variant:Nn \prop_get:NnNTF  { c x N TF}
\cs_generate_variant:Nn \prop_gremove:Nn { c x     }
\cs_new:Nn \__UWMad_Hash_IfDefined:nT {
    \__UWMad_IfDefined:nnnnT{g__UWMad_Hash_}{#1}{}{Hash}{#2}
}
\cs_new:Nn \__UWMad_Hash_IfUndefined:nT{
    \__UWMad_IfUndefined:nnnnT{g__UWMad_Hash_}{#1}{}{Hash}{#2}
}
\cs_new:Nn \UWMad_Hash_Define:n {
    \__UWMad_Hash_IfUndefined:nT {#1} {
        \prop_new:c {g__UWMad_Hash_#1}
    }
}
\cs_new:Nn \UWMad_Hash_Set:nnn {
    \__UWMad_Hash_IfDefined:nT {#1} {
        \prop_gput:cxn {g__UWMad_Hash_#1}{#2}{#3}
    }
}
\cs_generate_variant:Nn \prop_get:cn {cf}
\cs_new:Nn \UWMad_Hash_Get:nn {
    \__UWMad_Hash_IfDefined:nT {#1} {
        \prop_get:cf {g__UWMad_Hash_#1}{#2}
    }
}
\cs_new:Nn \UWMad_Hash_Unset:nn {
    \__UWMad_Hash_IfDefined:nT {#1} {
        \prop_gremove:cx {g__UWMad_Hash_#1} {#2}
    }
}
\cs_generate_variant:Nn \tl_to_lowercase:n {f}
\cs_new:Nn \UWMad_Hash_IfKeySet:nnTF {
    \__UWMad_Hash_IfDefined:nT {#1} {
        \prop_if_in:cfTF {g__UWMad_Hash_#1} {\tl_trim_spaces:n{#2}} {
            #3
        }{
            #4
        }
    }
}
\cs_new:Nn \UWMad_Hash_Walk:nn {
    \__UWMad_Hash_IfDefined:nT {#1} {
        \prop_map_inline:cn {g__UWMad_Hash_#1} {#2}
    }
}
\cs_new:Nn \UWMad_Hash_Delete:n {
    \__UWMad_Hash_IfDefined:nT {#1} {
        \prop_gclear:c {g__UWMad_Hash_#1}
        \cs_undefine:c {g__UWMad_Hash_#1}
    }
}
\DeclareDocumentCommand \LoadUtilityAPI { } {
\DeclareDocumentCommand \IfCommandExists { m +m +m }{
    \cs_if_exist:cTF {##1}{
        ##2
    }{
        ##3
    }
}
\DeclareDocumentCommand \IfCommandDoesNotExist { m +m +m }{
    \cs_if_free:cTF {##1}{
        ##2
    }{
        ##3
    }
}
\DeclareDocumentCommand \IfStringEmpty { m +m +m }{
    \tl_if_blank:nTF {##1}{
        ##2
    }{
        ##3
    }
}
\DeclareDocumentCommand \IfCommandEmpty { m +m +m }{
    \tl_if_blank:oTF{##1}{
        ##2
    }{
        ##3
    }
}
}
\DeclareDocumentCommand \LoadCommandAPI { } {
\DeclareDocumentCommand \MakeCommand { O{} m +m } {
    \cs_if_free:cTF {##2} {
        \cs_set:cpn {##2} ##1 {##3}
    }{
        \msg_warning:nnnn
            {UWMadThesis}{Programming/Defined}{##2}{command}
    }
}
\DeclareDocumentCommand \ReMakeCommand { O{} m +m }{
    \cs_if_exist:cTF {##2} {
        \cs_set:cpn {##2} ##1 {##3}
    }{
        \msg_error:nnnn
            {UWMadThesis}{Programming/Undefined}{##2}{command}
    }
}
\DeclareDocumentCommand \MakeGlobalCommand { O{} +m m } {
    \cs_gset:cpn {##2} ##1 {##3}
}
\DeclareDocumentCommand \MakeExpandedCommand { O{} m +m } {
    \cs_get:cpx {##2} ##1 {##3}
}
\DeclareDocumentCommand \MakeCommandUndefined { m } {
    \cs_undefine:c {##1}
}
\DeclareDocumentCommand \CopyCommand { m m } {
    \cs_if_free:cTF {##1} {
        \cs_if_free:cTF {##2} {
            \cs_gset_eq:cc {##2}{##1}
        }{
            \msg_warning:nnnn
                {UWMadThesis}{Programming/Defined}{##2}{command}
        }
    }{
        \msg_warning:nnnn
            {UWMadThesis}{Programming/Defined}{##1}{command}
    }
}
}
\DeclareDocumentCommand \LoadTypesAPI { } {
\cs_gset_eq:NN
    \BooleanDefineLocal             \UWMad_Boolean_DefineLocal:n
\cs_gset_eq:NN
    \BooleanDefineGlobal            \UWMad_Boolean_DefineGlobal:n
\cs_gset_eq:NN
    \BooleanDefineLocalAndSetTrue   \UWMad_Boolean_DefineLocalAndSetTrue:n
\cs_gset_eq:NN
    \BooleanDefineLocalAndSetFalse  \UWMad_Boolean_DefineLocalAndSetFalse:n
\cs_gset_eq:NN
    \BooleanDefineGlobalAndSetTrue  \UWMad_Boolean_DefineGlobalAndSetTrue:n
\cs_gset_eq:NN
    \BooleanDefineGlobalAndSetFalse \UWMad_Boolean_DefineGlobalAndSetFalse:n
\cs_gset_eq:NN
    \BooleanSetTrue                 \UWMad_Boolean_SetTrue:n
\cs_gset_eq:NN
    \BooleanSetFalse                \UWMad_Boolean_SetFalse:n
\cs_gset_eq:NN
    \BooleanSetIfTrue               \UWMad_Boolean_SetIfTrue:nTF
\cs_gset_eq:NN
    \BooleanSetIfFalse              \UWMad_Boolean_SetIfFalse:nTF
\cs_gset_eq:NN \LengthDefineLocal   \UWMad_Length_DefineLocal:nn
\cs_gset_eq:NN \LengthDefineGlobal  \UWMad_Length_DefineGlobal:nn
\cs_gset_eq:NN \LengthAdd           \UWMad_Length_Add:nn
\cs_gset_eq:NN \LengthSet           \UWMad_Length_Set:nn
\cs_gset_eq:NN \LengthOf            \UWMad_Length_Of:n
\cs_gset_eq:NN \LengthIf            \UWMad_Length_If:nTF
\cs_gset_eq:NN \CounterDefineLocal  \UWMad_Counter_DefineLocal:nn
\cs_gset_eq:NN \CounterDefineGlobal \UWMad_Counter_DefineGlobal:nn
\cs_gset_eq:NN \CounterAdd          \UWMad_Counter_Add:nn
\cs_gset_eq:NN \CounterStep         \UWMad_Counter_Step:n
\cs_gset_eq:NN \CounterSet          \UWMad_Counter_Set:nn
\cs_gset_eq:NN \CounterSetAndAdd    \UWMad_Counter_SetAndAdd:nn
\cs_gset_eq:NN \CounterSetAndStep   \UWMad_Counter_SetAndStep:nn
\cs_gset_eq:NN \CounterValue        \UWMad_Counter_Value:n
\cs_gset_eq:NN \CounterIf           \UWMad_Counter_If:nTF
\cs_gset_eq:NN \CounterCompare      \UWMad_Counter_Compare:nnnTF
\cs_gset_eq:NN \CounterArabic       \UWMad_Counter_arabic:n
\cs_gset_eq:NN \CounterAlpha        \UWMad_Counter_alpha:n
\cs_gset_eq:NN \CounterALPHA        \UWMad_Counter_Alpha:n
\cs_gset_eq:NN \CounterRoman        \UWMad_Counter_roman:n
\cs_gset_eq:NN \CounterROMAN        \UWMad_Counter_Roman:n
}
    \geometry{
        margin      = 1.0in,
        includehead = true,
        paper       = letterpaper
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
\definecolor{UWMadGreen}{rgb}{0,0.7,0}
\hypersetup {
    colorlinks         = true       ,
    linkcolor          = blue       ,
    citecolor          = UWMadGreen ,
    urlcolor           = violet     ,
    pdfdisplaydoctitle = true       ,
    pdfview            = {FitH}     ,
    pdfstartview       = {FitH}     ,
    pdfpagelayout      = OneColumn  ,
    plainpages         = false      ,
    hypertexnames      = true       ,
    bookmarksopenlevel = 1          ,
    bookmarksopen      = true       ,
    unicode            = true
}
\pagestyle{myheadings}
\pagenumbering{roman}
\doublespacing
\setlength{\parindent}{ 0pt}
\setlength{\parskip}  {10pt}
\setlength{\headsep}  {15pt}
\cs_gset_eq:NN \UWMad_Sectioning_DefaultChapter: \@chapter
\cs_new:Nn \UWMad_Sectioning_Chapter: {
    \thispagestyle{myheadings}
    \int_compare:nNnTF {\value{chapter}} = {0} {
        \pagenumbering{arabic}
    } { }
    \UWMad_Sectioning_DefaultChapter:
}
\cs_gset_eq:NN \@chapter \UWMad_Sectioning_Chapter:
\int_new:N  \g__UWMad_Appendix_Counter_int
\int_set:Nn \g__UWMad_Appendix_Counter_int {0}
\cs_new:Nn \__UWMad_Appendix_Initialize:{
    \par
    \setcounter{section}{0}
    \cs_gset_eq:NN \@chapapp \appendixname
    \cs_gset:Npn \thechapter {
        \int_to_Alph:n {
            \g__UWMad_Appendix_Counter_int
        }
    }
}
\cs_undefine:N \appendix
\DeclareDocumentCommand \appendix { s o m } {

    \int_compare:nNnTF {\g__UWMad_Appendix_Counter_int} = {0} {
        \__UWMad_Appendix_Initialize:
    } { }
    \int_gincr:N \g__UWMad_Appendix_Counter_int

    \IfBooleanTF { #1 } {
        \chapter*{#3}
    } {
        \IfNoValueTF { #2 } {
            \chapter[#3]{#3}
        } {
            \chapter[#2]{#3}
        }
    }
}
\int_new:N \g__UWMad_FrontMatter_Counter_int
\cs_new:Nn \__UWMad_FrontMatter_Register:nn {
    \addcontentsline{toc}{#1}{#2}
    \int_gincr:N \g__UWMad_FrontMatter_Counter_int
}
\tl_new:N   \g__UWMad_FrontMatter_Title_Dedications_tl
\tl_new:N   \g__UWMad_FrontMatter_Title_Acknowledgments_tl
\tl_new:N   \g__UWMad_FrontMatter_Title_Abstract_tl
\tl_new:N   \g__UWMad_FrontMatter_Title_UMIAbstract_tl
\tl_new:N   \g__UWMad_FrontMatter_Title_Preface_tl
\tl_gset:Nn \g__UWMad_FrontMatter_Title_Dedications_tl
    {Dedications}
\tl_gset:Nn \g__UWMad_FrontMatter_Title_Acknowledgments_tl
    {Acknowledgments}
\tl_gset:Nn \g__UWMad_FrontMatter_Title_Abstract_tl
    {Abstract}
\tl_gset:Nn \g__UWMad_FrontMatter_Title_UMIAbstract_tl
    {Abstract}
\tl_gset:Nn \g__UWMad_FrontMatter_Title_Preface_tl
    {Preface}
\cs_undefine:N \abstract
\cs_undefine:N \endabstract

\DeclareDocumentCommand \dedications { g } {
    \IfNoValueTF { #1 } { } {
        \tl_gset:Nn \g__UWMad_FrontMatter_Name_Dedications_tl
            {#1}
    }
    \chapter*{\g__UWMad_FrontMatter_Name_Dedications_tl}
    \__UWMad_FrontMatter_Register:nn {chapter} {
        \g__UWMad_FrontMatter_Name_Dedications_tl
    }
}
\DeclareDocumentCommand \acknowledgments { g } {
    \IfNoValueTF { #1 } { } {
        \tl_gset:Nn \g__UWMad_FrontMatter_Name_Acknowledgments_tl
            {#1}
    }
    \chapter*{\g__UWMad_FrontMatter_Name_Acknowledgments_tl}
    \__UWMad_FrontMatter_Register:nn {chapter} {
        \g__UWMad_FrontMatter_Name_Acknowledgments_tl
    }
}
\DeclareDocumentCommand \abstract { g } {
    \IfNoValueTF { #1 } { } {
        \tl_gset:Nn \g__UWMad_FrontMatter_Name_Abstract_tl
            {#1}
    }
    \chapter*{\g__UWMad_FrontMatter_Name_Abstract_tl}
    \__UWMad_FrontMatter_Register:nn {chapter} {
        \g__UWMad_FrontMatter_Name_Abstract_tl
    }
}
\DeclareDocumentCommand \umiabstract { g } {
    \IfNoValueTF { #1 } { } {
        \tl_gset:Nn \g__UWMad_FrontMatter_Name_UMIAbstract_tl
            {#1}
    }
    \chapter*{\g__UWMad_FrontMatter_Name_UMIAbstract_tl}
    \__UWMad_FrontMatter_Register:nn {chapter} {
        \g__UWMad_FrontMatter_Name_UMIAbstract_tl
    }
}
\DeclareDocumentCommand \preface { g } {
    \IfNoValueTF { #1 } { } {
        \tl_gset:Nn \g__UWMad_FrontMatter_Name_Preface_tl
            {#1}
    }
    \chapter*{\g__UWMad_FrontMatter_Name_Preface_tl}
    \__UWMad_FrontMatter_Register:nn {chapter} {
        \g__UWMad_FrontMatter_Name_Preface_tl
    }
}
\cs_gset_eq:NN \UWMad_TOC_Default_TableOfContents: \tableofcontents
\cs_gset_eq:NN \UWMad_TOC_Default_ListOfTables:    \listoftables
\cs_gset_eq:NN \UWMad_TOC_Default_ListOfFigures:   \listoffigures
\cs_undefine:N \tableofcontents
\cs_undefine:N \listoftables
\cs_undefine:N \listoffigures
\tl_new:N   \g__UWMad_TOC_Name_TOC_tl
\tl_new:N   \g__UWMad_TOC_Name_LOT_tl
\tl_new:N   \g__UWMad_TOC_Name_LOF_tl
\tl_gset:Nn \g__UWMad_TOC_Name_TOC_tl {Table~of~Contents}
\tl_gset:Nn \g__UWMad_TOC_Name_LOT_tl {List~of~Tables}
\tl_gset:Nn \g__UWMad_TOC_Name_LOF_tl {List~of~Figures}
\DeclareDocumentCommand \tableofcontents { } {

    \cs_gset_eq:NN \contentsname \g__UWMad_TOC_Name_TOC_tl

    \group_begin:
        \setstretch{1.05}
        \phantomsection
        \__UWMad_FrontMatter_Register:nn
            {chapter}
            {\contentsname}
        \TableOfContentsDefault
        \clearpage
    \group_end:
}
\DeclareDocumentCommand \listoftables { } {

    \cs_set_eq:NN \listtablename \g__UWMad_TOC_Name_LOT_tl

    \group_begin:
        \setstretch{1.05}
        \__UWMad_FrontMatter_Register:nn
            {chapter}
            {\listtablename}
        \ListOfTablesDefault
        \clearpage
    \group_end:
}
\DeclareDocumentCommand \listoffigures { } {

    \cs_set_eq:NN \listfigurename \g__UWMad_TOC_Name_LOF_tl

    \group_begin:
        \setstretch{1.05}
        \__UWMad_FrontMatter_Register:nn
            {chapter}
            {\listfigurename}
        \ListOfFiguresDefault
        \clearpage
    \group_end:
}
\cs_set_eq:NN \TableOfContents \tableofcontents
\cs_set_eq:NN \ListOfTables    \listoftables
\cs_set_eq:NN \ListOfFigures   \listoffigures
\DeclareDocumentCommand \TableOfContentsName { m } {
    \tl_gset:Nn \g__UWMad_TOC_Name_TOC_tl {#1}
}
\DeclareDocumentCommand \ListOfTablesName { m } {
    \tl_gset:Nn \g__UWMad_TOC_Name_LOT_tl {#1}
}
\DeclareDocumentCommand \ListOfFiguresName { m } {
    \tl_gset:Nn \g__UWMad_TOC_Name_LOF_tl {#1}
}
\tl_const:Nn \c__UWMad_SectionsLevel_part_tl            {-1}
\tl_const:Nn \c__UWMad_SectionsLevel_chapter_tl         {0}
\tl_const:Nn \c__UWMad_SectionsLevel_section_tl         {1}
\tl_const:Nn \c__UWMad_SectionsLevel_subsection_tl      {2}
\tl_const:Nn \c__UWMad_SectionsLevel_subsubsection_tl   {3}
\tl_const:Nn \c__UWMad_SectionsLevel_paragraph_tl       {4}
\tl_const:Nn \c__UWMad_SectionsLevel_subparagraph_tl    {5}
\msg_new:nnn { UWMadThesis } { Sectioning / UndefinedSection } {
    Undefined~section~'#1'~used.
}
\cs_new:Nn \UWMad_IfSectionExists:nT {
    \tl_if_exist:cTF {c__UWMad_SectionsLevel_ #1 _tl} {
        #2
    } {
        \msg_error:nnn
            { UWMadThesis }
            { Sectioning / UndefinedSection }
            {#1}
    }
}
\tl_const:cn {c__UWMad_LevelsSection_-1_tl} {part}
\tl_const:cn {c__UWMad_LevelsSection_ 0_tl} {chapter}
\tl_const:cn {c__UWMad_LevelsSection_ 1_tl} {section}
\tl_const:cn {c__UWMad_LevelsSection_ 2_tl} {subsection}
\tl_const:cn {c__UWMad_LevelsSection_ 3_tl} {subsubsection}
\tl_const:cn {c__UWMad_LevelsSection_ 4_tl} {paragraph}
\tl_const:cn {c__UWMad_LevelsSection_ 5_tl} {subparagraph}
\tl_const:Nn \c__UWMad_NextSection_part_tl            {chapter}
\tl_const:Nn \c__UWMad_NextSection_chapter_tl         {section}
\tl_const:Nn \c__UWMad_NextSection_section_tl         {subsection}
\tl_const:Nn \c__UWMad_NextSection_subsection_tl      {subsubsection}
\tl_const:Nn \c__UWMad_NextSection_subsubsection_tl   {paragraph}
\tl_const:Nn \c__UWMad_NextSection_paragraph_tl       {subparagraph}
\tl_const:Nn \c__UWMad_PreviousSection_chapter_tl         {part}
\tl_const:Nn \c__UWMad_PreviousSection_section_tl         {chapter}
\tl_const:Nn \c__UWMad_PreviousSection_subsection_tl      {section}
\tl_const:Nn \c__UWMad_PreviousSection_subsubsection_tl   {subsection}
\tl_const:Nn \c__UWMad_PreviousSection_paragraph_tl       {subsubsection}
\tl_const:Nn \c__UWMad_PreviousSection_subparagraph_tl    {paragraph}
\cs_new:Nn \UWMad_SectionToLevel:n {
    \UWMad_IfSectionExists:nT {#1} {
        \tl_use:c {c__UWMad_SectionsLevel_ #1 _tl}
    }
}
\cs_new:Nn \UWMad_LevelToSection:n {
    \UWMad_IfSectionExists:nT {#1} {
        \tl_use:c {c__UWMad_LevelsSection_ #1 _tl}
    }
}
\cs_new:Nn \UWMad_NextSection:n {
    \UWMad_IfSectionExists:nT {#1} {
        \tl_use:c {c__UWMad_NextSection_ #1 _tl}
    }
}
\cs_new:Nn \UWMad_PreviousSection:n {
    \UWMad_IfSectionExists:nT {#1} {
        \tl_use:c {c__UWMad_PreviousSection_ #1 _tl}
    }
}
\tex_everydisplay:D \exp_after:wN {
    \tex_the:D \tex_everydisplay:D
    \cs_set_eq:NN \frac \dfrac
}
\tl_new:N   \g_UWMad_Math_derivSymbol_tl
\tl_gset:Nn \g_UWMad_Math_derivSymbol_tl   {\mathrm{d}}
\tl_new:N   \g_UWMad_Math_pderivSymbol_tl
\tl_gset:Nn \g_UWMad_Math_pderivSymbol_tl  {\partial}
\tl_new:N   \g_UWMad_Math_tderivSymbol_tl
\tl_gset:Nn \g_UWMad_Math_tderivSymbol_tl  {\mathrm{D}}
\tl_new:N   \g_UWMad_Math_DelimiterDefaultLeft_tl
\tl_gset:Nn \g_UWMad_Math_DelimiterDefaultLeft_tl  {[}
\tl_new:N   \g_UWMad_Math_DelimiterDefaultRight_tl
\tl_gset:Nn \g_UWMad_Math_DelimiterDefaultRight_tl {]}
\tl_new:N   \l_UWMad_Math_DelimiterLeft_tl
\tl_new:N   \l_UWMad_Math_DelimiterRight_tl
\DeclareDocumentCommand \derivSymbol { } {
    \g_UWMad_Math_derivSymbol_tl
}
\DeclareDocumentCommand \pderivSymbol { } {
    \g_UWMad_Math_pderivSymbol_tl
}
\DeclareDocumentCommand \tderivSymbol { } {
    \g_UWMad_Math_tderivSymbol_tl
}
\DeclareDocumentCommand \derivSymbolChange { m } {
    \tl_set:Nn \g_UWMad_Math_derivSymbol_tl {#1}
}
\DeclareDocumentCommand \pderivSymbolChange { m } {
    \tl_set:Nn \g_UWMad_Math_pderivSymbol_tl {#1}
}
\DeclareDocumentCommand \tderivSymbolChange { m } {
    \tl_set:Nn \g_UWMad_Math_tderivSymbol_tl {#1}
}
\DeclareDocumentCommand \derivSymbolChangeDefault { m } {
    \tl_gset:Nn \g_UWMad_Math_derivSymbol_tl {#1}
}
\DeclareDocumentCommand \pderivSymbolChangeDefault { m } {
    \tl_gset:Nn \g_UWMad_Math_pderivSymbol_tl {#1}
}
\DeclareDocumentCommand \tderivSymbolChangeDefault { m } {
    \tl_gset:Nn \g_UWMad_Math_tderivSymbol_tl {#1}
}
\DeclareDocumentCommand \DelimiterChangeDefault { m m } {
    \tl_gset:Nn  \g_UWMad_Math_DelimiterDefaultLeft_tl  {#1}
    \tl_gset:Nn  \g_UWMad_Math_DelimiterDefaultRight_tl {#2}
}
\DeclareDocumentCommand \DerivativeGeneral { +m +m m m } {
    \frac{ #4^{#3} #1      }
         { #4      #2^{#3} }
}
\DeclareDocumentCommand \DerivativeGeneralBig { +m +m m m m m} {

    \IfNoValueTF {#5} {
        \tl_set_eq:NN
            \l_UWMad_Math_DelimiterLeft_tl
            \g_UWMad_Math_DelimiterDefaultLeft_tl
    } {
        \tl_set:Nn \l_UWMad_Math_DelimiterLeft_tl {#5}
    }

    \IfNoValueTF {#6} {
        \tl_set_eq:NN
            \l_UWMad_Math_DelimiterRight_tl
            \g_UWMad_Math_DelimiterDefaultRight_tl
    } {
        \tl_set:Nn \l_UWMad_Math_DelimiterRight_tl {#6}
    }

    \frac{ #4^{#3}    }
         { #4 #2^{#3} }
    \!\!
    \left\l_UWMad_Math_DelimiterLeft_tl
        #1
    \right\l_UWMad_Math_DelimiterRight_tl
}
\DeclareDocumentCommand \deriv { +m +m G{} } {
    \DerivativeGeneral
        {#1}{#2}{#3}{\derivSymbol}
}
\DeclareDocumentCommand \pderiv { +m +m G{} } {
    \DerivativeGeneral
        {#1}{#2}{#3}{\pderivSymbol}
}
\DeclareDocumentCommand \tderiv { +m +m G{} } {
    \DerivativeGeneral
        {#1}{#2}{#3}{\tderivSymbol}
}
\DeclareDocumentCommand \derivbig { o +m o +m G{} } {
    \DerivativeGeneralBig
        {#2}{#4}{#5}{\derivSymbol}{#1}{#3}
}
\DeclareDocumentCommand \pderivbig { o +m o +m G{} } {
    \DerivativeGeneralBig
        {#2}{#4}{#5}{\pderivSymbol}{#1}{#3}
}
\DeclareDocumentCommand \tderivbig { o +m o +m G{} } {
    \DerivativeGeneralBig
        {#2}{#4}{#5}{\tderivSymbol}{#1}{#3}
}
\DeclareMathOperator*{\Sup}    {Sup}
\DeclareMathOperator*{\Inf}    {Inf}
\DeclareMathOperator*{\Lim}    {Lim}
\DeclareMathOperator*{\Min}    {Min}
\DeclareMathOperator*{\Max}    {Max}
\DeclareMathOperator*{\ArgMin} {ArgMin}
\DeclareMathOperator*{\ArgMax} {ArgMax}
\DeclareMathOperator{\Abs}     {Abs}
\DeclareMathOperator{\Ln}      {Ln}
\DeclareMathOperator{\Log}     {Log}
\DeclareMathOperator{\Exp}     {Exp}
\DeclareMathOperator{\Cos}     {Cos}
\DeclareMathOperator{\Sin}     {Sin}
\DeclareMathOperator{\Tan}     {Tan}
\DeclareMathOperator{\Sec}     {Sec}
\DeclareMathOperator{\Csc}     {Csc}
\DeclareMathOperator{\Cot}     {Cot}
\DeclareMathOperator{\Cosh}    {Cosh}
\DeclareMathOperator{\Sinh}    {Sinh}
\DeclareMathOperator{\Tanh}    {Tanh}
\DeclareMathOperator{\Sech}    {Sech}
\DeclareMathOperator{\Csch}    {Csch}
\DeclareMathOperator{\Coth}    {Coth}
\DeclareMathOperator{\ArcCos}  {ArcCos}
\DeclareMathOperator{\ArcSin}  {ArcSin}
\DeclareMathOperator{\ArcTan}  {ArcTan}
\DeclareMathOperator{\ArcSec}  {ArcSec}
\DeclareMathOperator{\ArcCsc}  {ArcCsc}
\DeclareMathOperator{\ArcCot}  {ArcCot}
\DeclareMathOperator{\ArcCosh} {ArcCosh}
\DeclareMathOperator{\ArcSinh} {ArcSinh}
\DeclareMathOperator{\ArcTanh} {ArcTanh}
\DeclareMathOperator{\ArcSech} {ArcSech}
\DeclareMathOperator{\ArcCsch} {ArcCsch}
\DeclareMathOperator{\ArcCoth} {ArcCoth}
\cs_new:Nn \UWMad_Math_RootWithTail:nn {

    \hbox_set:Nn \l_tmpa_box {
        $
            \mathchoice
                {\root #1 \of {#2\:\!}}
                {\root #1 \of {#2\:\!}}
                {\root #1 \of {#2\:\!}}
                {\root #1 \of {#2\:\!}}
        $
    }
    %
    \dim_set:Nn \l_tmpa_dim {\box_ht:N \l_tmpa_box}
    \dim_set:Nn \l_tmpb_dim {0.8\l_tmpa_dim}
    %
    \hbox_set:Nn \l_tmpb_box {
        \tex_vrule:D height \l_tmpa_dim depth -\l_tmpb_dim
    }
    %
    \box_use:N \l_tmpa_box
    \box_move_down:nn {0.40pt}{\box_use:N \l_tmpb_box}
}
\DeclareDocumentCommand \Sqrt { O{} m } {
    \UWMad_Math_RootWithTail:nn{#1}{#2}
}
\DeclareExpandableDocumentCommand \IfMathModeTF { +m +m } {
    \mode_if_math:TF {
        #1
    }{
        $#2$
    }
}
\ExplSyntaxOff
    \DeclareDocumentCommand \subs { O{} +m } {%
        \IfMathModeTF{%
            _{\!\!\:#1\text{\scriptsize #2}}%
        }{%
            _{\!#1\text{\scriptsize #2}}%
        }%
    }%
    \DeclareDocumentCommand \sups { O{} +m } {%
        \IfMathModeTF{%
            ^{#1\text{\scriptsize #2}}%
        }{%
            ^{#1\text{\scriptsize #2}}%
        }%
    }%
    \DeclareDocumentCommand \subsups { O{} +m O{} +m } {%
        \IfMathModeTF{%
            _{#1\text{\scriptsize #2}}^{\!\!\:#3\text{\scriptsize #4}}%
        }{%
            _{#1\text{\scriptsize #2}}^{\!\!\!#3\text{\scriptsize #4}}%
        }%
    }%
\ExplSyntaxOn
\DeclareDocumentCommand \OneOver { +m } {
    \frac{1}{#1}
}
\DeclareDocumentCommand \oneo { +m } {
    \OneOver{#1}
}
\DeclareDocumentCommand \dd { m } {
    \mathrm{d}{#1}
}
\DeclareDocumentCommand \dprime { } {
    {\prime\prime}
}
\DeclareDocumentCommand \tprime { } {
    {\prime\prime\prime}
}
\DeclareDocumentCommand \LessThan        { } {<}
\DeclareDocumentCommand \GreaterThanThan { } {>}
\cs_new:Nn \UWMad_ListOf_Define:n {
    \tl_const:cn {c__UWMad_ListOf#1_IsDefined_tl}{}
    \tl_new:c {g__UWMad_ListOf#1_Section_Main_tl}
    \tl_new:c {g__UWMad_ListOf#1_Section_Group_tl}
    \tl_new:c {g__UWMad_ListOf#1_Section_Subgroup_tl}
    \tl_new:c {g__UWMad_ListOf#1_Title_Main_tl}
    \tl_new:c {g__UWMad_ListOf#1_Title_Group_tl}
    \tl_new:c {g__UWMad_ListOf#1_Title_Subgroup_tl}
    \bool_new:c       {g__UWMad_ListOf#1_ClearAfterPrint_bool}
    \bool_gset_true:c {g__UWMad_ListOf#1_ClearAfterPrint_bool}
    \bool_new:c       {g__UWMad_ListOf#1_IsNumbered_bool}
    \bool_gset_true:c {g__UWMad_ListOf#1_IsNumbered_bool}
    \bool_new:c       {g__UWMad_ListOf#1_IncludeInTOC_bool}
    \bool_gset_true:c {g__UWMad_ListOf#1_IncludeInTOC_bool}
    \UWMad_Queue_Define:n               {g__ListOf#1_EntryQueue}
    \UWMad_Hash_Define:n                {g__ListOf#1_Hook}
}
\cs_new:Nn \UWMad_ListOf_Delete:n {
    \cs_undefine:c {c__UWMad_ListOf#1_IsDefined_tl}
    \cs_undefine:c {g__UWMad_ListOf#1_Section_Main_tl}
    \cs_undefine:c {g__UWMad_ListOf#1_Section_Group_tl}
    \cs_undefine:c {g__UWMad_ListOf#1_Section_Subgroup_tl}
    \cs_undefine:c {g__UWMad_ListOf#1_Title_Main_tl}
    \cs_undefine:c {g__UWMad_ListOf#1_Title_Group_tl}
    \cs_undefine:c {g__UWMad_ListOf#1_Title_Subgroup_tl}
    \cs_undefine:c {g__UWMad_ListOf#1_ClearAfterPrint_bool}
    \cs_undefine:c {g__UWMad_ListOf#1_IsNumbered_bool}
    \cs_undefine:c {g__UWMad_ListOf#1_IncludeInTOC_bool}
    \UWMad_Queue_Delete:n   {g__ListOf#1_EntryQueue}
    \UWMad_Hash_Delete:n    {g__ListOf#1_Hook}
}
\cs_new:Nn \UWMad_ListOf_IfDefined:nT {
    \__UWMad_IfDefined:nnnnT
        {c__UWMad_ListOf}
        {#1}
        {_IsDefined_tl}
        {ListOf}
        {#2}
}
\cs_new:Nn \UWMad_ListOf_MakeNumbered:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_set_true:c {g__UWMad_ListOf#1_IsNumbered_bool}
    }
}
\cs_new:Nn \UWMad_ListOf_MakeNotNumbered:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_set_false:c {g__UWMad_ListOf#1_IsNumbered_bool}
    }
}
\cs_new:Nn \UWMad_ListOf_IfNumbered:nTF {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_if:cTF {g__UWMad_ListOf#1_IsNumbered_bool} {
            #2
        }{
            #3
        }
    }
}
\cs_new:Nn \UWMad_ListOf_IncludeInTOC:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_set_true:c {c__UWMad_ListOf#1_IncludeInTOC_bool}
    }
}
\cs_new:Nn \UWMad_ListOf_DoNotIncludeInTOC:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_set_false:c {c__UWMad_ListOf#1_IncludeInTOC_bool}
    }
}
\cs_new:Nn \UWMad_ListOf_IfIncludeInTOC:nTF {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_if:cTF {c__UWMad_ListOf#1_IncludeInTOC_bool} {
            #2
        }{
            #3
        }
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitle_Main:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {g__UWMad_ListOf#1_Title_Main_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitle_Group:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {g__UWMad_ListOf#1_Title_Group_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitle_Subgroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {g__UWMad_ListOf#1_Title_Subgroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_GetTitle_Main:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {g__UWMad_ListOf#1_Title_Main_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetTitle_Group:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {g__UWMad_ListOf#1_Title_Group_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetTitle_Subgroup:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {g__UWMad_ListOf#1_Title_Subgroup_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSection_Main:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {g__UWMad_ListOf#1_Section_Main_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSection_Group:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {g__UWMad_ListOf#1_Section_Group_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSection_Subgroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {g__UWMad_ListOf#1_Section_Subgroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_GetSection_Main:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {g__UWMad_ListOf#1_Section_Main_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetSection_Group:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {g__UWMad_ListOf#1_Section_Group_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetSection_Subgroup:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {g__UWMad_ListOf#1_Section_Subgroup_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_SetHook:nnn {
    \UWMad_Hash_Set:nnn{g__ListOf#1_Hook}{#2}{#3}
}
\cs_new:Nn \UWMad_ListOf_PushEntry:nn {
    \UWMad_Hash_Get:nn   {g__ListOf#1_Hook}{PrePush}
    \UWMad_Queue_Push:nn {g__ListOf#1_EntryQueue}{#2}
    \UWMad_Hash_Get:nn   {g__ListOf#1_Hook}{PostPush}
}
\cs_new:Nn \UWMad_ListOf_PrintEntries:n {
    \UWMad_Hash_Get:nn   {g__ListOf#1_Hook}{PrePrint}
    \UWMad_Queue_Walk:nn {g__ListOf#1_EntryQueue}{##1}
    \UWMad_Queue_Clear:n {g__ListOf#1_EntryQueue}
    \UWMad_Hash_Get:nn   {g__ListOf#1_Hook}{PostPrint}
}
\cs_new:Nn \__UWMad_ListOf_CurrentSectioningCommmand:n {}
\cs_new:Nn \UWMad_ListOf_PrintTitle:nn {

    \cs_set_eq:Nc
        \__UWMad_ListOf_CurrentSectioningCommmand:n
        {\tl_use:c{g__UWMad_ListOf#1_Section_#2_tl}}

    \UWMad_ListOf_IfNumbered:nTF {#1} {
        \UWMad_ListOf_IfIncludeInTOC:nTF {#1} {
            \__UWMad_ListOf_CurrentSectioningCommmand:n
                {\tl_use:c {g__UWMad_ListOf#1_Title_#2_tl}}
        } {
            \int_set_eq:NN \l_tmpa_int \c@tocdepth
            \setcounter{tocdepth}{-1}
            \__UWMad_ListOf_CurrentSectioningCommmand:n
                {\tl_use:c {g__UWMad_ListOf#1_Title_#2_tl}}
            \setcounter{tocdepth}{\l_tmpa_int}
        }
    } {
        \UWMad_ListOf_IfIncludeInTOC:nTF {#1} {
            \phantomsection
            \addcontentsline
                {toc}
                {\tl_use:c {g__UWMad_ListOf#1_Section_#2_tl}}
                {\tl_use:c {g__UWMad_ListOf#1_Title_#2_tl}}
        } { }
        \__UWMad_ListOf_CurrentSectioningCommmand:n*
        {\tl_use:c {g__UWMad_ListOf#1_Title_#2_tl}}
    }

}
\cs_new:Nn \UWMad_ListOf_StartGroup:nn {
    \UWMad_ListOf_PrintEntries:n{#1}
    \UWMad_ListOf_PrintTitle:nn {#1}{#2}
}
\dim_new:N \l__UWMad_Nomenclature_WidestSymbol_dim
\dim_new:N \l__UWMad_Nomenclature_WidestUnit_dim
\dim_new:N \l__UWMad_Nomenclature_Entry_WidthSymbol_dim
\dim_new:N \l__UWMad_Nomenclature_Entry_WidthUnits_dim
\dim_new:N \l__UWMad_Nomenclature_Entry_WidthDescription_dim
\dim_new:N \l__UWMad_Nomenclature_TitleSkip_dim
\dim_new:N \l__UWMad_Nomenclature_PrintSkip_dim
\dim_new:N \l__UWMad_Nomenclature_Entry_MarginLeft_dim
\dim_new:N \l__UWMad_Nomenclature_Entry_MarginBottom_dim
\dim_new:N \l__UWMad_Nomenclature_Entry_Padding_dim
\tl_new:N \l__UWMad_Nomenclature_Section_Main_tl
\tl_new:N \l__UWMad_Nomenclature_Section_Group_tl
\tl_new:N \l__UWMad_Nomenclature_Section_Subgroup_tl
\tl_new:N \l__UWMad_Nomenclature_Title_Main_tl
\tl_new:N \l__UWMad_Nomenclature_Title_Group_tl
\tl_new:N \l__UWMad_Nomenclature_Title_Subgroup_tl
\keys_define:nn { UWMad/Nomenclature } {
    title-skip .dim_set:N = \l__UWMad_Nomenclature_TitleSkip_dim,
    print-skip .dim_set:N = \l__UWMad_Nomenclature_PrintSkip_dim,
    entry-margin-left .dim_set:N =
        \l__UWMad_Nomenclature_Entry_MarginLeft_dim,
    entry-margin-bottom .dim_set:N =
        \l__UWMad_Nomenclature_Entry_MarginBottom_dim,
    entry-padding .dim_set:N =
        \l__UWMad_Nomenclature_Entry_Padding_dim,
    title-skip          .default:n  = {0.00pt},
    print-skip          .default:n  = {1.00em},
    entry-margin-left   .default:n  = {1.00em},
    entry-margin-bottom .default:n  = {0.25em},
    entry-padding       .default:n  = {0.75em},
    main-section .code:n = {
        \tl_set:Nn
            \l__UWMad_Nomenclature_Section_Main_tl {#1}
    },
    group-section .code:n = {
        \tl_set:Nn
            \l__UWMad_Nomenclature_Section_Group_tl {#1}
    },
    subgroup-section .code:n = {
        \tl_set:Nn
            \l__UWMad_Nomenclature_Section_Subgroup_tl {#1}
    },
    main-section .default:n = chapter,
    main-title .code:n = {
        \tl_set:Nn
            \l__UWMad_Nomenclature_Title_Main_tl {#1}
    },
    group-title .code:n = {
        \tl_set:Nn
            \l__UWMad_Nomenclature_Title_Group_tl {#1}
    },
    subgroup-title .code:n = {
        \tl_set:Nn
            \l__UWMad_Nomenclature_Title_Subgroup_tl {#1}
    },
    main-title .default:n = Nomenclature,
    numbered       .bool_gset:N =
        \g__UWMad_Nomenclature_IsNumbered_bool,
    include-in-toc .bool_gset:N =
        \g__UWMad_Nomenclature_IncludeInTOC_bool,
    with-units .bool_gset:N =
        \g__UWMad_Nomenclature_IncludeUnitsColumn_bool,
      numbered     .default:n = false,
    include-in-toc .default:n = true,
     with-units    .default:n = false
}
\keys_set:nn { UWMad/Nomenclature } {
    title-skip          ,
    print-skip          ,
    entry-margin-left   ,
    entry-margin-bottom ,
    entry-padding       ,
    numbered            ,
    include-in-toc      ,
    with-units          ,
    main-section        ,
    main-title
}
\cs_new:Nn \UWMad_Nomenclature_UpdateWidest:Nn {
    \hbox_set:Nn \l_tmpa_box {#2}
    \dim_set:Nn  \l_tmpa_dim {\box_wd:N \l_tmpa_box}
    \dim_compare:nNnTF {#1} < {\l_tmpa_dim} {
        \dim_set:Nn #1 {\l_tmpa_dim}
    } { }
}
\cs_new:Nn \UWMad_Nomenclature_UpdateWidest_Symbol:n {
    \UWMad_Nomenclature_UpdateWidest:Nn
        \l__UWMad_Nomenclature_WidestSymbol_dim {#1}
}
\cs_new:Nn \UWMad_Nomenclature_UpdateWidest_Units:n {
    \UWMad_Nomenclature_UpdateWidest:Nn
        \l__UWMad_Nomenclature_WidestUnit_dim {#1}
}
\cs_new:Nn \UWMad_Nomenclature_ZeroWidest_Symbol: {
    \dim_set:Nn \l__UWMad_Nomenclature_WidestSymbol_dim {0pt}
}
\cs_new:Nn \UWMad_Nomenclature_ZeroWidest_Unit: {
    \dim_set:Nn \l__UWMad_Nomenclature_WidestUnit_dim {0pt}
}
\cs_new:Nn \UWMad_Nomenclature_SetEntryWidths_NoUnits: {
    %
    % Define symbol width
    \dim_set:Nn \l__UWMad_Nomenclature_Entry_WidthSymbol_dim {
        1.01\l__UWMad_Nomenclature_WidestSymbol_dim
    }
    %
    % Define description width
    \dim_set:Nn \l__UWMad_Nomenclature_Entry_WidthDescription_dim {
        0.999\textwidth -
        \l__UWMad_Nomenclature_Entry_MarginLeft_dim  -
        \l__UWMad_Nomenclature_Entry_WidthSymbol_dim -
        \l__UWMad_Nomenclature_Entry_Padding_dim
    }
}
\cs_new:Nn \UWMad_Nomenclature_SetEntryWidths_Units: {
    %
    % Define symbol width
    \dim_set:Nn \l__UWMad_Nomenclature_Entry_WidthSymbol_dim {
        1.01\l__UWMad_Nomenclature_WidestSymbol_dim
    }
    %
    % Define unit width
    \dim_set:Nn \l__UWMad_Nomenclature_Entry_WidthUnit_dim {
        1.01\l__UWMad_Nomenclature_WidestUnit_dim
    }
    %
    % Define description width
    \dim_set:Nn \l__UWMad_Nomenclature_Entry_WidthDescription_dim {
        0.999\textwidth -
         \l__UWMad_Nomenclature_Entry_MarginLeft_dim  -
         \l__UWMad_Nomenclature_Entry_WidthSymbol_dim -
         \l__UWMad_Nomenclature_Entry_WidthUnit_dim   -
        2\l__UWMad_Nomenclature_Entry_Padding_dim
    }
}
\cs_new:Nn \UWMad_Nomenclature_SetEntryWidths: {
    \bool_if:NTF \g__UWMad_Nomenclature_IncludeUnitsColumn_bool {
        \UWMad_Nomenclature_SetEntryWidths_Units:
    } {
        \UWMad_Nomenclature_SetEntryWidths_NoUnits:
    }
}
\coffin_new:N \l_tmpc_coffin
\cs_new:Nn \UWMad_Nomenclature_SetEntry_NoUnits:nn {
    \vcoffin_set:Nnn
        \l_tmpa_coffin
        {\l__UWMad_Nomenclature_Entry_WidthSymbol_dim}
        {#1}
    \vcoffin_set:Nnn
        \l_tmpb_coffin
        {\l__UWMad_Nomenclature_Entry_WidthDescription_dim}
        {#2}
    \group_begin:
        \setstretch{1.1}
        \skip_horizontal:n {\l__UWMad_Nomenclature_Entry_MarginLeft_dim}
        \coffin_typeset:Nnnnn \l_tmpa_coffin {l}{t}{0pt}{0pt}
        \skip_horizontal:n {\l__UWMad_Nomenclature_Entry_Padding_dim}
        \coffin_typeset:Nnnnn \l_tmpb_coffin {l}{t}{0pt}{0pt}
        \skip_vertical:n {\l__UWMad_Nomenclature_Entry_MarginBottom_dim}
    \group_end:
}
\cs_new:Nn \UWMad_Nomenclature_SetEntry_Units:nnn {
    \vcoffin_set:Nnn
        \l_tmpa_coffin
        {\l__UWMad_Nomenclature_Entry_WidthSymbol_dim}
        {#1}
    \vcoffin_set:Nnn
        \l_tmpb_coffin
        {\l__UWMad_Nomenclature_Entry_WidthUnit_dim}
        {#2}
    \vcoffin_set:Nnn
        \l_tmpc_coffin
        {\l__UWMad_Nomenclature_Entry_WidthDescription_dim}
        {#3}
    \group_begin:
        \setstretch{1.1}
        \skip_horizontal:n {\l__UWMad_Nomenclature_Entry_MarginLeft_dim}
        \coffin_typeset:Nnnnn \l_tmpa_coffin {l}{t}{0pt}{0pt}
        \skip_horizontal:n {\l__UWMad_Nomenclature_Entry_Padding_dim}
        \coffin_typeset:Nnnnn \l_tmpb_coffin {l}{t}{0pt}{0pt}
        \skip_horizontal:n {\l__UWMad_Nomenclature_Entry_Padding_dim}
        \coffin_typeset:Nnnnn \l_tmpc_coffin {l}{t}{0pt}{0pt}
        \skip_vertical:n {\l__UWMad_Nomenclature_Entry_MarginBottom_dim}
    \group_end:
}
\cs_new:Nn \UWMad_Nomenclature_SetEntry: {
    \bool_if:NTF \g__UWMad_Nomenclature_IncludeUnitsColumn_bool {
        \UWMad_Nomenclature_SetEntry_Units:
    } {
        \UWMad_Nomenclature_SetEntry_NoUnits:
    }
}
\DeclareDocumentCommand \NomenclatureSetup { m } {
    \keys_set:nn { UWMad/Nomenclature } { #1 }
}
\DeclareDocumentEnvironment {Nomenclature} { o g } {
    \UWMad_ListOf_Define:n {Nomenclature}
    \IfNoValueTF {#1} { } {
        \UWMad_IfSectionExists:nT {#1} { }
        \tl_set:Nn \l__UWMad_Nomenclature_Section_Main_tl {#1}
    }
    \IfNoValueTF {#2} { } {
        \tl_set:Nf
            \l__UWMad_Nomenclature_Title_Main_tl {#2}
    }
    \UWMad_ListOf_SetTitle_Main:nn {Nomenclature}
        {\l__UWMad_Nomenclature_Title_Main_tl}
   \bool_if:NTF \g__UWMad_Nomenclature_IsNumbered_bool {
        \UWMad_ListOf_MakeNumbered:n    {Nomenclature}
    }{
        \UWMad_ListOf_MakeNotNumbered:n {Nomenclature}
    }
    \tl_if_empty:NTF \l__UWMad_Nomenclature_Section_Group_tl {
        \tl_set:Nf \l__UWMad_Nomenclature_Section_Group_tl {
            \UWMad_NextSection:n {
                \l__UWMad_Nomenclature_Section_Main_tl
            }
        }
    } { }
    \tl_if_empty:NTF \l__UWMad_Nomenclature_Section_Subgroup_tl {
        \tl_set:Nf \l__UWMad_Nomenclature_Section_Subgroup_tl {
            \UWMad_NextSection:n {
                \l__UWMad_Nomenclature_Section_Group_tl
            }
        }
    } { }
    \UWMad_ListOf_SetSection_Main:nn
        {Nomenclature} {\l__UWMad_Nomenclature_Section_Main_tl}
    \UWMad_ListOf_SetSection_Group:nn
        {Nomenclature} {\l__UWMad_Nomenclature_Section_Group_tl}
    \UWMad_ListOf_SetSection_Subgroup:nn
        {Nomenclature} {\l__UWMad_Nomenclature_Section_Subgroup_tl}
    \bool_if:NTF \g__UWMad_Nomenclature_IncludeInTOC_bool {
        \UWMad_ListOf_IncludeInTOC:n {Nomenclature}
    } {
        \UWMad_ListOf_DoNotIncludeInTOC:n {Nomenclature}
    }
    \UWMad_ListOf_SetHook:nnn {Nomenclature} {PrePrint} {
        \UWMad_Nomenclature_SetEntryWidths:
    }
    \UWMad_ListOf_SetHook:nnn {Nomenclature} {PostPrint} {
        \UWMad_Nomenclature_ZeroWidest_Symbol:
    }
    \DeclareDocumentCommand \Group { G{} } {
        \IfNoValueTF {##1} { } {
            \tl_set:Nn
                \l__UWMad_Nomenclature_Title_Group_tl {##1}
        }
        \UWMad_ListOf_SetTitle_Group:nn {Nomenclature}
            {\l__UWMad_Nomenclature_Title_Group_tl}
        \UWMad_ListOf_StartGroup:nn{Nomenclature}{Group}
    }
    \DeclareDocumentCommand \Subgroup { G{} } {
        \IfNoValueTF {##1} { } {
            \tl_set:Nn
                \l__UWMad_Nomenclature_Title_Subgroup_tl {##1}
        }
        \UWMad_ListOf_SetTitle_Subgroup:nn {Nomenclature}
            {\l__UWMad_Nomenclature_Title_Subgroup_tl}
        \UWMad_ListOf_StartGroup:nn{Nomenclature}{Subgroup}
    }
    \bool_if:NTF \g__UWMad_Nomenclature_IncludeUnitsColumn_bool {
        \DeclareDocumentCommand \Entry { m m m } {
            \UWMad_ListOf_PushEntry:nn {Nomenclature} {
                \UWMad_Nomenclature_SetEntry_Units:nnn
                    {##1} {##2} {##3}
            }
            \UWMad_Nomenclature_UpdateWidest_Symbol:n{##1}
        }
    } {
        \DeclareDocumentCommand \Entry { m m } {
            \UWMad_ListOf_PushEntry:nn {Nomenclature} {
                \UWMad_Nomenclature_SetEntry_NoUnits:nn
                    {##1} {##2}
            }
            \UWMad_Nomenclature_UpdateWidest_Symbol:n{##1}
        }
    }
    \DeclareDocumentCommand  \ResetColumnWidth { } {
        \UWMad_Nomenclature_ZeroWidest_Symbol:
        \UWMad_Nomenclature_ZeroWidest_Unit:
    }
    \UWMad_ListOf_PrintTitle:nn {Nomenclature}{Main}
} {
    \UWMad_ListOf_PrintEntries:n {Nomenclature}
    \UWMad_ListOf_Delete:n{Nomenclature}
}
\DeclareDocumentEnvironment {Acronym} { o G{Acronym} } {

    \begin{Nomenclature}[#1]{#2}
    \UWMad_Hash_Define:n{Acronyms}
    \UWMad_Hash_Define:n{AcronymMeanings}
    \cs_undefine:N \Entry
    \DeclareDocumentCommand \Entry { o m m } {
        \IfNoValueTF {##1} {

            \UWMad_Hash_Set:nnn{Acronyms}       {##2}{##2}
            \UWMad_Hash_Set:nnn{AcronymMeanings}{##2}{##3}
            \bool_new:c {g__UWMad_Acronym_WasSet_##2_bool}
            %
            \UWMad_ListOf_PushEntry:nn {Nomenclature} {
                \hypertarget{Acronym:##2}{}
                \UWMad_Nomenclature_SetEntry_NoUnits:nn
                    {##2} {##3}
            }

        } {

            \UWMad_Hash_Set:nnn{Acronyms}       {##1}{##2}
            \UWMad_Hash_Set:nnn{AcronymMeanings}{##1}{##3}
            \bool_new:c {g__UWMad_Acronym_WasSet_##1_bool}
            %
            \UWMad_ListOf_PushEntry:nn {Nomenclature} {
                \hypertarget{Acronym:##1}{}
                \UWMad_Nomenclature_SetEntry_NoUnits:nn
                    {##2} {##3}
            }

        }
        \UWMad_Nomenclature_UpdateWidest_Symbol:n{##2}
    }
} {

    \end{Nomenclature}

}

\DeclareDocumentCommand \Acro { m } {
    \UWMad_Hash_IfKeySet:nnTF {Acronyms} {#1} {
        \bool_if:cTF {g__UWMad_Acronym_WasSet_#1_bool} {
            \hyperlink{Acronym:#1}{
                \UWMad_Hash_Get:nn{Acronyms}{#1}
            }
        } {
            \UWMad_Hash_Get:nn{AcronymMeanings}{#1}~
                (
                    \UWMad_Hash_Get:nn{Acronyms}{#1}
                )
            \bool_gset_true:c {g__UWMad_Acronym_WasSet_#1_bool}
        }
    } { }
}
\cs_new_eq:NN \AcronymSetup \NomenclatureSetup
\UWMad_CSV_Define:n {MetaDataList}
\cs_new:Nn \UWMad_MetaData_PushToList:nn {
   \UWMad_CSV_Append:nn {MetaDataList}{#1={#2}}
}

\bool_new:N \g__UWMad_MetaData_GenerateAux_bool
\bool_new:N \g__UWMad_MetaData_IsDocument_bool

\file_if_exist:nTF{\jobname.UWMad.PDFMetaData.aux} {
    \file_input:n {\jobname.UWMad.PDFMetaData.aux}
}{}

\AtBeginDocument{
    \UWMad_CSV_IfNotEmpty:nTF{MetaDataList} {
        \exp_args:Nx \hypersetup {\UWMad_CSV_Get:n{MetaDataList}}
    } { }
    \bool_gset_true:N \g__UWMad_MetaData_IsDocument_bool
}
\AtEndDocument{
    \bool_if:NTF \g__UWMad_MetaData_GenerateAux_bool {
        \UWMad_CSV_IfNotEmpty:nTF {MetaDataList} {
            \iow_new:N   \g__UWMad_PDFMetaData_HyperSetup_io
            \iow_open:Nn \g__UWMad_PDFMetaData_HyperSetup_io {
                \jobname.UWMad.PDFMetaData.aux
            }
            \iow_now:Nx  \g__UWMad_PDFMetaData_HyperSetup_io {
                \noexpand\ExplSyntaxOff
                    \noexpand\hypersetup{\UWMad_CSV_Get:n{MetaDataList}}
                \noexpand\ExplSyntaxOn
            }
            \iow_close:N \g__UWMad_PDFMetaData_HyperSetup_io
        } { }
    } { }
}

\tl_new:N \g__UWMad_ThesisInfo_Title_tl
\tl_new:N \g__UWMad_ThesisInfo_Author_tl
\tl_new:N \g__UWMad_ThesisInfo_DefenseDate_tl
\tl_new:N \g__UWMad_ThesisInfo_Department_tl
\tl_new:N \g__UWMad_ThesisInfo_Program_tl
\tl_new:N \g__UWMad_ThesisInfo_Degree_tl
\tl_new:N \g__UWMad_ThesisInfo_AdvisorName_tl
\tl_new:N \g__UWMad_ThesisInfo_AdvisorPosition_tl
\tl_new:N \g__UWMad_ThesisInfo_AdvisorAssociation_tl
\tl_new:N \g__UWMad_ThesisInfo_AdvisorMarker_tl
\tl_new:N \g__UWMad_ThesisInfo_Institution_tl
\bool_new:N \g__UWMad_ThesisInfo_IsSet_Title_bool
\bool_new:N \g__UWMad_ThesisInfo_IsSet_Author_bool
\bool_new:N \g__UWMad_ThesisInfo_IsSet_DefenseDate_bool
\bool_new:N \g__UWMad_ThesisInfo_IsSet_Program_bool
\bool_new:N \g__UWMad_ThesisInfo_IsSet_Degree_bool
\bool_new:N \g__UWMad_ThesisInfo_IsSet_Institution_bool
\bool_new:N \g__UWMad_ThesisInfo_IsSet_Advisor_bool
\DeclareDocumentCommand \Title { m } {
    \tl_gset:Nn \g__UWMad_ThesisInfo_Title_tl {#1}
    \title{#1}
    \UWMad_MetaData_PushToList:nn{pdftitle}    {#1}
    \bool_if:NTF \g__UWMad_MetaData_IsDocument_bool {
        \bool_gset_true:N \g__UWMad_MetaData_GenerateAux_bool
    } { }
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_Title_bool
}
\DeclareDocumentCommand \Author { m } {
    \tl_gset:Nn \g__UWMad_ThesisInfo_Author_tl {#1}
    \author{#1}
    \UWMad_MetaData_PushToList:nn{pdfauthor}   {#1}
    \bool_if:NTF \g__UWMad_MetaData_IsDocument_bool {
        \bool_gset_true:N \g__UWMad_MetaData_GenerateAux_bool
    } { }
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_Author_bool
}
\DeclareDocumentCommand \Program { m } {
    \tl_gset:Nn \g__UWMad_ThesisInfo_Program_tl {#1}
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_Program_bool
}
\DeclareDocumentCommand \Degree { m } {
    \tl_gset:Nn \g__UWMad_ThesisInfo_Degree_tl {#1}
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_Degree_bool
}
\DeclareDocumentCommand \DefenseDate { m } {
    \tl_gset:Nn \g__UWMad_ThesisInfo_DefenseDate_tl {#1}
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_DefenseDate_bool
}
\cs_gset_eq:NN \DefenceDate \DefenseDate
\cs_gset_eq:NN \Date        \DefenseDate
\DeclareDocumentCommand \Institution { m } {
    \tl_gset:Nn       \g__UWMad_ThesisInfo_Institution_tl {#1}
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_Institution_bool
}
\cs_set_eq:NN \University \Institution
\DeclareDocumentCommand \Department { m } {
    \tl_gset:Nn \g__UWMad_ThesisInfo_Department_tl {#1}
}
\DeclareDocumentCommand \Advisor { m m m } {
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_Advisor_bool
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorName_tl        {#1}
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorPosition_tl    {#2}
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorAssociation_tl {#3}
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorMarker_tl      {Advisor}
 }
\DeclareDocumentCommand \Adviser { m m m } {
    \bool_gset_true:N \g__UWMad_ThesisInfo_IsSet_Advisor_bool
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorName_tl        {#1}
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorPosition_tl    {#2}
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorAssociation_tl {#3}
    \tl_gset:Nn \g__UWMad_ThesisInfo_AdvisorMarker_tl      {Adviser}
}
\DeclareDocumentCommand \TheTitle { } {
    \g__UWMad_ThesisInfo_Title_tl
}
\DeclareDocumentCommand \TheAuthor { } {
    \g__UWMad_ThesisInfo_Author_tl
}
\DeclareDocumentCommand \TheProgram { m } {
    \g__UWMad_ThesisInfo_Program_tl
}
\DeclareDocumentCommand \TheDegree { m } {
    \g__UWMad_ThesisInfo_Degree_tl
}
\DeclareDocumentCommand \TheDefenseDate { m } {
    \g__UWMad_ThesisInfo_DefenseDate_tl
}
\cs_gset_eq:NN \TheDefenceDate \TheDefenseDate
\cs_gset_eq:NN \TheDate        \TheDefenseDate
\DeclareDocumentCommand \TheInstitution { m } {
    \g__UWMad_ThesisInfo_Institution_tl
}
\cs_set_eq:NN \TheUniversity \TheInstitution
\DeclareDocumentCommand \TheDepartment { m } {
    \g__UWMad_ThesisInfo_Department_tl
}
\DeclareDocumentCommand \TheAdvisor { m } {
    \g__UWMad_ThesisInfo_AdvisorName_tl
}
\int_new:N \l__UWMad_ThesisInfo_CommitteeCount_int
\UWMad_ListOf_Define:n {CommitteeList}
\DeclareDocumentCommand \CommitteeMember { m m m } {
    \int_incr:N \l__UWMad_ThesisInfo_CommitteeCount_int
    \UWMad_ListOf_PushEntry:nn {CommitteeList} {
        #1,~#2,~#3\skip_vertical:n{-1em}
    }
}
\DeclareDocumentCommand \PrintCommitteeMemberList { } {
    \bool_if:NTF \g__UWMad_ThesisInfo_IsSet_Advisor_bool {
        \g__UWMad_ThesisInfo_AdvisorName_tl{},~
        \g__UWMad_ThesisInfo_AdvisorPosition_tl{},~
        \g__UWMad_ThesisInfo_AdvisorAssociation_tl{}~
        (\g__UWMad_ThesisInfo_AdvisorMarker_tl{})
        \skip_vertical:n{-1em}
    } { }
    \UWMad_ListOf_PrintEntries:n {CommitteeList}
}
\tl_new:N \g__UWMad_PDFMetaData_Subject_tl
\tl_new:N \g__UWMad_PDFMetaData_Keywords_tl
\tl_new:N \g__UWMad_PDFMetaData_Producer_tl
\tl_new:N \g__UWMad_PDFMetaData_Creator_tl
\DeclareDocumentCommand \Subject { m } {
    \tl_gset:Nn \g__UWMad_PDFMetaData_Subject_tl {#1}
    \UWMad_MetaData_PushToList:nn{pdfsubject}  {#1}
    \bool_if:NTF \g__UWMad_MetaData_IsDocument_bool {
        \bool_gset_true:N \g__UWMad_MetaData_GenerateAux_bool
    } { }
}
\DeclareDocumentCommand \Keywords { m } {
    \tl_gset:Nn \g__UWMad_PDFMetaData_Keywords_tl {#1}
    \UWMad_MetaData_PushToList:nn{pdfproducer} {#1}
    \bool_if:NTF \g__UWMad_MetaData_IsDocument_bool {
        \bool_gset_true:N \g__UWMad_MetaData_GenerateAux_bool
    } { }
}
\DeclareDocumentCommand \Producer { m } {
    \tl_gset:Nn \g__UWMad_PDFMetaData_Producer_tl {#1}
    \UWMad_MetaData_PushToList:nn{pdfcreator}  {#1}
    \bool_if:NTF \g__UWMad_MetaData_IsDocument_bool {
        \bool_gset_true:N \g__UWMad_MetaData_GenerateAux_bool
    } { }
}
\DeclareDocumentCommand \Creator { m } {
    \tl_gset:Nn \g__UWMad_PDFMetaData_Creator_tl {#1}
    \UWMad_MetaData_PushToList:nn{pdfkeywords} {#1}
    \bool_if:NTF \g__UWMad_MetaData_IsDocument_bool {
        \bool_gset_true:N \g__UWMad_MetaData_GenerateAux_bool
    } { }
}
\DeclareDocumentCommand \TheSubject { } {
    \g__UWMad_PDFMetaData_Subject_tl
}
\DeclareDocumentCommand \TheKeywords { } {
    \g__UWMad_PDFMetaData_Keywords_tl
}
\DeclareDocumentCommand \TheProducer { } {
    \g__UWMad_PDFMetaData_Producer_tl
}
\DeclareDocumentCommand \TheCreator { } {
    \g__UWMad_PDFMetaData_Creator_tl
}
\DeclareDocumentCommand \FulfillmentClause { } {
    {
    \setstretch{1.1}
    A~\TheDocument{}~submitted~in~partial~fulfillment~of~the~
    requirements~for~the~degree~of
    }
}

\DeclareDocumentCommand \TitlePageTitle { } {
    {
        \huge
        \textsc {\TheTitle{}}
    }
}

\DeclareDocumentCommand \TitlePageAuthor { } {
    {
        \large
        by  \\[0.50em]
        \TheAuthor{}
    }
}

\DeclareDocumentCommand \TitlePageFulFillment { } {
    \FulfillmentClause{}
}

\DeclareDocumentCommand \TitlePageDegree { } {
    \TheDegree{}
}

\DeclareDocumentCommand \TitlePageProgram { } {
    \TheProgram{}
}

\DeclareDocumentCommand \TitlePageInstitution { } {
    \textsc{\TheInstitution{}}
}

\DeclareDocumentCommand \TitlePageDefenseDate { } {
    Date of final oral examination:~\TheDefenseDate{}
}

\DeclareDocumentCommand \MakeTitlePage { } {
    \thispagestyle{empty}
    \begin{center}
        \TitlePageTitle{}       \\[1.0em]
        \TitlePageAuthor{}      \\[1.0em]
        \TitlePageFulFillment{} \\[1.0em]
        \TitlePageDegree{}      \\[1.0em]
        \TitlePageProgram{}     \\[1.0em]
        \vfill
        \TitlePageInstitution{}
        \vfill
    \end{center}
    \TitlePageDefenseDate{}
    \TitlePageProgram{}     \\[1.0em]
    \PrintCommitteeMemberList{}
    \clearpage
}

\cs_new:Nn \__UWMad_LicensePage_StartPage: {
    \clearpage
    \thispagestyle{empty}
    \tex_hbox:D{}
    \tex_vfill:D
    \phantomsection
    \addcontentsline {toc} {chapter} {License}
}
\bool_new:N   \l__UWMad_Copyright_UseCopyright_bool
\cs_set_eq:NN \CopyrightSymbol \copyright

\cs_set:Nn \__UWMad_Copyright_LicenseText: {
    \begin{center}
        Copyright~\CopyrightSymbol{}~
        \l__UWMad_LicensePage_Year_tl{}~
        by~
        \l__UWMad_LicensePage_Owner_tl{}
    \end{center}
}
\cs_set:Nn \__UWMad_Copyright_PrintPage: {
    \__UWMad_LicensePage_StartPage:
    \__UWMad_Copyright_LicenseText:
}
\tl_new:N    \l__UWMad_CCLicense_Porting_tl
\tl_new:N    \l__UWMad_CCLicense_Version_tl
\tl_new:N    \l__UWMad_CCLicense_TypeAbbreviation_tl
\tl_new:N    \l__UWMad_CCLicense_TypeWords_tl
\tl_new:N    \l__UWMad_CCLicense_URL_Front_tl
\tl_new:N    \l__UWMad_CCLicense_URL_Middle_tl
\tl_new:N    \l__UWMad_CCLicense_URL_Back_tl
\tl_new:N    \l__UWMad_CCLicense_URL_tl
\tl_new:N    \l__UWMad_CCLicense_http_tl
\tl_new:N    \l__UWMad_CCLicense_URLText_tl
\bool_new:N \l__UWMad_CCLicense_UseCreativeCommons_bool
\bool_new:N \l__UWMad_CCLicense_UseAttribution_bool
\bool_new:N \l__UWMad_CCLicense_UseShareAlike_bool
\bool_new:N \l__UWMad_CCLicense_UseNoDerivatives_bool
\bool_new:N \l__UWMad_CCLicense_UseNonCommercial_bool
\bool_new:N \l__UWMad_CCLicense_IsValid_bool
\bool_set_true:N \l__UWMad_CCLicense_UseAttribution_bool
\cs_new:cn {l__UWMad_CCLicense_Valid_ by :}      {}
\cs_new:cn {l__UWMad_CCLicense_Valid_ by-sa :}   {}
\cs_new:cn {l__UWMad_CCLicense_Valid_ by-nd :}   {}
\cs_new:cn {l__UWMad_CCLicense_Valid_ by-nc :}   {}
\cs_new:cn {l__UWMad_CCLicense_Valid_ by-nc-sa :}{}
\cs_new:cn {l__UWMad_CCLicense_Valid_ by-nc-nd :}{}
\tl_gset:Nn \l__UWMad_CCLicense_Porting_tl {
    International
}
\tl_gset:Nn \l__UWMad_CCLicense_Version_tl {
    4.0
}
\tl_set:Nn \l__UWMad_CCLicense_URL_Front_tl {
    creativecommons.org/licenses
}
\tl_set:Nn \l__UWMad_CCLicense_URL_Middle_tl {
    /\l__UWMad_CCLicense_TypeAbbreviation_tl
}
\tl_set:Nn \l__UWMad_CCLicense_URL_Back_tl {
    /\l__UWMad_CCLicense_Version_tl
}
\tl_set:Nn \l__UWMad_CCLicense_URL_tl {
    http://
    \l__UWMad_CCLicense_URL_Front_tl
    \l__UWMad_CCLicense_URL_Middle_tl
    \l__UWMad_CCLicense_URL_Back_tl
}
\tl_set:Nn \l__UWMad_CCLicense_http_tl {
    http://
}
\tl_set:Nn \l__UWMad_CCLicense_URLText_tl {
    Creative~Commons~
    \l__UWMad_CCLicense_TypeWords_tl{}~
    \l__UWMad_CCLicense_Version_tl{}~
    \l__UWMad_CCLicense_Porting_tl{}
}
\cs_new:Nn \__UWMad_CCLicense_CreateType: {

        \bool_if:NTF \l__UWMad_CCLicense_UseAttribution_bool {

            \tl_put_right:Nn \l__UWMad_CCLicense_TypeAbbreviation_tl {
                by
            }
            \tl_put_right:Nn \l__UWMad_CCLicense_TypeWords_tl {
                Attribution
            }

        } { }

        \bool_if:NTF \l__UWMad_CCLicense_UseNonCommercial_bool {

            \tl_put_right:Nn \l__UWMad_CCLicense_TypeAbbreviation_tl {
                -nc
            }
            \tl_put_right:Nn \l__UWMad_CCLicense_TypeWords_tl {
                -NonCommercial
            }

        } { }

        \bool_if:NTF \l__UWMad_CCLicense_UseShareAlike_bool {

            \tl_put_right:Nn \l__UWMad_CCLicense_TypeAbbreviation_tl {
                -sa
            }
            \tl_put_right:Nn \l__UWMad_CCLicense_TypeWords_tl {
                -ShareAlike
            }

        } { }

        \bool_if:NTF \l__UWMad_CCLicense_UseNoDerivatives_bool {

            \tl_put_right:Nn \l__UWMad_CCLicense_TypeAbbreviation_tl {
                -nd
            }
            \tl_put_right:Nn \l__UWMad_CCLicense_TypeWords_tl {
                -NoDerivatives
            }

        } { }
}
\cs_new:Nn \__UWMad_CCLicense_CheckTypeValidity: {
    \cs_if_exist:cTF {
        l__UWMad_CCLicense_Valid_
        \l__UWMad_CCLicense_TypeAbbreviation_tl :
    } {

        \bool_set_true:N \l__UWMad_CCLicense_IsValid_bool

    } {

        \msg_new:nnn {UWMadThesis} {CCLicense / InvalidLicenseType} {
            The~license~type~`\l__UWMad_CCLicense_TypeAbbreviation_tl'~
            is~not~a~valid~Creative~Commons~license.
        }
        \msg_error:nn {UWMadThesis} {CCLicense / InvalidLicenseType}

    }
}
\cs_new:Nn \__UWMad_CCLicense_LicenseText: {
    \begin{center}
        \large
        This~work~is~released~under~a~
        \href {\l__UWMad_CCLicense_URL_tl} {
            \l__UWMad_CCLicense_URLText_tl
        }~
        license.\\[0.1em]
        \l__UWMad_LicensePage_Owner_tl{},~
        \l__UWMad_LicensePage_Year_tl{}
    \end{center}
}
\cs_new:Nn \__UWMad_CCLicense_PrintPage: {
    \__UWMad_LicensePage_StartPage:
    \__UWMad_CCLicense_LicenseText:
}
    \tl_new:N  \l__UWMad_LicensePage_Year_tl
    \tl_new:N  \l__UWMad_LicensePage_Owner_tl
    \tl_set:Nn \l__UWMad_LicensePage_Owner_tl {
        \g__UWMad_ThesisInfo_Author_tl
    }
    \tl_set:Nn \l__UWMad_LicensePage_Year_tl {
        \the\year
    }
\DeclareDocumentEnvironment {LicensePage} { } {
    \DeclareDocumentCommand \LicenseOwner { m } {
        \tl_set:Nn \l__UWMad_LicensePage_Owner_tl {
            ##1
        }
    }
    \DeclareDocumentCommand \TheLicenseOwner { } {
        \l__UWMad_LicensePage_Owner_tl
    }
    \DeclareDocumentCommand \LicenseYear { m } {
        \tl_set:Nn \l__UWMad_LicensePage_Year_tl {
            ##1
        }
    }
    \DeclareDocumentCommand \TheLicenseYear { } {
        \l__UWMad_LicensePage_Year_tl
    }
\DeclareDocumentCommand \Copyright { } {
    \bool_set_true:N \l__UWMad_Copyright_UseCopyright_bool
}
\cs_set_eq:NN \AllRightsReserved \Copyright
\DeclareDocumentCommand \CreativeCommons { } {
    \bool_set_true:N \l__UWMad_CCLicense_UseCreativeCommons_bool
}
\DeclareDocumentCommand \Attribution { } {
    \bool_set_true:N \l__UWMad_CCLicense_UseAttribution_bool
}
\DeclareDocumentCommand \NonCommercial { } {
    \bool_set_true:N \l__UWMad_CCLicense_UseNonCommercial_bool
}
\DeclareDocumentCommand \ShareAlike { } {
    \bool_set_true:N \l__UWMad_CCLicense_UseShareAlike_bool
}
\DeclareDocumentCommand \NoDerivs { } {
    \bool_set_true:N \l__UWMad_CCLicense_UseNoDerivatives_bool
}
\DeclareDocumentCommand \CCVersion { m } {
    \tl_set:Nn \l__UWMad_CCLicense_Version_tl {##1}
}
\DeclareDocumentCommand \CCPorting { m } {
    \tl_set:Nn \l__UWMad_CCLicense_Porting_tl {##1}
}
\DeclareDocumentCommand \CCURL { m } {
    \tl_set:Nn \l__UWMad_CCLicense_URL_Front_tl  {##1}
    \tl_set:Nn \l__UWMad_CCLicense_URL_Middle_tl {/.}
    \tl_set:Nn \l__UWMad_CCLicense_URL_Back_tl   {}
}
\DeclareDocumentCommand \CCURLText { m } {
    \tl_set:Nn \l__UWMad_CCLicense_URLText_tl {##1}
}
} {

    \bool_if:nTF {  \l__UWMad_CCLicense_UseCreativeCommons_bool &&
                    \l__UWMad_Copyright_UseCopyright_bool       } {
        \msg_new:nnn { UWMadThesis } { SpecialPages / MultipleLicenses } {
            Both~Creative~Commons~and~Copyright~have~been~declared.~
            Please,~pick~one.
        }
        \msg_error:nn { UWMadThesis } { SpecialPages / MultipleLicenses }
    } {

        \bool_if:NTF \l__UWMad_CCLicense_UseCreativeCommons_bool {
            \__UWMad_CCLicense_CreateType:
            \__UWMad_CCLicense_CheckTypeValidity:
            \bool_if:NTF \l__UWMad_CCLicense_IsValid_bool {
                \__UWMad_CCLicense_PrintPage:
            } { }
        } { }

        \bool_if:NTF \l__UWMad_Copyright_UseCopyright_bool {
            \__UWMad_Copyright_PrintPage:
        } { }
    }

}
\ExplSyntaxOff
