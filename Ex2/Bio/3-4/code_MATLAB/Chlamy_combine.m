function Chlamy_combine(FILEname1,FILEname2,SAVEname)
data1=load(FILEname1);
data2=load(FILEname2);

chlamy_ext=cat(2,data1.chlamy_ext,data2.chlamy_ext);
save(SAVEname,"chlamy_ext");