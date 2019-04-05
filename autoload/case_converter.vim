" ==================================================================
" Description:  Converts selected words case.
"               Extracted from https://github.com/tpope/vim-abolish
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/vim-case-converter
" Version:      0.0.1
" ==================================================================

let s:converters = {
  \ 'snake_case': 's:snakecase(v:val)',
  \ 'dash_case':  's:dashcase(v:val)',
  \ 'space_case': 's:spacecase(v:val)',
  \ 'dot_case':   's:dotcase(v:val)',
  \ 'upper_case': 's:uppercase(v:val)',
  \ 'camel_case': 's:camelcase(v:val)',
  \ 'mixed_case': 's:mixedcase(v:val)'
  \ }

func! case_converter#convert(converter, has_selection) abort
  let l:converter = get(s:converters, a:converter, '')
  if !len(l:converter)
    return
  endif

  let l:selection = s:selection(a:has_selection)
  let l:converted_text = s:converted_text(l:converter, l:selection)

  call s:replace_text(l:converted_text, a:has_selection)
endfunc

func! s:selection(has_selection) abort
  let l:input = expand('<cword>')

  if a:has_selection >= 1
    try
      let l:previous_register_value = @z
      normal! gv"zy
      let l:input = @z
    finally
      let @z = l:previous_register_value
    endtry
  endif

  return l:input
endfunc

func! s:converted_text(converter, text) abort
  let l:lines = split(a:text, '\n')
  let l:converted_lines = case_converter#abolish#proxy(a:converter, l:lines)

  return join(l:converted_lines, "\n")
endfunc

func! s:replace_text(text, has_selection) abort
  try
    let l:previous_register_value = @z
    let @z = a:text

    if a:has_selection >= 1
      normal! gv"zp
    else
      let l:cursor_position = getpos('.')
      normal! bve"zp
      call setpos('.', l:cursor_position)
    endif
  finally
    let @z = l:previous_register_value
  endtry
endfunc
