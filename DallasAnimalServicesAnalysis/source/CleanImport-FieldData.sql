CREATE EXTERNAL TABLE dbo.TempFieldData (
 [ActivityNumber] nvarchar(20) NULL,
 [ActivityType] nvarchar(50) NULL,
 [ActivitySubType] nvarchar(50) NULL,
 [ActivityPriority] nvarchar(20) NULL,
 [StreetAddress] nvarchar(100) NULL,
 [ZipCode] nvarchar(20) NULL,
 [AnimalIntakeId] nvarchar(20) NULL,
 [AnimalType] nvarchar(20) NULL,
 [CreatedOn] nvarchar(50) NULL
)
WITH (
 LOCATION='/',
 DATA_SOURCE=AnimalFieldData,
 FILE_FORMAT=TextFile
);
CREATE TABLE [dbo].[AnimalFieldData]
WITH (
 CLUSTERED COLUMNSTORE INDEX,
 DISTRIBUTION = ROUND_ROBIN
)
AS
SELECT *
FROM [dbo].[TempFieldData];
DROP EXTERNAL TABLE [dbo].[TempFieldData];

update AnimalFieldData 
set ActivityType
= 'LOOSE'
where ActivityType = 'ANILOOSE';
update AnimalFieldData
set ActivityType = 'OTHER'
where ActivityType = 'ANIOTHER';
update AnimalFieldData
set ActivitySubtype = 'NOISE'
where ActivityType = 'BARKING';
update AnimalFieldData
set ActivitySubtype = 'BITE'
where ActivityType = 'ANMLBITE'; 