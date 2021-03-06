function s:source(rpath)
    execute 'source '  g:root_dir.a:rpath[2:]
endfunction

let g:coc_global_extensions = [ 
            \'coc-json',
            \'coc-git',
            \'coc-tsserver',
            \'coc-html',
            \'coc-css',
            \'coc-tailwindcss',
            \'coc-vetur',
            \'coc-marketplace',
            \'coc-pairs',
            \'coc-snippets',
            \'coc-cssmodules',
            \'coc-vue',
            \'coc-tslint'
            \]
            " \'coc-eslint'
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

call s:source('../commond/cocConfig.vim')

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
