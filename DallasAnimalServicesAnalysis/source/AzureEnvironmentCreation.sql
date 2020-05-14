CREATE MASTER KEY;
CREATE DATABASE SCOPED
CREDENTIAL AzureStorageCredential
WITH
 IDENTITY = 'dallasanimals',
 SECRET = '<AccessKeyHere>'
;
CREATE EXTERNAL DATA SOURCE AnimalShelterData
WITH (
 TYPE = HADOOP,
 LOCATION = '<ContainerLocationHere>',
 CREDENTIAL = AzureStorageCredential
);
CREATE EXTERNAL DATA SOURCE AnimalFieldData
WITH (
 TYPE = HADOOP,
 LOCATION = '<ContainerLocationHere>',
 CREDENTIAL = AzureStorageCredential
);
CREATE EXTERNAL DATA SOURCE AnimalMedicalData
WITH (
 TYPE = HADOOP,
 LOCATION = '<ContainerLocationHere>',
 CREDENTIAL = AzureStorageCredential
);
CREATE EXTERNAL DATA SOURCE ServiceRequests
WITH (
 TYPE = HADOOP,
 LOCATION = '<ContainerLocationHere>',
 CREDENTIAL = AzureStorageCredential
);