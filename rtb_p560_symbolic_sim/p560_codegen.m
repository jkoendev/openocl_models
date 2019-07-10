mdl_puma560

cg = CodeGenerator(p560);
cg.genslblock = false;
cg.genccode = false;
cg.genmex = false;
cg.genfdyn();
cg.genfkine();