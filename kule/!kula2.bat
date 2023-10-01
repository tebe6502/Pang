mic\g2fext mic\kula_0.g2f -m
mic\g2fext mic\kula_1.g2f -m
mic\g2fext mic\kula_2.g2f -m
mic\g2fext mic\kula_3.g2f -m

mads kula2.asm -d:k=0 -d:clear=0 -o:kula2_0.obx
mads kula2.asm -d:k=1 -d:clear=0 -o:kula2_1.obx
mads kula2.asm -d:k=2 -d:clear=0 -o:kula2_2.obx
mads kula2.asm -d:k=3 -d:clear=0 -o:kula2_3.obx

mads kula2.asm -d:k=0 -d:clear=1 -o:kula2_0_clr.obx
mads kula2.asm -d:k=1 -d:clear=1 -o:kula2_1_clr.obx
mads kula2.asm -d:k=2 -d:clear=1 -o:kula2_2_clr.obx
mads kula2.asm -d:k=3 -d:clear=1 -o:kula2_3_clr.obx

del *.$$$

pause

