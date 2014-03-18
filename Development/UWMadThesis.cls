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
\bool_if:NTF \g__UWMad_Hyperlinks_bool {
    \RequirePackage{hyperref}
    \RequirePackage{bookmark}
} {
    \DeclareDocumentCommand \href { o m m } {
        #3
    }
    \cs_gset_eq:NN \phantomsection \relax
}
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
\RequirePackage[noabbrev]{cleveref}
\RequirePackage[usenames,dvipsnames,svgnames,table,hyperref]{xcolor}
\RequirePackage{subfig}
\RequirePackage{caption}
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
\bool_if:NTF \g__UWMad_Hyperlinks_bool {
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
        bookmarksopenlevel = 3          ,
        bookmarksopen      = true       ,
        unicode            = true
    }
} {}
\pagestyle{myheadings}
\pagenumbering{roman}
\doublespacing
\setlength{\parindent}{ 0pt}
\setlength{\parskip}  {10pt}
\setlength{\headsep}  {15pt}

\let\DefaultChapter\@chapter

\tl_new:N  \g_UWMad_Sectioning_ChapterPageStyle_tl
\tl_set:Nn \g_UWMad_Sectioning_ChapterPageStyle_tl
    {\thispagestyle{myheadings}}

\def\@chapter{
    \tl_use:N \g_UWMad_Sectioning_ChapterPageStyle_tl
    \ifnum \value{chapter}=0
        \pagenumbering{arabic}
    \fi
    \DefaultChapter
}


\UWMad_Counter_DefineGlobal:nn{Appendix}{0}

\newcommand{\AppendixInitializer}{
    \par
    \setcounter{section}{0}
    \def\@chapapp{\appendixname}
    \def\thechapter{
        \@Alph{
            \UWMad_Counter_Value:n{Appendix}
        }
    }
}

\renewcommand{\appendix}{
    \UWMad_Counter_Compare:nnnTF{Appendix}{=}{0} {
        \AppendixInitializer
    }{}
    \UWMad_Counter_Step:n{Appendix}
    \chapter
}

\UWMad_Counter_DefineGlobal:nn{FrontMatter}{0}

