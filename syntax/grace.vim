syntax keyword graceKeyword const print
syntax match graceDefine ":="
syntax match graceAssign "="
syntax match graceString /"\([^"]\|\\"\)*"/
syntax match graceNumber /\v\d+/
syntax match graceIdentifier /\<[a-zA-Z_][a-zA-Z0-9_]*\>/
syntax match graceComment "//.*$"

highlight link graceKeyword Keyword
highlight link graceDefine Operator
highlight link graceAssign Operator
highlight link graceString String
highlight link graceNumber Number
highlight link graceIdentifier Identifier
highlight link graceComment Comment
