CREATE EXTERNAL TABLE dbo.TempServiceRequests (
 [ServiceRequestNumber] nvarchar(20) NULL,
 [Address] nvarchar(100) NULL,
 [Department] nvarchar(50) NULL,
 [ServiceRequestType] nvarchar(100) NULL,
 [CreatedDate] nvarchar(50) NULL,
 [Priority] nvarchar(20) NULL 
 )
WITH (
 LOCATION='/',
 DATA_SOURCE=ServiceRequests,
 FILE_FORMAT=TextFile
);
CREATE TABLE [dbo].[ServiceRequests]
WITH (
 CLUSTERED COLUMNSTORE INDEX,
 DISTRIBUTION = ROUND_ROBIN
)
AS
SELECT *
FROM [dbo].[TempServiceRequests];
DROP EXTERNAL TABLE [dbo].[TempServiceRequests];

update ServiceRequests
set ServiceRequestType = 'Animal - Bite'
where Department = 'Dallas Animal Services' and
    ServiceRequestType like '%Bite%'
update ServiceRequests
set ServiceRequestType = 'Animal - Aggressive'
where Department = 'Dallas Animal Services' and
    ServiceRequestType like '%Aggressive%'
update ServiceRequests
set ServiceRequestType = 'Animal - Attack'
where Department = 'Dallas Animal Services' and
    ServiceRequestType like '%Attack%' 