\cs_new:Nn \__UWMad_Sectioning_FrontMatterRegister:nn {
    \addcontentsline{toc}{#1}{#2}
    \UWMad_Counter_Step:n{FrontMatter}
}

\cs_undefine:N \abstract
\cs_undefine:N \endabstract

\DeclareDocumentCommand \dedications     { O{Dedications}    } {
    \chapter*{#1}
    \__UWMad_Sectioning_FrontMatterRegister:nn{chapter}{#1}
}
\DeclareDocumentCommand \acknowledgments { O{acknowledgments}} {
    \chapter*{#1}
    \__UWMad_Sectioning_FrontMatterRegister:nn{chapter}{#1}
}
\DeclareDocumentCommand \abstract        { O{Abstract}       } {
    \chapter*{#1}
    \__UWMad_Sectioning_FrontMatterRegister:nn{chapter}{#1}
}
\DeclareDocumentCommand \umiabstract     { O{Abstract}       } {
    \chapter*{#1}
    \__UWMad_Sectioning_FrontMatterRegister:nn{chapter}{#1}
}
\DeclareDocumentCommand \preface         { O{Preface}        } {
    \chapter*{#1}
    \__UWMad_Sectioning_FrontMatterRegister:nn{chapter}{#1}
}


\cs_gset_eq:NN \TableOfContentsDefault \tableofcontents
\cs_gset_eq:NN \ListOfTablesDefault    \listoftables
\cs_gset_eq:NN \ListOfFiguresDefault   \listoffigures

\cs_undefine:N \tableofcontents
\cs_undefine:N \listoftables
\cs_undefine:N \listoffigures
\cs_undefine:N \contentsname

\tl_new:N   \g__UWMad_Sectioning_TOCName_tl
\tl_gset:Nn \g__UWMad_Sectioning_TOCName_tl {Table~of~Contents}

\tl_new:N   \g__UWMad_Sectioning_LOTName_tl
\tl_gset:Nn \g__UWMad_Sectioning_LOTName_tl {List~of~Tables}

\tl_new:N   \g__UWMad_Sectioning_LOFName_tl
\tl_gset:Nn \g__UWMad_Sectioning_LOFName_tl {List~of~Figures}

\DeclareDocumentCommand \tableofcontents { } {
    \group_begin:
        \tl_if_empty:nTF {\contentsname}{
            \cs_set_eq:NN \contentsname \g__UWMad_Sectioning_TOCName_tl
        }{}
        \setstretch{1.05}
        \phantomsection
        \__UWMad_Sectioning_FrontMatterRegister:nn
            {chapter}
            {\contentsname}
        \TableOfContentsDefault
        \clearpage
    \group_end:
}
\DeclareDocumentCommand \listoftables { } {
    \group_begin:
        \cs_set_eq:NN \listtablename \g__UWMad_Sectioning_LOTName_tl
        \setstretch{1.05}
        \__UWMad_Sectioning_FrontMatterRegister:nn
            {chapter}
            {\listtablename}
        \ListOfTablesDefault
        \clearpage
    \group_end:
}
\DeclareDocumentCommand \listoffigures { } {
    \group_begin:
        \cs_set_eq:NN \listfigurename \g__UWMad_Sectioning_LOFName_tl
        \setstretch{1.05}
        \__UWMad_Sectioning_FrontMatterRegister:nn
            {chapter}
            {\listfigurename}
        \ListOfFiguresDefault
        \clearpage
    \group_end:
}

\cs_set_eq:NN \TableOfContents \tableofcontents
\cs_set_eq:NN \ListOfTables    \listoftables
\cs_set_eq:NN \ListOfFigures   \listoffigures
\UWMad_Hash_Define:n {SectionToLevel}
\UWMad_Hash_Set:nnn  {SectionToLevel}{part}          {-1}
\UWMad_Hash_Set:nnn  {SectionToLevel}{chapter}       {0}
\UWMad_Hash_Set:nnn  {SectionToLevel}{section}       {1}
\UWMad_Hash_Set:nnn  {SectionToLevel}{subsection}    {2}
\UWMad_Hash_Set:nnn  {SectionToLevel}{subsubsection} {3}
\UWMad_Hash_Set:nnn  {SectionToLevel}{paragraph}     {4}
\UWMad_Hash_Set:nnn  {SectionToLevel}{subparagraph}  {5}
\UWMad_Hash_Define:n {LevelToSection}
\UWMad_Hash_Set:nnn  {LevelToSection}{-1}{part}
\UWMad_Hash_Set:nnn  {LevelToSection}{0} {chapter}
\UWMad_Hash_Set:nnn  {LevelToSection}{1} {section}
\UWMad_Hash_Set:nnn  {LevelToSection}{2} {subsection}
\UWMad_Hash_Set:nnn  {LevelToSection}{3} {subsubsection}
\UWMad_Hash_Set:nnn  {LevelToSection}{4} {paragraph}
\UWMad_Hash_Set:nnn  {LevelToSection}{5} {subparagraph}
\UWMad_Hash_Define:n {NextSectioningCommand}
\UWMad_Hash_Set:nnn
    {NextSectioningCommand}{part}          {chapter}
\UWMad_Hash_Set:nnn
    {NextSectioningCommand}{chapter}       {section}
\UWMad_Hash_Set:nnn
    {NextSectioningCommand}{section}       {subsection}
\UWMad_Hash_Set:nnn
    {NextSectioningCommand}{subsection}    {subsubsection}
\UWMad_Hash_Set:nnn
    {NextSectioningCommand}{subsubsection} {paragraph}
\UWMad_Hash_Set:nnn
    {NextSectioningCommand}{paragraph}     {subparagraph}
\UWMad_Hash_Define:n {PreviousSectioningCommand}
\UWMad_Hash_Set:nnn
    {PreviousSectioningCommand}{part}          {chapter}
\UWMad_Hash_Set:nnn
    {PreviousSectioningCommand}{chapter}       {section}
\UWMad_Hash_Set:nnn
    {PreviousSectioningCommand}{section}       {subsection}
\UWMad_Hash_Set:nnn
    {PreviousSectioningCommand}{subsection}    {subsubsection}
\UWMad_Hash_Set:nnn
    {PreviousSectioningCommand}{subsubsection} {paragraph}
\UWMad_Hash_Set:nnn
    {PreviousSectioningCommand}{paragraph}     {subparagraph}

\newcommand{\LevelToSection}[1]{% #1 = Counter for desired level
    \HashExpandableGet{LevelToSection}{#1}}

\newcommand{\SectionToLevel}[1]{% #1 = section
    \HashExpandableGet{SectionToLevel}{#1}}

\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {-3.25ex\@plus -1ex \@minus -.2ex}%
                                    {1.5ex \@plus .2ex}%
                                    {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                    {-3.25ex\@plus -1ex \@minus -.2ex}%
                                    {1.5ex \@plus .2ex}%
                                    {\normalfont\normalsize\bfseries}}
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
    \tl_new:c {l__UWMad_ListOf#1_SectionMain_tl}
    \tl_new:c {l__UWMad_ListOf#1_SectionGroup_tl}
    \tl_new:c {l__UWMad_ListOf#1_SectionSubgroup_tl}
    \tl_new:c {l__UWMad_ListOf#1_TitleMain_tl}
    \tl_new:c {l__UWMad_ListOf#1_TitleGroup_tl}
    \tl_new:c {l__UWMad_ListOf#1_TitleSubgroup_tl}
    \bool_new:c       {l__UWMad_ListOf#1_IsNumbered_bool}
    \bool_gset_true:c {l__UWMad_ListOf#1_IsNumbered_bool}
    \bool_new:c       {l__UWMad_ListOf#1_IncludeInTOC_bool}
    \bool_gset_true:c {l__UWMad_ListOf#1_IncludeInTOC_bool}
    \UWMad_Queue_Define:n               {__ListOf#1_EntryQueue}
    \UWMad_Hash_Define:n                {__ListOf#1_Hook}
}
\cs_new:Nn \UWMad_ListOf_Delete:n {
    \cs_undefine:c {c__UWMad_ListOf#1_IsDefined_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_SectionMain_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_SectionGroup_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_SectionSubgroup_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_TitleMain_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_TitleGroup_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_TitleSubgroup_tl}

    \show\bool_new:N

    \cs_undefine:c {l__UWMad_ListOf#1_IsNumbered_bool}
    \cs_undefine:c {l__UWMad_ListOf#1_IncludeInTOC_bool}
    \UWMad_Queue_Delete:n   {__ListOf#1_EntryQueue}
    \UWMad_Hash_Delete:n    {__ListOf#1_Hook}
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
        \bool_set_true:c {l__UWMad_ListOf#1_IsNumbered_bool}
    }
}
\cs_new:Nn \UWMad_ListOf_MakeNotNumbered:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_set_false:c {l__UWMad_ListOf#1_IsNumbered_bool}
    }
}
\cs_new:Nn \UWMad_ListOf_IfNumbered:nTF {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \bool_if:cTF {c__UWMad_ListOf#1_IsNumbered_bool} {
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
\cs_new:Nn \UWMad_ListOf_SetTitleMain:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {l__UWMad_ListOf#1_TitleMain_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitleGroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {l__UWMad_ListOf#1_TitleGroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitleSubgroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {l__UWMad_ListOf#1_TitleSubgroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_GetTitleMain:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {l__UWMad_ListOf#1_TitleMain_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetTitleGroup:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {l__UWMad_ListOf#1_TitleGroup_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetTitleSubgroup:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {l__UWMad_ListOf#1_TitleSubgroup_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSectionMain:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {l__UWMad_ListOf#1_SectionMain_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSectionGroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {l__UWMad_ListOf#1_SectionGroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSectionSubgroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_set:cn {l__UWMad_ListOf#1_SectionSubgroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_GetSectionMain:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {l__UWMad_ListOf#1_SectionMain_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetSectionGroup:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {l__UWMad_ListOf#1_SectionGroup_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_GetSectionSubgroup:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_use:c {l__UWMad_ListOf#1_SectionSubgroup_tl}
    }
}
\cs_new:Nn \UWMad_ListOf_PushEntry:nn {
    \UWMad_Queue_Push:nn{__ListOf#1_EntryQueue}{#2}
}
\cs_new:Nn \UWMad_ListOf_SetHook:nnn {
    \UWMad_Hash_Set:nnn{__ListOf#1_Hook}{#2}{#3}
}
\cs_new:Nn \UWMad_ListOf_PrintEntries:n {
    \UWMad_Hash_Get:nn   {__ListOf#1_Hook}{PrePrint}
    \UWMad_Queue_Walk:nn {__ListOf#1_EntryQueue}{##1}
    \UWMad_Queue_Clear:n {__ListOf#1_EntryQueue}
    \UWMad_Hash_Get:nn   {__ListOf#1_Hook}{PostPrint}
}
\cs_new:Nn \UWMad_ListOf_PrintTitle:nn {
    \UWMad_ListOf_IfNumbered:nTF {#1} {
        \UWMad_ListOf_IfIncludeInTOC:nTF {#1} {
            \cs:w\tl_use:c {l__UWMad_ListOf#1_Section#2_tl}\cs_end:
            {\tl_use:c {l__UWMad_ListOf#1_Title#2_tl}}
        }{
            \cs:w\tl_use:c {l__UWMad_ListOf#1_Section#2_tl}\cs_end:*
            {\tl_use:c {l__UWMad_ListOf#1_Title#2_tl}}
        }
    } {
        \UWMad_ListOf_IfIncludeInTOC:nTF {#1} {
            \phantomsection
            \addcontentsline
                {toc}
                {\tl_use:c {l__UWMad_ListOf#1_Section#2_tl}}
                {\tl_use:c {l__UWMad_ListOf#1_Title#2_tl}}
        }{}
        \cs:w\tl_use:c {l__UWMad_ListOf#1_Section#2_tl}\cs_end:*
        {\tl_use:c {l__UWMad_ListOf#1_Title#2_tl}}
    }
}
\cs_new:Nn \UWMad_ListOf_StartGroup:nn {
    \UWMad_ListOf_PrintEntries:n{#1}
    \UWMad_ListOf_PrintTitle:nn{#1}{#2}
}
\UWMad_Length_DefineGlobal:nn {__Nomenclature-WidestSymbol}         {0pt}
\UWMad_Length_DefineGlobal:nn   {Nomenclature-TitleSkip}            {0em}
\UWMad_Length_DefineGlobal:nn   {Nomenclature-PrintSkip}            {1em}
\UWMad_Length_DefineGlobal:nn   {Nomenclature-EntryMarginLeft}      {1em}
\UWMad_Length_DefineGlobal:nn   {Nomenclature-EntryMarginBottom}    {0.25em}
\UWMad_Length_DefineGlobal:nn   {Nomenclature-EntryWidthSymbol}     {0em}
\UWMad_Length_DefineGlobal:nn   {Nomenclature-EntryWidthDescription}{0em}
\UWMad_Length_DefineGlobal:nn   {Nomenclature-EntryPadMiddle}       {0.75em}
\DeclareDocumentCommand  \ResetColumnWidth { }{
    \UWMad_Length_Set:nn {__Nomenclature-WidestSymbol}{0pt}
}
\cs_generate_variant:Nn \dim_set:Nn {Nf}

\cs_new:Nn \__UWMad_Nomenclature_UpdateWidest:n {
    \hbox_set:Nn \l_tmpa_box {#1}
    \dim_set:Nf  \l_tmpa_dim {\box_wd:N \l_tmpa_box}
    \UWMad_Length_If:nnnTF{__Nomenclature-WidestSymbol} {<} {\l_tmpa_dim} {
        \UWMad_Length_Set:nn
            {__Nomenclature-WidestSymbol}
            {\l_tmpa_dim}
    }{
    }
}
\cs_new:Nn \__UWMad_Nomenclature_SetEntryWidths: {
    % Define Symbol minipage width
    \UWMad_Length_Set:nn {Nomenclature-EntryWidthSymbol} {
        \UWMad_Length_Of:n{__Nomenclature-WidestSymbol} +
        \UWMad_Length_Of:n{Nomenclature-EntryPadMiddle}
    }
    %
    % Define Description minipage width
    \UWMad_Length_Set:nn{Nomenclature-EntryWidthDescription} {
        0.99\textwidth -
        \UWMad_Length_Of:n{Nomenclature-EntryWidthSymbol} -
        \UWMad_Length_Of:n{Nomenclature-EntryMarginLeft}
    }
}
\cs_new:Nn \__UWMad_Nomenclature_Entry:nn {
    \group_begin:
        \setstretch{1.1}
        \skip_horizontal:n{\UWMad_Length_Of:n{Nomenclature-EntryMarginLeft}}
        \begin{minipage}[t]
            {\UWMad_Length_Of:n{Nomenclature-EntryWidthSymbol}}
            #1
        \end{minipage}
        \begin{minipage}[t]
            {\UWMad_Length_Of:n{Nomenclature-EntryWidthDescription}}
           #2
        \end{minipage}
        \skip_vertical:n{\UWMad_Length_Of:n{Nomenclature-EntryMarginBottom}}
    \group_end:
}
\DeclareDocumentEnvironment {Nomenclature} { s O{chapter} G{Nomenclature} } {
    \UWMad_Hash_IfKeySet:nnTF {SectionToLevel}{#2}{
    }{
        \UWMad@ClassError
            {Nomenclature~environment~received~invalid~section~`#2'}
    }
    \UWMad_ListOf_Define:n {Nomenclature}
    \IfBooleanTF {#1} {
        \UWMad_ListOf_MakeNotNumbered:n {Nomenclature}
    }{
        \UWMad_ListOf_MakeNumbered:n    {Nomenclature}
    }
    \UWMad_ListOf_SetSectionMain:nn  {Nomenclature} {#2}
    \UWMad_ListOf_SetSectionGroup:nn {Nomenclature} {
        \UWMad_Hash_Get:nn{NextSectioningCommand}{#2}
    }
    \UWMad_ListOf_SetSectionSubgroup:nn {Nomenclature} {
        \UWMad_Hash_Get:nn{NextSectioningCommand} {
            \UWMad_ListOf_GetSectionGroup:n{Nomenclature}
        }
    }
    \DeclareDocumentCommand \Entry { m m } {
        \UWMad_ListOf_PushEntry:nn {Nomenclature} {
            \__UWMad_Nomenclature_Entry:nn
                {##1}
                {##2}
        }
        \__UWMad_Nomenclature_UpdateWidest:n{##1}
    }
    \UWMad_ListOf_SetHook:nnn {Nomenclature} {PrePrint} {
        \__UWMad_Nomenclature_SetEntryWidths:
    }
    \UWMad_ListOf_SetHook:nnn {Nomenclature} {PostPrint} {
        \ResetColumnWidth{}
    }
    \UWMad_ListOf_SetTitleMain:nn {Nomenclature}{#3}
    \UWMad_ListOf_PrintTitle:nn {Nomenclature}{Main}
    \DeclareDocumentCommand \Group { s G{} } {
        \IfBooleanTF {##1} {
            \UWMad_ListOf_MakeNotNumbered:n {Nomenclature}
        }{
            \UWMad_ListOf_MakeNumbered:n    {Nomenclature}
        }
        \UWMad_ListOf_SetTitleGroup:nn {Nomenclature}{##2}
        \UWMad_ListOf_StartGroup:nnn{Nomenclature}{Group}
    }
    \DeclareDocumentCommand \SubGroup { s G{} } {
        \IfBooleanTF {##1} {
            \UWMad_ListOf_MakeNotNumbered:n {Nomenclature}
        }{
            \UWMad_ListOf_MakeNumbered:n    {Nomenclature}
        }
        \UWMad_ListOf_SetTitleSubgroup:nn {Nomenclature}{##2}
        \UWMad_ListOf_StartGroup:nnn{Nomenclature}{Subgroup}
    }
}{
    \UWMad_ListOf_PrintEntries:n {Nomenclature}
    \UWMad_ListOf_Delete:n{Nomenclature}
}
\cs_new:cpn      {Nomenclature*} {\Nomenclature*}
\cs_new_eq:cN {endNomenclature*} \endNomenclature
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
    \end{center}
    \clearpage
}

\show\title

\newcommand{\AllRightsReserved}{
    \large
    \copyright{} Copyright by \TheLicenseAuthor(\the\year)\\
    All Rights Reserved
}
\cs_gset_eq:NN \Copyright \AllRightsReserved
\tl_new:N    \g__UWMad_CCLicense_Porting_tl
\tl_new:N    \g__UWMad_CCLicense_Version_tl
\tl_new:N    \g__UWMad_CCLicense_TypeAbbreviation_tl
\tl_new:N    \g__UWMad_CCLicense_TypeWords_tl
\tl_new:N    \g__UWMad_CCLicense_URL_Front_tl
\tl_new:N    \g__UWMad_CCLicense_URL_Middle_tl
\tl_new:N    \g__UWMad_CCLicense_URL_Back_tl
\tl_new:N    \g__UWMad_CCLicense_URL_tl
\tl_const:Nn \g__UWMad_CCLicense_Valid_Prefix {__UWMad_CCLicense_Valid_}
\bool_new:N \g__UWMad_CCLicense_UseCreativeCommons_bool
\bool_new:N \g__UWMad_CCLicense_UseAttribution_bool
\bool_new:N \g__UWMad_CCLicense_UseShareAlike_bool
\bool_new:N \g__UWMad_CCLicense_UseNoDerivatives_bool
\bool_new:N \g__UWMad_CCLicense_UseNonCommercial_bool
\bool_new:N \g__UWMad_CCLicense_IsValid_bool
\bool_gset_true:N \g__UWMad_CCLicense_UseAttribution_bool
\cs_new:cn {\g__UWMad_CCLicense_Valid_Prefix by :}      {}
\cs_new:cn {\g__UWMad_CCLicense_Valid_Prefix by-sa :}   {}
\cs_new:cn {\g__UWMad_CCLicense_Valid_Prefix by-nd :}   {}
\cs_new:cn {\g__UWMad_CCLicense_Valid_Prefix by-nc :}   {}
\cs_new:cn {\g__UWMad_CCLicense_Valid_Prefix by-nc-sa :}{}
\cs_new:cn {\g__UWMad_CCLicense_Valid_Prefix by-nc-nd :}{}
\tl_gset:Nn \g__UWMad_CCLicense_Porting_tl {
    International
}
\tl_gset:Nn \g__UWMad_CCLicense_Version_tl {
    4.0
}
\tl_gset:Nn \g__UWMad_CCLicense_URL_Front_tl {
    creativecommons.org/licenses/
}
\tl_gset:Nn \g__UWMad_CCLicense_URL_Middle_tl {
    \g__UWMad_CCLicense_TypeAbbreviation_tl/
}
\tl_gset:Nn \g__UWMad_CCLicense_URL_Back_tl {
    \g__UWMad_CCLicense_Version_tl
}
\tl_gset:Nn \g__UWMad_CCLicense_URL_tl {
    http://
    \g__UWMad_CCLicense_URL_Front_tl
    \g__UWMad_CCLicense_URL_Middle_tl
    \g__UWMad_CCLicense_URL_Back_tl
}
\cs_new:Nn \__UWMad_CCLicense_CreateType: {

        \bool_if:NTF \g__UWMad_CCLicense_UseAttribution_bool {

            \tl_put_right:Nn \g__UWMad_CCLicense_TypeAbbreviation_tl {
                by
            }
            \tl_put_right:Nn \g__UWMad_CCLicense_TypeWords_tl {
                Attribution
            }

        } { }

        \bool_if:NTF \g__UWMad_CCLicense_UseNonCommercial_bool {

            \tl_put_right:Nn \g__UWMad_CCLicense_TypeAbbreviation_tl {
                -nc
            }
            \tl_put_right:Nn \g__UWMad_CCLicense_TypeWords_tl {
                -NonCommercial
            }

        } { }

        \bool_if:NTF \g__UWMad_CCLicense_UseShareAlike_bool {

            \tl_put_right:Nn \g__UWMad_CCLicense_TypeAbbreviation_tl {
                -sa
            }
            \tl_put_right:Nn \g__UWMad_CCLicense_TypeWords_tl {
                -ShareAlike
            }

        } { }

        \bool_if:NTF \g__UWMad_CCLicense_UseNoDerivatives_bool {

            \tl_put_right:Nn \g__UWMad_CCLicense_TypeAbbreviation_tl {
                -nd
            }
            \tl_put_right:Nn \g__UWMad_CCLicense_TypeWords_tl {
                -NoDerivatives
            }

        } { }
}
\cs_new:Nn \__UWMad_CCLicense_CheckTypeValidity: {
    \cs_if_exist:cTF {
        \g__UWMad_CCLicense_Valid_Prefix
        \g__UWMad_CCLicense_TypeAbbreviation_tl :
    } {

        \bool_gset_true:N \g__UWMad_CCLicense_IsValid_bool

    } {

        \msg_new:nnn {UWMadThesis} {CCLicense / InvalidLicenseType} {
            The~license~type~`\g__UWMad_CCLicense_TypeAbbreviation_tl'~
            is~not~a~valid~Creative~Commons~license.
        }
        \msg_error:nn {UWMadThesis} {CCLicense / InvalidLicenseType}

    }
}
\cs_new:Nn \__UWMad_CCLicense_PrintPage: {

    {
        \clearpage
        \thispagestyle{empty}
        \null
        \tex_vfill:D
        \phantomsection
        \addcontentsline {toc} {chapter} {License}
        \begin{center}
            \Large
            \iffalse
            This~work~is~released~under~a~
            Creative~Commons~
            \g__UWMad_CCLicense_TypeWords_tl{}~
            \g__UWMad_CCLicense_Version_tl{}~
            \g__UWMad_CCLicense_Porting_tl{}~
            license.\\[0.1em]

            (\g__UWMad_CCLicense_URL_tl{})
            \fi

            This~work~is~released~under~a~
            \href {\g__UWMad_CCLicense_URL_tl} {
                Creative~Commons~
                \g__UWMad_CCLicense_TypeWords_tl{}~
                \g__UWMad_CCLicense_Version_tl{}~
                \g__UWMad_CCLicense_Porting_tl{}
            }~
            license.\\[0.1em]

            (\g__UWMad_CCLicense_URL_tl{}/)
        \end{center}
    }
}
\DeclareDocumentCommand \CreativeCommons { } {
    \bool_gset_true:N \g__UWMad_CCLicense_UseCreativeCommons_bool
}
\DeclareDocumentCommand \NonCommercial { } {
    \bool_gset_true:N \g__UWMad_CCLicense_UseNonCommercial_bool
}
\DeclareDocumentCommand \ShareAlike { } {
    \bool_gset_true:N \g__UWMad_CCLicense_UseShareAlike_bool
}
\DeclareDocumentCommand \NoDerivatives { } {
    \bool_gset_true:N \g__UWMad_CCLicense_UseNoDerivatives_bool
}
\DeclareDocumentEnvironment {LicensePage} { } { } {

    \bool_if:NTF \g__UWMad_CCLicense_UseCreativeCommons_bool {
        \__UWMad_CCLicense_CreateType:
        \__UWMad_CCLicense_CheckTypeValidity:
        \bool_if:NTF \g__UWMad_CCLicense_IsValid_bool {
            \__UWMad_CCLicense_PrintPage:
        } { }
    } { }

}

\ExplSyntaxOff
