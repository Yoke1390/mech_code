function Chlamy_DemoRightON

Folder_name='output_DemoRightON'
FILE_name=[Folder_name,'.mat'];
Chlamy_LoadData(Folder_name)
Chlamy_Tracking(FILE_name,[800,1000;50,180;301,360],20,20,5,[Folder_name,'_short'])
Chlamy_Tracking(FILE_name,[800,1200;50,1000;301,360],20,20,5,[Folder_name,'_wide'])
Chlamy_Velocity([Folder_name,'_wide'])

return