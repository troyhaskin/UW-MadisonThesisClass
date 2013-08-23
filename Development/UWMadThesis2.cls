\RequirePackage{expl3}[2013/07/28]
\@ifpackagelater{expl3}{2013/07/28} {} {%
    \PackageError{UWMadThesis}{Version of l3kernel is too old}
      {%
        Please install an up to date version of l3kernel\MessageBreak
        using your TeX package manager or from CTAN.
      }%
    \endinput
}%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{UWMadThesis}
    [2013/08/21~v1.0~|~LaTeX2e+~Thesis~Class~for~UW-Madison]
\ExplSyntaxOn
\tl_const:Nn \c_UWMad_ClassName_tl        {UWMadThesis}
\tl_const:Nn \c_UWMad_UniversityLong_tl   {University~of~Wisconsin-Madison}
\tl_const:Nn \c_UWMad_UniversityShort_tl  {UW-Madison}
\tl_const:Nn \c_UWMad_ClassVersion_tl     {1.0}
\tl_const:Nn \c_UWMad_ClassVersionDate_tl {2012/01/09}
\cs_new_eq:NN \UWMadClassName    \c_UWMad_ClassName_tl
\cs_new_eq:NN \UWMadLong         \c_UWMad_UniversityLong_tl
\cs_new_eq:NN \UWMadShort        \c_UWMad_UniversityShort_tl
\cs_new_eq:NN \UWMadClassVersion \c_UWMad_ClassVersion_tl
\cs_new_eq:NN \UWMadClassDate    \c_UWMad_ClassVersionDate_tl
\tl_new:N      \g_UWMad_ParentClass_tl
\tl_gset:Nn \g_UWMad_ParentClass_tl {report}
\msg_new:nnn{UWMadThesis}{Options/StyleViolation}{
    Option~'#1'~violates~\c_UWMadUniversityShort_tl{}~
    Dissertation~Guidelines;~consider~omission
}
\cs_new:Nn \__UWMad_FrontMatter_StyleWarning:n {
    \msg_warning{UWMadThesis}{Options/StyleViolation}
        {#1}
   \PassOptionsToClass{#1}{\g_UWMad_TheParentClass_tl}
}
\bool_new:N       \g__UWMad_MathTweaks_bool
\bool_gset_true:N \g__UWMad_MathTweaks_bool
\bool_new:N       \g__UWMad_PDFMetaDataTweaks_bool
\bool_gset_true:N \g__UWMad_PDFMetaDataTweaks_bool
\bool_new:N       \g__UWMad_Hyperlinks_bool
\bool_gset_true:N \g__UWMad_Hyperlinks_bool
\DeclareOption{NoMath} {
    \bool_gset_false:N \g__UWMad_MathTweaks_bool
}
\DeclareOption{NoPDFMeta} {
    \bool_gset_false:N \g__UWMad_PDFMetaDataTweaks_bool
}
\DeclareOption{NoLinks} {
    \bool_gset_false:N \g__UWMad_Hyperlinks_bool
}
\DeclareOption{a4paper} {
    \__UWMad_FrontMatter_StyleWarning:N{\CurrentOption}
}
\DeclareOption{twoside} {
    \__UWMad_FrontMatter_StyleWarning:N{\CurrentOption}
}
\DeclareOption{article}
    {\tl_gset:Nn \g_UWMad_@TheParentClass_tl {article}}
\DeclareOption{l3doc}
    {\tl_gset:Nn \g_UWMad_@TheParentClass_tl {l3doc}}
\DeclareOption*{
    \PassOptionsToClass
        {\CurrentOption}{\g_UWMad_@TheParentClass_tl}
}
\ExecuteOptions{oneside,12pt}
\ProcessOptions\relax
\LoadClass{\g_UWMad_TheParentClass_tl}[1995/12/01]
\RequirePackage{xparse}
\RequirePackage{fixltx2e}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{geometry}
\bool_if:NTF \g__UWMad_MathTweaks_bool {
    \RequirePackage[intlimits,sumlimits]{amsmath}
    \RequirePackage{amssymb}
    \RequirePackage{amsfonts}
}{}
\bool_if:NTF \g__UWMad_Hyperlinks_bool {
    \RequirePackage{bookmark}  % Provides an improvement to hyperref
}{}
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
%%^^A ======================================================================= %
%%^^A                     Collection Creation Commands                        %
%%^^A ======================================================================= %
%%
%%   \subsubsection{Collections}
%%   In the following subsections, commands that create and manipulate
%%   various collection data types will be discussed.  The collections
%%   currently implemented are stacks (LIFO), queues (FIFO), and deques
%%   (LIFO+FIFO).
%%
%%   All of the collection systems are thin abstractions of \LaTeXPL's
%%   |l3seq| module to avoid developing one-shot systems while allowing more
%%   endeavoring authors access to the features without learning \LaTeX3{}
%%   programming.
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
        \tl_set:Nx \l_tmpa_tl          {\tl_head:c {g__UWMad_Stack_#1}}
        \tl_set:cx {g__UWMad_Stack_#1} {\tl_tail:c {g__UWMad_Stack_#1}}
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
\cs_new:Nn \UWMad_Queue_Delete:n {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \tl_gclear:c    {g__UWMad_Queue_#1}
         \cs_undefine:c {g__UWMad_Queue_#1}
    }
}
\cs_new:Nn \UWMad_Queue_Clear:n {
    \__UWMad_Queue_IfDefined:nT {#1} {
        \tl_gclear:c {g__UWMad_Queue_#1}
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
        \tl_set:Nx \l_tmpa_tl
            {\tl_head:c {g__UWMad_Queue_#1}}
        \tl_set:cx      {g__UWMad_Queue_#1}
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

\cs_new:Nn \UWMad_Hash_Get:nn {
    \__UWMad_Hash_IfDefined:nT {#1} {
        \prop_get:cxNTF {g__UWMad_Hash_#1} {#2} \l_tmpa_prop {
            \tl_use:N \l_tmpa_prop
        }
    }
}

\cs_generate_variant:Nn \prop_get:cn {cf}

\cs_new:Nn \UWMad_Hash_ExpandableGet:nn {
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
\DeclareDocumentCommand \LoadLaTeXeAbstractions { } {
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
\DeclareDocumentCommand \MakeCommand { m +m } {
    \cs_set:cpn {##1} {##2}
}
\DeclareDocumentCommand \ReMakeCommand { m +m }{
    \IfCommandExists{##1}{
        \cs_set:cpn {##1} {##2}
    }{
        \UWMad@ClassWarning{Command~`##1'~is~undefined.}
    }
}
\DeclareDocumentCommand \MakeGlobalCommand { m +m } {
    \cs_gset:cpn {##1} {##2}
}
\DeclareDocumentCommand \MakeExpandedCommand { m +m } {
    \cs_get:cpx {##1} {##2}
}
\DeclareDocumentCommand \MakeCommandUndefined { m } {
    \cs_undefine:c {##1}
}
\DeclareDocumentCommand \CopyCommand { m m } {
    \IfCommandExists{##1} {
        \IfCommandExists{##2} {
            \UWMad@ClassWarning{Command~`##2'~is~defined.}
        }{
        }
        \cs_gset_eq:cc {##2}{##1}
    }{
        \UWMad@ClassWarning{Command~`##1'~is~undefined.}
    }
}
}
\ExplSyntaxOff
\ExplSyntaxOn

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
        \IfCommandEmpty{\contentsname}{
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
\UWMad_Hash_Set:nnn  {NextSectioningCommand}{part}          {chapter}
\UWMad_Hash_Set:nnn  {NextSectioningCommand}{chapter}       {section}
\UWMad_Hash_Set:nnn  {NextSectioningCommand}{section}       {subsection}
\UWMad_Hash_Set:nnn  {NextSectioningCommand}{subsection}    {subsubsection}
\UWMad_Hash_Set:nnn  {NextSectioningCommand}{subsubsection} {paragraph}
\UWMad_Hash_Set:nnn  {NextSectioningCommand}{paragraph}     {subparagraph}
\UWMad_Hash_Define:n {PreviousSectioningCommand}
\UWMad_Hash_Set:nnn  {PreviousSectioningCommand}{part}          {chapter}
\UWMad_Hash_Set:nnn  {PreviousSectioningCommand}{chapter}       {section}
\UWMad_Hash_Set:nnn  {PreviousSectioningCommand}{section}       {subsection}
\UWMad_Hash_Set:nnn  {PreviousSectioningCommand}{subsection}    {subsubsection}
\UWMad_Hash_Set:nnn  {PreviousSectioningCommand}{subsubsection} {paragraph}
\UWMad_Hash_Set:nnn  {PreviousSectioningCommand}{paragraph}     {subparagraph}

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

\ExplSyntaxOff
