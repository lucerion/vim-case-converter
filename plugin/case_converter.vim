" ==================================================================
" Description:  Converts selected words case.
"               Extracted from https://github.com/tpope/vim-abolish
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-case-converter
" Version:      0.0.1
" ==================================================================

if exists('g:loaded_case_converter') || &compatible || v:version < 700
  finish
endif
let g:loaded_case_converter = 1

comm! -range ToSnakeCase call case_converter#convert('snake_case', <count>)
comm! -range ToDashCase  call case_converter#convert('dash_case',  <count>)
comm! -range ToSpaceCase call case_converter#convert('space_case', <count>)
comm! -range ToDotCase   call case_converter#convert('dot_case',   <count>)
comm! -range ToUpperCase call case_converter#convert('upper_case', <count>)
comm! -range ToCamelCase call case_converter#convert('camel_case', <count>)
comm! -range ToMixedCase call case_converter#convert('mixed_case', <count>)
