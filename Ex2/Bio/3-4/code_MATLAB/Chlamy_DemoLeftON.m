function Chlamy_DemoLeftON

Folder_name='output_DemoLeftON'
Chlamy_LoadData(Folder_name)
Chlamy_Tracking(Folder_name,[950,1050;650,750;301,360],20,20,5,[Folder_name,'_short'])
Chlamy_Tracking(Folder_name,[800,1200;50,1000;301,360],20,20,5,[Folder_name,'_wide'])
Chlamy_Velocity([Folder_name,'_wide'])

return