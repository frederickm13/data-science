CREATE EXTERNAL TABLE dbo.TempMedicalData (
 [TreatmentNumber] nvarchar(20) NULL,
 [AnimalId] nvarchar(20) NULL,
 [ConditionType] nvarchar(100) NULL,
 [TreatmentDate] nvarchar(20) NULL,
 [TreatmentType] nvarchar(50) NULL,
 [TreatmentSubtype] nvarchar(20) NULL,
 [Weight] decimal NULL,
 [VisitNumber] nvarchar(20) NULL,
 [VisitType] nvarchar(50) NULL,
 [VisitReason] nvarchar(20) NULL
)
WITH (
 LOCATION='/',
 DATA_SOURCE=AnimalMedicalData,
 FILE_FORMAT=TextFile
);
CREATE TABLE [dbo].[AnimalMedicalData]
WITH (
 CLUSTERED COLUMNSTORE INDEX,
 DISTRIBUTION = ROUND_ROBIN
)
AS
SELECT *
FROM [dbo].[TempMedicalData];
DROP EXTERNAL TABLE [dbo].[TempMedicalData];

update AnimalMedicalData
set TreatmentSubtype = 'NEGATIVE'
where TreatmentSubtype like '%NEG%'
update AnimalMedicalData
set TreatmentSubtype = 'POSITIVE'
where TreatmentSubtype like '%POS%'
update AnimalMedicalData
set TreatmentSubtype = 'POSITIVE'
where TreatmentType like '%POS%'
update AnimalMedicalData
set TreatmentSubtype = 'NEGATIVE'
where TreatmentType like '%NEG%'
update AnimalMedicalData
set TreatmentType = 'HEARTWORM TEST'
where TreatmentType like '%HEARTWORM%'
update AnimalMedicalData
set TreatmentType = 'MICROCHIP'
where TreatmentType like '%MICROCHIP%' or TreatmentType like
'%MICRO CHIP%'
update AnimalMedicalData
set TreatmentSubtype = 'POSITIVE'
where TreatmentType = 'MICROCHIP' 