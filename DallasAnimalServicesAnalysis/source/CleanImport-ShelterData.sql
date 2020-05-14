CREATE EXTERNAL TABLE dbo.TempAnimalShelter (
 [AnimalId] nvarchar(20) NULL,
 [AnimalType] nvarchar(20) NULL,
 [AnimalBreed] nvarchar(50) NULL,
 [KennelStatus] nvarchar(50) NULL,
 [IntakeType] nvarchar(50) NULL,
 [IntakeSubtype] nvarchar(50) NULL,
 [Reason] nvarchar(50) NULL,
 [IntakeDate] nvarchar(50) NULL,
 [IntakeCondition] nvarchar(100) NULL,
 [HoldRequest] nvarchar(50) NULL,
 [OutcomeType] nvarchar(50) NULL,
 [OutcomeSubtype] nvarchar(50) NULL,
 [OutcomeDate] nvarchar(50) NULL,
 [OutcomeCondition] nvarchar(100) NULL,
 [ChipStatus] nvarchar(50) NULL,
 [AnimalOrigin] nvarchar(50) NULL
)
WITH (
 LOCATION='/',
 DATA_SOURCE=AnimalShelterData,
 FILE_FORMAT=TextFile
);
CREATE TABLE [dbo].[AnimalShelter]
WITH (
 CLUSTERED COLUMNSTORE INDEX,
 DISTRIBUTION = ROUND_ROBIN
)
AS
SELECT *
FROM [dbo].[TempAnimalShelter];
DROP EXTERNAL TABLE [dbo].[TempAnimalShelter];

update AnimalShelterData
set AnimalBreed = 'PIT BULL'
where AnimalBreed = 'PITBULL'