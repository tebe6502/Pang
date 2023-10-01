set macro=-i:macro\

mads.exe bonus.asm -l %macro%

mads.exe frm_right.asm -l %macro%
mads.exe frm_left.asm -l %macro%
mads.exe frm_updw.asm -l %macro%
mads.exe frm_death.asm -l %macro%

mads.exe harpuns.asm -l %macro%

mads.exe pang_chars.asm -l %macro% -t

pause

