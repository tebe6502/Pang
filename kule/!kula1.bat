mic\g2fext mic\kula_0.g2f -m
mic\g2fext mic\kula_1.g2f -m
mic\g2fext mic\kula_2.g2f -m
mic\g2fext mic\kula_3.g2f -m

mads kula1.asm -d:k=0 -d:clear=0 -o:kula1_0.obx
mads kula1.asm -d:k=1 -d:clear=0 -o:kula1_1.obx
mads kula1.asm -d:k=2 -d:clear=0 -o:kula1_2.obx
mads kula1.asm -d:k=3 -d:clear=0 -o:kula1_3.obx

mads kula1.asm -d:k=0 -d:clear=1 -o:kula1_0_clr.obx
mads kula1.asm -d:k=1 -d:clear=1 -o:kula1_1_clr.obx
mads kula1.asm -d:k=2 -d:clear=1 -o:kula1_2_clr.obx
mads kula1.asm -d:k=3 -d:clear=1 -o:kula1_3_clr.obx

del *.$$$

pause

