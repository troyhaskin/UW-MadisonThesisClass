\RequirePackage{expl3}[2013/07/28]
\@ifpackagelater{expl3}{2013/07/28} {} {%
    \PackageError{UWMadThesis}{Version of l3kernel is too old}
      {%
        Please install an up to date version of l3kernel\MessageBreak
        using your TeX package manager or from CTAN.
      }%
    \endinput
}%
\ExplSyntaxOn
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{UWMadThesis}
    [2013/08/21~v1.0~|~LaTeX2e+~Thesis~Class~for~UW-Madison]
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
    \RequirePackage{amssymb}
    \RequirePackage{amsfonts}
}{}
\bool_if:NTF \g__UWMad_Hyperlinks_bool {
    \RequirePackage{hyperref}
    \RequirePackage{bookmark}
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
    \int_to_alpha:n {\UWMad_Counter_Value:n{#1}}
}
\cs_new:Nn \UWMad_Counter_Alpha:n {
    \int_to_Alpha:n {\UWMad_Counter_Value:n{#1}}
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
\tl_if_in:NnTF \g_UWMad_ParentClass_tl {l3doc} {
    \geometry{
        includemp      = true,
        margin         = 0.80in,
        marginparwidth = 1.00in,
        includehead    = true,
        paper          = letterpaper
    }
} {
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
}
\definecolor{UWMadGreen}{rgb}{0,0.7,0}
\bool_if:NTF \g__UWMad_Hyperlinks_bool {
    \hypersetup{
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
        unicode
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

\tl_if_in:NnTF \g_UWMad_ParentClass_tl {l3doc} {

    \UWMad_Counter_DefineGlobal:nn{Part}{0}
    \UWMad_Counter_DefineGlobal:nn{Module}{0}
    \UWMad_Counter_DefineGlobal:nn{Submodule}{0}
    \UWMad_Counter_DefineGlobal:nn{Feature}{0}

    \tl_new:N   \g_UWMad_ThePart_tl
    \tl_new:N \g_UWMad_TheModule_tl
    \tl_new:N \g_UWMad_TheSubmodule_tl
    \tl_new:N \g_UWMad_TheFeature_tl

    \tl_gset:Nn \g_UWMad_ThePart_tl {
        Part~\UWMad_Counter_Roman:n{Part}
    }
    \tl_gset:Nn \g_UWMad_TheModule_tl {
        Module~\UWMad_Counter_arabic:n{Module}
    }
    \tl_gset:Nn \g_UWMad_TheSubmodule_tl {
        \UWMad_Counter_arabic:n{Module}.
        \UWMad_Counter_arabic:n{Submodule}
    }
    \tl_gset:Nn \g_UWMad_TheFeature_tl {
        \g_UWMad_TheSubmodule_tl.
        \UWMad_Counter_arabic:n{Feature}
    }

    \cs_new:Nn \UWMad_Sectioning_Module:nn {
        \clearpage

        \UWMad_Counter_Step:n {Module}
        \UWMad_Counter_Set:nn {Submodule}{0}
        \UWMad_Counter_Set:nn {Feature}{0}

        \group_begin:
            \null\vskip 0.1em
            \phantomsection
            \textbf{
                \LARGE{
                    \g_UWMad_TheModule_tl
                }
            }
            \vskip 0.5em
            \textbf{\Huge{#2}}
        \group_end:
        \addcontentsline{toc}{section}{#1}
        \vskip 1em
        \par
    }

    \cs_new:Nn \UWMad_Sectioning_Submodule:nn {
        \UWMad_Counter_Step:n {Submodule}

        \group_begin:
            \null\vskip 0.1em
            \phantomsection
            \textbf{
                \Large{
                    \g_UWMad_TheSubmodule_tl
                    \hspace*{0.5em}#2
                }
            }
        \group_end:
        \addcontentsline{toc}{subsection}{#1}
        \vskip 0.2em
        \par
    }

    \cs_new:Nn \UWMad_Sectioning_Feature:nn {
        \UWMad_Counter_Step:n {Feature}

        \group_begin:
            \null\vskip 0.1em
            \phantomsection
            \textbf{
                \large{
                    \g_UWMad_TheFeature_tl
                    \hspace*{0.5em}#2
                }
            }
        \group_end:
        \addcontentsline{toc}{subsubsection}{#1}
        \vskip 0.2em
        \par
    }

    \DeclareDocumentCommand \UWModule { o m } {
        \IfNoValueTF {#1} {
            \UWMad_Sectioning_Module:nn{#2}{#2}
        } {
            \UWMad_Sectioning_Module:nn{#1}{#2}
        }
    }

    \DeclareDocumentCommand \UWSubmodule { o m } {
        \IfNoValueTF {#1} {
            \UWMad_Sectioning_Submodule:nn{#2}{#2}
        } {
            \UWMad_Sectioning_Submodule:nn{#1}{#2}
        }
    }

    \DeclareDocumentCommand \UWFeature { o m } {
        \IfNoValueTF {#1} {
            \UWMad_Sectioning_Feature:nn{#2}{#2}
        } {
            \UWMad_Sectioning_Feature:nn{#1}{#2}
        }
    }

    \RenewDocumentCommand   \part { o m } {
        \UWMad_Counter_Step:n{Part}
        \cleardoublepage
        \newgeometry{marginparwidth = 0pt}
        \group_begin:
            \vspace*{2in}
            \phantomsection
            \begin{center}
                \textbf{
                    \huge{\g_UWMad_ThePart_tl}
                    \vskip 0.30em
                    \Huge{#2}
                }
                \IfNoValueTF{#1} {
                    \addcontentsline{toc}{part}{#2}
                } {
                    \addcontentsline{toc}{part}{#1}
                }
            \end{center}
            \thispagestyle{empty}
        \group_end:
        \restoregeometry
        \clearpage
    }

    \setstretch{1.30}
    \setlength{\parindent}{0pt}

    % Play with macrocode env. formatting
    \let\BeginMacroCode\macrocode
    \let\EndMacroCode\endmacrocode

    \renewcommand{\macrocode}{
        \vspace*{-0.90em}
        \BeginMacroCode
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

}{}


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
\cs_new:Nn \UWMad_Math_NthRoot:nn {
    \root #1 \of {#2\:\!}
}
\cs_new:Nn \UWMad_Math_SquareRootCore:nn {
    \setbox0=\hbox{\ensuremath{\NthRootInTeX{#1}{#2}}}
    \dimen0=\ht0
    \advance\dimen0-0.2\ht0
    \setbox2=\hbox{\vrule height\ht0 depth -\dimen0}
    {\box0\lower0.47pt\box2}
}
\DeclareDocumentCommand \Sqrt { O{} m } {
    \mathchoice{\SquareRootCore{#1}{#2}}
               {\SquareRootCore{#1}{#2}}
               {\SquareRootCore{#1}{#2}}
               {\SquareRootCore{#1}{#2}}
}
\newcommand{\bigdiffn}[4]{\dfrac{#1{}^{#4}}{#1 #3{}^{#4}} \left[ #2 \right]}
\newcommand{\gendiffn}[4]{\dfrac{#1{}^{#4} #2}{#1 #3{}^{#4}}}
\tl_new:N \g__UWMad_Math_DerivativeToken_tl
\cs_new:Nn \__UWMad_Math_DerivativeToken:n {
    \tl_gset:Nn \g__UWMad_Math_DerivativeToken_tl {
        \tl_if_empty:nTF {#1} {d} {
            \tl_if_in:nnTF {#1} {d} {
                d
            } {
                \tl_if_in:nnTF {#1} {p} {
                    \partial
                } {
                    \tl_if_in:nnTF {#1} {t} {
                        D
                    } {
                        #1
                    }
                }
            }
        }
    }
}
\DeclareDocumentCommand \diff { O{} +m +m} {
    \gendiffn{\__UWMad_Math_DerivativeToken:n {#1}}{#2}{#3}{}
}
\newcommand{\diffn}[4][d]{
    \ifthenelse{\equal{p}{#1}}{
        \gendiffn{\partial}{#2}{#3}{#4}
    }{
        \ifthenelse{\equal{b}{#1}}{
            \bigdiffn{#2}{#3}{#4}
        }{
            \ifthenelse{\equal{bp}{#1}}{
                \bigdiffn{\partial}{#2}{#3}{#4}
            }{
                \gendiffn{#1}{#2}{#3}{#4}
            }
        }
    }
}
\newcommand{\bigdiff}   [2] {\diff[b]{#1}{#2}}
\newcommand{\pdiff}     [2] {\diff[p]{#1}{#2}}
\newcommand{\bigpdiff}  [2] {\diff[bp]{#1}{#2}}
\let\frac\dfrac
\newcommand{\subs}      [2][]{\ensuremath{{}_{#1\text{\scriptsize #2}}}}
\newcommand{\sups}      [2][]{\ensuremath{{}^{#1\text{\scriptsize #2}}}}
\newcommand{\oneo}      [1]  {\ensuremath{\frac{1}{#1}}}
\iffalse
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
    \let\Oldpsi       \psi       \renewcommand{\psi}       {\ensuremath{\Oldpsi       }\xspace}
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
    \fi
\cs_new:Nn \UWMad_ListOf_Define:n {
    \tl_const:cn {c__ListOf#1-Defined}{}
    \tl_new:c {l__UWMad_ListOf#1_SectionMain_tl}
    \tl_new:c {l__UWMad_ListOf#1_SectionGroup_tl}
    \tl_new:c {l__UWMad_ListOf#1_SectionSubgroup_tl}
    \tl_new:c {l__UWMad_ListOf#1_TitleMain_tl}
    \tl_new:c {l__UWMad_ListOf#1_TitleGroup_tl}
    \tl_new:c {l__UWMad_ListOf#1_TitleSubgroup_tl}
    \UWMad_Boolean_DefineGlobalSetTrue:n{__ListOf#1-Numbered}
    \UWMad_Boolean_DefineGlobalSetTrue:n{__ListOf#1-IncludeInTOC}
    \UWMad_Queue_Define:n               {__ListOf#1-EntryQueue}
    \UWMad_Hash_Define:n                {__ListOf#1-Hook}
}
\cs_new:Nn \UWMad_ListOf_Delete:n {
    \cs_undefine:c {c__ListOf#1-Defined}
    \cs_undefine:c {l__UWMad_ListOf#1_SectionMain_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_SectionGroup_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_SectionSubgroup_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_TitleMain_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_TitleGroup_tl}
    \cs_undefine:c {l__UWMad_ListOf#1_TitleSubgroup_tl}
    \UWMad_Boolean_Delete:n {__ListOf#1-Numbered}
    \UWMad_Boolean_Delete:n {__ListOf#1-IncludeInTOC}
    \UWMad_Queue_Delete:n   {__ListOf#1-EntryQueue}
    \UWMad_Hash_Delete:n    {__ListOf#1-Hook}
}
\cs_new:Nn \UWMad_ListOf_IfDefined:nT {
    \__UWMad_IfDefined:nnnnT
        {c__ListOf}
        {#1}
        {-Defined}
        {ListOf}
        {#2}
}
\cs_new:Nn \UWMad_ListOf_MakeNumbered:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \UWMad_Boolean_SetTrue:n {__ListOf#1-Numbered}
    }
}
\cs_new:Nn \UWMad_ListOf_MakeNotNumbered:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \UWMad_Boolean_SetFalse:n {__ListOf#1-Numbered}
    }
}
\cs_new:Nn \UWMad_ListOf_IfNumbered:nTF {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \UWMad_Boolean_IfTrue:nTF {__ListOf#1-Numbered} {
            #2
        }{
            #3
        }
    }
}
\cs_new:Nn \UWMad_ListOf_IncludeInTOC:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \UWMad_Boolean_SetTrue:n {__ListOf#1-IncludeInTOC}
    }
}
\cs_new:Nn \UWMad_ListOf_DoNotIncludeInTOC:n {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \UWMad_Boolean_SetFalse:n {__ListOf#1-IncludeInTOC}
    }
}
\cs_new:Nn \UWMad_ListOf_IfIncludeInTOC:nTF {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \UWMad_Boolean_IfTrue:nTF {__ListOf#1-IncludeInTOC} {
            #2
        }{
            #3
        }
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitleMain:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_gset:cn {l__UWMad_ListOf#1_TitleMain_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitleGroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_gset:cn {l__UWMad_ListOf#1_TitleGroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetTitleSubgroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_gset:cn {l__UWMad_ListOf#1_TitleSubgroup_tl}{#2}
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
        \tl_gset:cn {l__UWMad_ListOf#1_SectionMain_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSectionGroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_gset:cn {l__UWMad_ListOf#1_SectionGroup_tl}{#2}
    }
}
\cs_new:Nn \UWMad_ListOf_SetSectionSubgroup:nn {
    \UWMad_ListOf_IfDefined:nT {#1} {
        \tl_gset:cn {l__UWMad_ListOf#1_SectionSubgroup_tl}{#2}
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
    \UWMad_Queue_Push:nn{__ListOf#1-EntryQueue}{#2}
}
\cs_new:Nn \UWMad_ListOf_SetHook:nnn {
    \UWMad_Hash_Set:nnn{__ListOf#1-Hook}{#2}{#3}
}
\cs_new:Nn \UWMad_ListOf_PrintEntries:n {
    \UWMad_Hash_Get:nn   {__ListOf#1-Hook}{PrePrint}
    \UWMad_Queue_Walk:nn {__ListOf#1-EntryQueue}{##1}
    \UWMad_Queue_Clear:n {__ListOf#1-EntryQueue}
    \UWMad_Hash_Get:nn   {__ListOf#1-Hook}{PostPrint}
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
\newcommand{\PushPDFMetaDataToList}[2]{
    \UWMad_CSV_Append:nn {MetaDataList}{#1={#2}}        % True:    Append the data
}

\file_if_exist:nTF{UWMad.PDFMetaData.aux} {
    \file_input:n {UWMad.PDFMetaData.aux}
}{
}

\AtEndDocument{
    \UWMad_CSV_IfNotEmpty:nTF {MetaDataList} {
        \iow_new:N   \g__UWMad_PDFMetaData_HyperSetup_io
        \iow_open:Nn \g__UWMad_PDFMetaData_HyperSetup_io {
            UWMad.PDFMetaData.aux
        }
        \iow_now:Nx  \g__UWMad_PDFMetaData_HyperSetup_io {
            \noexpand\ExplSyntaxOff
                \noexpand\hypersetup{\UWMad_CSV_Get:n{MetaDataList}}
            \noexpand\ExplSyntaxOn
        }
        \iow_close:N \g__UWMad_PDFMetaData_HyperSetup_io
    }
}

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
\newcommand{\Title}      [1] {\renewcommand{\TheTitle}      {#1\xspace}
    \PushPDFMetaDataToList{pdftitle}    {#1}}
\newcommand{\Author}     [1] {\renewcommand{\TheAuthor}     {#1\xspace}
    \PushPDFMetaDataToList{pdfauthor}   {#1}}
\newcommand{\Subject}    [1] {\renewcommand{\TheSubject}    {#1\xspace}
    \PushPDFMetaDataToList{pdfsubject}  {#1}}
\newcommand{\Producer}   [1] {\renewcommand{\TheProducer}   {#1\xspace}
    \PushPDFMetaDataToList{pdfproducer} {#1}}
\newcommand{\Creator}    [1] {\renewcommand{\TheCreator}    {#1\xspace}
    \PushPDFMetaDataToList{pdfcreator}  {#1}}
\newcommand{\Keywords}   [1] {\renewcommand{\TheKeywords}   {#1\xspace}
    \PushPDFMetaDataToList{pdfkeywords} {#1}}
\newcommand{\Subtitle}   [1] {\renewcommand{\TheSubtitle}   {#1\xspace}}
\newcommand{\Date}       [1] {\renewcommand{\TheDate}       {#1\xspace}}
\newcommand{\Department} [1] {\renewcommand{\TheDepartment} {#1\xspace}}
\newcommand{\Degree}     [1] {\renewcommand{\TheDegree}     {#1\xspace}}
\newcommand{\Specialty}  [1] {\renewcommand{\TheSpecialty}  {#1\xspace}}
\newcommand{\Advisor}    [1] {\renewcommand{\TheAdvisor}    {#1\xspace}}
\newcommand{\University} [1] {\renewcommand{\TheUniversity} {#1\xspace}}
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


\newcommand{\TheLicenseAuthor}{
    \IfCommandEmpty{\TheAuthor}
        {The Author}
        {\TheAuthor}}

\newcommand{\CopyrightTemplate}{
    \large
    \copyright{} Copyright by \TheLicenseAuthor(\the\year)\\
    All Rights Reserved
}

\newcommand{\MakeCopyright}{
    \LicensePage{CopyrightTemplate}
}

\newcommand{\CreativeCommonsPorting}{Unported\xspace}
\newcommand{\CreativeCommons}{}
\newcommand{\CreativeCommonsFrontOfURL}{http://creativecommons.org/licenses/}
\newcommand{\CreativeCommonsBackOfURL} {/3.0/}
\newcommand{\CreativeCommonsURL}[1]{
    \CreativeCommonsFrontOfURL#1\CreativeCommonsBackOfURL
}

\newif\ifUWMad@CCAttribution  \UWMad@CCAttributionfalse
\newif\ifUWMad@CCNonCommercial\UWMad@CCNonCommercialfalse
\newif\ifUWMad@CCShareAlike   \UWMad@CCShareAlikefalse
\newif\ifUWMad@CCNoDerivatives\UWMad@CCNoDerivativesfalse

\newcommand{\Attribution}   {\UWMad@CCAttributiontrue}
\newcommand{\NonCommercial} {\UWMad@CCNonCommercialtrue}
\newcommand{\ShareAlike}    {\UWMad@CCShareAliketrue}
\newcommand{\NoDerivatives} {\UWMad@CCNoDerivativestrue}

\newcommand{\CreativeCommonsModuleBuild}{
    \ifUWMad@CCAttribution
        \newcommand{\TheCreativeCommonsLink}{by}
        \newcommand{\TheCreativeCommonsWords}{Attribution}
    \fi

    \ifUWMad@CCNonCommercial
        \xdef\TheCreativeCommonsLink{\TheCreativeCommonsLink-nc}
        \xdef\TheCreativeCommonsWords{\TheCreativeCommonsWords-NonCommercial}
    \fi

    \ifUWMad@CCShareAlike
        \xdef\TheCreativeCommonsLink{\TheCreativeCommonsLink-sa}
        \xdef\TheCreativeCommonsWords{\TheCreativeCommonsWords-ShareAlike}
    \fi

    \ifUWMad@CCNoDerivatives
        \xdef\TheCreativeCommonsLink{\TheCreativeCommonsLink-nd}
        \xdef\TheCreativeCommonsWords{\TheCreativeCommonsWords-NoDerivs}
    \fi

}

\newcommand{\CreativeCommonsTemplate}{
    \large
    \TheLicenseAuthor has licensed this work under a \\
    \href{\CreativeCommonsURL{\TheCreativeCommonsLink}}
        {Creative Commons \TheCreativeCommonsWords\xspace 3.0
        \CreativeCommonsPorting License}\\
    \the\year
}

\newcommand{\MakeCreativeCommons}{
    \CreativeCommonsModuleBuild
    \LicensePage{CreativeCommonsTemplate}
}

\newcommand{\CreativeCommonsBY}{
    \Attribution
    \MakeCreativeCommons
}

\newcommand{\CreativeCommonsBYNC}{
    \Attribution\NonCommercial
    \MakeCreativeCommons
}

\newcommand{\CreativeCommonsBYNCSA}{
    \Attribution\NonCommercial\ShareAlike
    \MakeCreativeCommons
}

\newcommand{\CreativeCommonsBYSA}{
    \Attribution\ShareAlike
    \MakeCreativeCommons
}

\let\Copyright\CopyrightAllRightsReserved

\DeclareRobustCommand{\LicensePage}[1]{
    \thispagestyle{empty}                                   % No page number displayed
    \def\UWMad@RequestedLicense{#1}                         % Initialize the requested license command

    \ifthenelse{\equal{\UWMad@RequestedLicense}{copyright}} % If the user supplied 'copyright' as a License Request
        {\def\UWMad@RequestedLicense{Copyright}}            % it will be switched to 'Copyright' as \copyright IS
        {}                                                  % defined as the copyright symbol inherently.

    \null\vfill                                             % Fill the page with elastic whitespace
    \begin{center}
        \ifx \UWMad@RequestedLicense \UWMad@Undefined       % Checks if the license requested has a command
            \UWMad@RequestedLicense                         % If not, the input is echoed
        \else
            \csname\UWMad@RequestedLicense\endcsname        % If yes, the license command is excuted.
        \fi
    \end{center}
    \clearpage                                              % Clear the page
}
\ExplSyntaxOff
