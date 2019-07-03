CREATE DATABASE solutions;
GO

USE DATABASE solutions;
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Problem](
	[ProblemID] [int] IDENTITY(1,1) NOT NULL,
	[ProblemName] [nvarchar](150) NULL,
	[ProblemDescription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProblemID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solution](
	[SolutionID] [int] IDENTITY(1,1) NOT NULL,
	[SolutionName] [nvarchar](150) NULL,
	[SolutionDescription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SolutionID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolutionReferences](
	[SolutionReferenceID] [int] IDENTITY(1,1) NOT NULL,
	[SolutionReferenceType] [nvarchar](100) NULL,
	[SolutionReferenceName] [nvarchar](150) NULL,
	[SolutionReferenceDescription] [nvarchar](max) NULL,
	[SolutionID] [int] NULL,
	[SolutionReferencesLocation] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SolutionReferenceID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProblemToSolution](
	[ProblemToSolutionID] [int] IDENTITY(1,1) NOT NULL,
	[ProblemID] [int] NULL,
	[SolutionID] [int] NULL,
	[Strength] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProblemToSolutionID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProblemsToSolutions]
AS
SELECT     dbo.Problem.ProblemName, dbo.Problem.ProblemDescription, dbo.Solution.SolutionName, dbo.Solution.SolutionDescription, dbo.ProblemToSolution.Strength, 
                  dbo.SolutionReferences.SolutionReferenceType, dbo.SolutionReferences.SolutionReferenceName, dbo.SolutionReferences.SolutionReferenceDescription, 
                  dbo.SolutionReferences.SolutionReferencesLocation
FROM        dbo.Problem INNER JOIN
                  dbo.ProblemToSolution ON dbo.Problem.ProblemID = dbo.ProblemToSolution.ProblemID INNER JOIN
                  dbo.Solution ON dbo.ProblemToSolution.SolutionID = dbo.Solution.SolutionID LEFT OUTER JOIN
                  dbo.SolutionReferences ON dbo.Solution.SolutionID = dbo.SolutionReferences.SolutionID
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AzureService](
	[AzureServiceID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](150) NULL,
	[ServiceDescription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AzureServiceID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceReferences](
	[ServiceReferenceID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceReferenceName] [nvarchar](150) NULL,
	[ServiceReferenceType] [nvarchar](50) NULL,
	[ServiceReferenceLocation] [nvarchar](150) NULL,
	[ServiceReferenceDescription] [nvarchar](max) NULL,
	[AzureServiceID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceReferenceID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolutionToService](
	[SolutionToServiceID] [int] IDENTITY(1,1) NOT NULL,
	[SolutionID] [int] NULL,
	[AzureServiceID] [int] NULL,
	[Complexity] [nvarchar](50) NULL,
	[MonthlyEstimatedCost] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SolutionToServiceID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SolutionsToServices]
AS
SELECT     dbo.Solution.SolutionName, dbo.AzureService.ServiceName, dbo.AzureService.ServiceDescription, dbo.ServiceReferences.ServiceReferenceName, dbo.ServiceReferences.ServiceReferenceType, 
                  dbo.ServiceReferences.ServiceReferenceLocation
FROM        dbo.Solution INNER JOIN
                  dbo.SolutionToService ON dbo.Solution.SolutionID = dbo.SolutionToService.SolutionID INNER JOIN
                  dbo.AzureService ON dbo.SolutionToService.AzureServiceID = dbo.AzureService.AzureServiceID LEFT OUTER JOIN
                  dbo.ServiceReferences ON dbo.AzureService.AzureServiceID = dbo.ServiceReferences.AzureServiceID
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AzureService] ON 

INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (1, N'Virtual Machines', N'Windows or Linux Virtual Machine')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (2, N'Azure Blob Storage', N'Cloud-based Storage')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (3, N'Azure Kubernetes Service', N'Kubernetes clusters as a service')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (4, N'Azure Key Vault', N'Secure offsite location for privacy and authentication keys')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (5, N'Azure Active Directory', N'ADLS')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (6, N'IoT Hub', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (7, N'IoT Edge', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (8, N'IoT Central', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (9, N'Azure Sphere', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (10, N'Cognitive Services', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (11, N'Azure Bot Service', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (12, N'Azure SQL Data Warehouse', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (13, N'Azure Data Factory', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (14, N'Event Hubs', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (15, N'Azure SSAS', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (16, N'Azure Data Catalog', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (17, N'Azure Stream Analytics', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (18, N'HDInsight', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (19, N'Azure Data Lake Storage', N'HDFS Tiering')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (20, N'Power BI', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (21, N'Azure Blockchain', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (22, N'Azure Logic Apps', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (23, N'Azure Cosmos DB', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (24, N'Service Fabric', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (25, N'SAP HANA', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (26, N'Virtual Machine Scale Sets', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (27, N'Azure Mobile Apps', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (28, N'VMWare', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (29, N'Azure App Service', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (30, N'Azure Container Registry', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (31, N'Azure Red Hat OpenShift', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (32, N'SQL Server Stretch Database', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (33, N'Azure SQL Database Edge', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (34, N'Azure SQL Database', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (35, N'Azure DevOps', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (36, N'Azure Pipelines', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (37, N'Azure Active Directory Domain Services', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (38, N'Azure Service Bus', N'A fully managed enterprise integration message broker. Service Bus is most commonly used to decouple applications and services from each other, and is a reliable and secure platform for asynchronous data and state transfer.')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (39, N'Azure Backup', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (40, N'Azure Site Recovery', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (41, N'Azure Stack', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (42, N'Azure Data Migration Service', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (43, N'Azure Data Box', N'Storage appliance with caching, Hierarchical Storage Management, and security')
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (44, N'Azure VPN', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (45, N'Azure NetApp Files', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (46, N'Azure SQL Data Sync', NULL)
INSERT [dbo].[AzureService] ([AzureServiceID], [ServiceName], [ServiceDescription]) VALUES (47, N'Azure DevTest Labs', NULL)
SET IDENTITY_INSERT [dbo].[AzureService] OFF
SET IDENTITY_INSERT [dbo].[Problem] ON 

INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (1, N'Copy Data Automatically', N'We want to copy certain data elements to an external location for use by others, securely.')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (2, N'Database Backups', N'We want to store our database backups in another location with full redundancy.')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (3, N'Offiste High Availability', N'We want additional safety on our data systems, with the ability to use them globally or as a secondary read service.')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (4, N'SQL Server 2008 EOS', N'SQL Server 2008 has reached end of service, and we don''t want to pay for extended support. We do have applications that required SQL Server 2008 as the back-end.')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (5, N'Lift and Shift', N'We have a SQL Server installation on premises and we want to duplicate or move it to Azure')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (6, N'Big Data Analytics', N'We have a lot of data that we need to analyze in a single environment. We''d also like to use Spark.')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (7, N'Data Hub', N'We have Oracle, Terradata, HDFS and other data sources we want to query using one system, without having to install and manage lots of connectors or learn to use multiple query languages. ')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (8, N'Performance Improvements', N'We have the need to improve our current performance, but we can''t always alter the code.')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (9, N'Security Improvements', N'We need to be able to use secure security enclaves, and have encryption end-to-end within the server without decoding at the client. ')
INSERT [dbo].[Problem] ([ProblemID], [ProblemName], [ProblemDescription]) VALUES (10, N'SOA Architecture', N'We want to create a Service Oriented Architecture and use our SQL Server Data.')
SET IDENTITY_INSERT [dbo].[Problem] OFF
SET IDENTITY_INSERT [dbo].[ProblemToSolution] ON 

INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (1, 1, 1, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (2, 2, 1, N'Low')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (3, 2, 2, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (4, 2, 6, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (5, 3, 4, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (6, 4, 9, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (7, 5, 3, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (8, 6, 5, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (9, 7, 8, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (10, 7, 5, N'Medium')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (11, 8, 8, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (12, 9, 8, N'High')
INSERT [dbo].[ProblemToSolution] ([ProblemToSolutionID], [ProblemID], [SolutionID], [Strength]) VALUES (13, 10, 10, N'High')
SET IDENTITY_INSERT [dbo].[ProblemToSolution] OFF
SET IDENTITY_INSERT [dbo].[ServiceReferences] ON 

INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (1, N'Windows Virtual Machines Documentation', N'Official Documentation', N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/', N'Official Documentation for Windows Virtual Machines', 1)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (2, N'Linux Virtual Machines Documentation', N'Official Documentation', N'https://docs.microsoft.com/en-us/azure/virtual-machines/linux/', N'Official Documentation for Linux Virtual Machines', 1)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (3, N'SQL Server Replication to Azure', N'Official Documentation', N'https://docs.microsoft.com/en-us/sql/relational-databases/replication/sql-server-replication?view=sql-server-2017', N'Official Documentation for SQL Server Replication', 1)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (4, N'Introduction to Azure managed disks', N'Concepts', N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/managed-disks-overview', N'Official Documentation', 2)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (5, N'N/A', NULL, NULL, NULL, 3)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (6, NULL, NULL, NULL, NULL, 4)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (7, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (8, NULL, NULL, NULL, NULL, 6)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (9, NULL, NULL, NULL, NULL, 7)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (10, NULL, NULL, NULL, NULL, 8)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (11, NULL, NULL, NULL, NULL, 9)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (12, NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (13, NULL, NULL, NULL, NULL, 11)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (14, NULL, NULL, NULL, NULL, 12)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (15, NULL, NULL, NULL, NULL, 13)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (16, NULL, NULL, NULL, NULL, 14)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (17, NULL, NULL, NULL, NULL, 15)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (18, NULL, NULL, NULL, NULL, 16)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (19, NULL, NULL, NULL, NULL, 17)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (20, NULL, NULL, NULL, NULL, 18)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (21, NULL, NULL, NULL, NULL, 19)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (22, NULL, NULL, NULL, NULL, 20)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (23, NULL, NULL, NULL, NULL, 21)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (24, NULL, NULL, NULL, NULL, 22)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (25, NULL, NULL, NULL, NULL, 23)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (26, NULL, NULL, NULL, NULL, 24)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (27, NULL, NULL, NULL, NULL, 25)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (28, NULL, NULL, NULL, NULL, 26)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (29, NULL, NULL, NULL, NULL, 27)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (30, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (31, NULL, NULL, NULL, NULL, 28)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (32, NULL, NULL, NULL, NULL, 30)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (33, NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (34, NULL, NULL, NULL, NULL, 31)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (35, NULL, NULL, NULL, NULL, 32)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (36, NULL, NULL, NULL, NULL, 33)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (37, NULL, NULL, NULL, NULL, 34)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (38, NULL, NULL, NULL, NULL, 35)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (39, NULL, NULL, NULL, NULL, 36)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (40, NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (41, N'Azure Service Bus Messaging Documentation', N'Official Documentation', N'https://docs.microsoft.com/en-us/azure/service-bus-messaging/', N'Learn how to use Azure Service Bus messaging services to send and receive messages to and from queues, and publish and subscribe for messages using topics and subscriptions.', 38)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (42, NULL, NULL, NULL, NULL, 39)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (43, NULL, NULL, NULL, NULL, 40)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (44, NULL, NULL, NULL, NULL, 41)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (45, NULL, NULL, NULL, NULL, 42)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (46, NULL, NULL, NULL, NULL, 43)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (47, NULL, NULL, NULL, NULL, 44)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (48, NULL, NULL, NULL, NULL, 45)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (49, NULL, NULL, NULL, NULL, 46)
INSERT [dbo].[ServiceReferences] ([ServiceReferenceID], [ServiceReferenceName], [ServiceReferenceType], [ServiceReferenceLocation], [ServiceReferenceDescription], [AzureServiceID]) VALUES (50, NULL, NULL, NULL, NULL, 47)
SET IDENTITY_INSERT [dbo].[ServiceReferences] OFF
SET IDENTITY_INSERT [dbo].[Solution] ON 

INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (1, N'SQL Replication to Azure VM', N'Use SQL Server Replication to copy data to an Azure Virtual Machine.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (2, N'Backup to Azure', N'Backup using standard T-SQL statements to Azure Storage. Has the ability to be triple-redundancy, and have global copies, or keep in a single Region. Or Backup using Azure Backup.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (3, N'Azure Site Recovery', NULL)
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (4, N'Availability Group Replica', N'Synchronize data between SQL on Windows to Azure Managed Instance  through a vnet. Allows clusterless async replica between Linux and Azure MI.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (5, N'SQL Server 2019 Big Data Clusters', N'Allows large-scale MPP data and Spark processing.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (6, N'Storage appliance', N'A full Hiearchical Storage Management (HMS) solution. Provides multiple automatic benefits.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (7, N'Copy data using a gateway', N'The Azure Data Factory has the ability to establish a gateway with SQL Server and move data to any number of "sinks", or destinations.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (8, N'SQL Server 2019', N'SQL Server 2019 has the ability to run on Windows, linux, in Containers and Kubernetes, and can act as a Data Hub using PolyBase. It also contains numerous security and performance enhancements, some with no code-change.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (9, N'SQL Server Virtual Machines', N'SQL Server VM''s are a full Instance of SQL Server running in Azure. You can bring your own license or rent one, and there are multiple sizes.')
INSERT [dbo].[Solution] ([SolutionID], [SolutionName], [SolutionDescription]) VALUES (10, N'Azure Service Bus', N'Use the SQL Server Service Broker, along with the Azure Service Bus to create a full re-active messaging system')
SET IDENTITY_INSERT [dbo].[Solution] OFF
SET IDENTITY_INSERT [dbo].[SolutionReferences] ON 

INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (1, N'Tutorial', N'Using a VPN with Replication', N'', 1, N'https://docs.microsoft.com/en-us/sql/relational-databases/replication/publish-data-over-the-internet-using-vpn?view=sql-server-2017')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (5, N'Official Documentation', N'SQL Server Backup and Restore with Microsoft Azure Blob Storage Service', N'', 2, N'https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-microsoft-azure-blob-storage-service?view=sql-server-2017')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (6, N'Official Documentation', N'Site Recovery General Information', N'', 3, N'https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-overview')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (7, N'Tutorials and Guidelines', N'SQL Server Always On availability groups on Azure virtual machines', N'', 4, N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-availability-group-overview')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (8, N'Official Documentation', N'Using Azure AKS for SQL Server 2019 BDC', N'', 5, N'https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-on-aks?view=sqlallproducts-allversions')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (9, N'Official Documentation', N'Azure Data Box Overview', N'', 6, N'https://docs.microsoft.com/en-us/azure/databox/data-box-overview')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (10, N'Tutorial', N'Copy data to and from SQL Server using Azure Data Factory', N'', 7, N'https://docs.microsoft.com/en-us/azure/data-factory/connector-sql-server')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (11, N'Overview', N'What''s new in SQL Server 2019', N'', 8, N'https://docs.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-ver15?view=sqlallproducts-allversions')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (12, N'Qucikstart', N'Create a SQL Server 2017 Windows virtual machine in the Azure portal', N'', 9, N'https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/quickstart-sql-vm-create-portal')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (13, N'Workshop', N'SQL Server 2019 big data clusters workshop', N'', 5, N'https://aka.ms/sqlworkshops')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (14, N'Cost Estimate', N'Cost Estimate', N'Shows a general cost estimate of a basic version of this solution; can be customized', 6, N'https://azure.com/e/dfed0eefb9774aa681478cf2061d4f27')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (15, N'Concepts', N'When to use Service Broker in SQL Server', NULL, 10, N'https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-service-broker?view=sql-server-2017')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (16, N'Whitepaper', N'Designing a Modern Service Architecture for the Cloud', N'Whitepaper of various options for A SOA', 10, N'https://www.microsoft.com/en-us/itshowcase/designing-a-modern-service-architecture-for-the-cloud')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (17, N'Whitepaper', N'Service Oriented Database Architecture', N'Older whitepaper on using Service Broker, but concepts and code are still valid.', 10, N'https://www.microsoft.com/en-us/research/wp-content/uploads/2005/09/tr-2005-129.pdf ')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (18, N'Blog', N'Data Integration Design Patterns With Microservices', N'SOA is related to Microservices in many ways - this official blog entry shows more detail on that design.', 10, N'https://blogs.technet.microsoft.com/cansql/2016/12/05/data-integration-design-patterns-with-microservices/')
INSERT [dbo].[SolutionReferences] ([SolutionReferenceID], [SolutionReferenceType], [SolutionReferenceName], [SolutionReferenceDescription], [SolutionID], [SolutionReferencesLocation]) VALUES (19, N'Official Documentation', N'Choose between Azure messaging services - Event Grid, Event Hubs, and Service Bus', N'This article describes the differences between these services, and helps you understand which one to choose for your application. In many cases, the messaging services are complementary and can be used together.', 10, N'https://docs.microsoft.com/en-us/azure/event-grid/compare-messaging-services?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fservice-bus-messaging%2FTOC.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json')
SET IDENTITY_INSERT [dbo].[SolutionReferences] OFF
SET IDENTITY_INSERT [dbo].[SolutionToService] ON 

INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (1, 1, 1, N'Low', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (2, 1, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (3, 2, 2, N'Low', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (4, 2, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (5, 3, 40, N'Medium', N'Medium')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (6, 3, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (7, 4, 1, N'Low', N'Medium')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (8, 4, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (9, 5, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (10, 5, 2, N'Low', N'Medium')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (11, 5, 3, N'Medium', N'High')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (12, 5, 5, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (13, 5, 19, N'Low', N'Medium')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (14, 6, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (15, 6, 43, N'Low', N'High')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (16, 6, 2, N'Low', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (17, 7, 13, N'Medium', N'Medium')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (18, 8, 1, N'Low', N'Medium')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (19, 8, 5, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (20, 8, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (21, 9, 44, N'Medium', N'Low')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (22, 9, 1, N'Medium', N'High')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (23, 9, 2, N'Low', N'Medium')
INSERT [dbo].[SolutionToService] ([SolutionToServiceID], [SolutionID], [AzureServiceID], [Complexity], [MonthlyEstimatedCost]) VALUES (24, 10, 38, N'High', N'Low')
SET IDENTITY_INSERT [dbo].[SolutionToService] OFF
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Complete', 1, 2, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF13000000FEFFFFFF0400000005000000060000001E00000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000FEFFFFFFFEFFFFFF15000000160000001700000018000000190000001A0000001B0000001C0000001D000000FEFFFFFF1F00000020000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF02000000000000000000000000000000000000000000000000000000000000005081D151532CD50103000000000D0000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000062070000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000007000000AA17000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001E0000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D000000FEFFFFFF1F000000FEFFFFFFFEFFFFFF22000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F000000300000003100000032000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000430000A1E100C05000080130000000F00FFFF13000000007D000049D400006681000091EC00006A910000AAE9FFFFF4F9FFFFDE805B10F195D011B0A000AA00BDCB5C000008003000000000020000030000003C006B0000000900000000000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D000028004300000000000000DF3B5B7481CF3A489F92A54640AA2AFF34C9D2777977D811907000065B840D9C000028004300000000000000647BC4D854EB7541B7F775E3E6952F1134C9D2777977D811907000065B840D9C13000000700600000093010000003C00A50900000700008001000000AA02000000800000120000805363684772696400C486000046050000417A75726553657276696365202864626F29000000003800A50900000700008002000000A0020000008000000D00008053636847726964C074F5FFFFC201000050726F626C656D202864626F290E000000004000A50900000700008003000000B4020000008000001700008053636847726964C074F5FFFF0618000050726F626C656D546F536F6C7574696F6E202864626F292800009000A50900000700008004000000620000000180000067000080436F6E74726F6CC01EF0FFFF3307000052656C6174696F6E736869702027464B5F50726F626C656D546F536F6C7574696F6E5F50726F626C656D202864626F2927206265747765656E202750726F626C656D202864626F292720616E64202750726F626C656D546F536F6C7574696F6E202864626F29273F00002800B50100000700008005000000310000006B00000002800000436F6E74726F6C00B5DFFFFF0215000000004000A50900000700008006000000B402000000800000170000805363684772696400DA61000026340000536572766963655265666572656E636573202864626F294100009C00A50900000700008007000000620000000180000071000080436F6E74726F6C00D08C0000210A000052656C6174696F6E736869702027464B5F536572766963655265666572656E6365735F417A75726553657276696365202864626F2927206265747765656E2027417A75726553657276696365202864626F292720616E642027536572766963655265666572656E636573202864626F292700000000002800B50100000700008008000000310000007500000002800000436F6E74726F6C00D49F00001B3B000000003800A50900000700008009000000A2020000008000000E00008053636847726964006E280000EE020000536F6C7574696F6E202864626F29000000009400A5090000070000800A000000620000000180000069000080436F6E74726F6C009F1D00003307000052656C6174696F6E736869702027464B5F50726F626C656D546F536F6C7574696F6E5F536F6C7574696F6E202864626F2927206265747765656E2027536F6C7574696F6E202864626F292720616E64202750726F626C656D546F536F6C7574696F6E202864626F292700000000002800B5010000070000800B000000310000006D00000002800000436F6E74726F6C0008120000D314000000004000A5090000070000800C000000B602000000800000180000805363684772696400302A000090330000536F6C7574696F6E5265666572656E636573202864626F2900009400A5090000070000800D00000062000000018000006C000080436F6E74726F6C00F1230000F508000052656C6174696F6E736869702027464B5F536F6C7574696F6E5265666572656E6365735F536F6C7574696F6E31202864626F2927206265747765656E2027536F6C7574696F6E202864626F292720616E642027536F6C7574696F6E5265666572656E636573202864626F292700002800B5010000070000800E000000310000007100000002800000436F6E74726F6C004B120000AD28000000004000A5090000070000800F000000B402000000800000170000805363684772696400E457000006180000536F6C7574696F6E546F53657276696365202864626F290000009400A50900000700008010000000620000000180000069000080436F6E74726F6C0038510000C907000052656C6174696F6E736869702027464B5F536F6C7574696F6E546F536572766963655F536F6C7574696F6E202864626F2927206265747765656E2027536F6C7574696F6E202864626F292720616E642027536F6C7574696F6E546F53657276696365202864626F292700000000002800B50100000700008011000000310000006D00000002800000436F6E74726F6C00925500009A13000000009C00A50900000700008012000000620000000180000071000080436F6E74726F6C0032810000B70A000052656C6174696F6E736869702027464B5F536F6C7574696F6E546F536572766963655F417A75726553657276696365202864626F2927206265747765656E2027417A75726553657276696365202864626F292720616E642027536F6C7574696F6E546F53657276696365202864626F292700000000002800B50100000700008013000000310000007500000002800000436F6E74726F6C003A850000901B00000000000000000000000000000000000000000000000000000000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B2710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002143341208000000C92A00002811000078563412070000001401000041007A00750072006500530065007200760069006300650020002800640062006F00290000000000040000000C00000000000000000000000A0000000300000003000000040000000800000000000000000000000A0000000400000003000000040000000400000000000000000000000A00000000000000000000000100000004000000000000000A0000001E00000000000000000000000700000004000000000000000A0000002100000001000000000000000300000004000000000000000A0000002400000002000000030000000500000010000000000000000A0000006C00000003000000030000000500000000000000000000000000000005000000540000002C0000002C0000002C000000340000000000000000000000C92A000028110000000000002D010000070000000C000000070000001C010000E40C00008C0A0000B0040000DC0500001A04000008070000CA08000046050000CA080000220B00009E07000000000000010000005B1D00000F0E000000000000030000000300000002000000020000001C010000D30E000000000000010000000C1A00008306000000000000010000000100000002000000020000001C010000E40C000001000000000000000C1A00009E03000000000000000000000000000002000000020000001C010000E40C00000000000000000000A9450000222C000000000000000000000D00000004000000040000001C010000E40C00003C0F00006009000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D00000041007A00750072006500530065007200760069006300650000002143341208000000DC290000BE100000785634120700000014010000500072006F0062006C0065006D0020002800640062006F002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000003B000000000000000000000000000000000000003C01000000000000000000000000000090D18B06000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C000000340000000000000000000000DC290000BE100000000000002D010000070000000C000000070000001C010000E40C00008C0A0000B0040000DC0500001A04000008070000CA08000046050000CA080000220B00009E07000000000000010000005B1D00000F0E000000000000030000000300000002000000020000001C010000D30E000000000000010000000C1A00008306000000000000010000000100000002000000020000001C010000E40C000001000000000000000C1A00009E03000000000000000000000000000002000000020000001C010000E40C00000000000000000000A9450000222C000000000000000000000D00000004000000040000001C010000E40C00003C0F00006009000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000008000000500072006F0062006C0065006D000000214334120800000057290000BE130000785634120700000014010000500072006F0062006C0065006D0054006F0053006F006C007500740069006F006E0020002800640062006F0029000000000000008100000085000000030000000000000000000000E0FFFFFF000000008C00000093000000010000000300000005000000E0FFFFFF00000000A1000000BF000000010000000300000005000000E0FFFFFF0000000047000000BF000000080000000300000005000000D4FFFFFF000000004C0000002E010000070000000300000005000000D8FFFFFF00000000520000002E010000060000000300000005000000DCFFFFFF000000000F0000006101000000000000030000000500000000000000000000000000000005000000540000002C0000002C0000002C00000034000000000000000000000057290000BE130000000000002D010000070000000C000000070000001C010000E40C00008C0A0000B0040000DC0500001A04000008070000CA08000046050000CA080000220B00009E07000000000000010000005B1D00000E11000000000000040000000400000002000000020000001C010000D30E000000000000010000000C1A00004D0C000000000000030000000300000002000000020000001C010000E40C000001000000000000000C1A00009E03000000000000000000000000000002000000020000001C010000E40C00000000000000000000A9450000222C000000000000000000000D00000004000000040000001C010000E40C00003C0F00006009000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000012000000500072006F0062006C0065006D0054006F0053006F006C007500740069006F006E00000004000B0074F5FFFFCA0800004AF1FFFFCA0800004AF1FFFF9222000074F5FFFF922200000000000002000000F0F0F00000000000000000000000000000000000010000000500000000000000B5DFFFFF02150000E61000005801000032000000010000020000E610000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611C0046004B005F00500072006F0062006C0065006D0054006F0053006F006C007500740069006F006E005F00500072006F0062006C0065006D002143341208000000222C00008719000078563412070000001401000053006500720076006900630065005200650066006500720065006E0063006500730020002800640062006F002900000030003000300036003000320030003000300030003000300032003400300030003000300035003200350033003400310033003100300030003000340030003000300030003000310030003000300031003000300032003700320037003300360061006400360065003500660039003500380036006200610063003200640035003300310065006100620063003300610063006300360036003600630032006600380065006300380037003900660061003900340066003800660037006200000000000000000000000000000005000000540000002C0000002C0000002C000000340000000000000000000000222C000087190000000000002D010000080000000C000000070000001C010000E40C00008C0A0000B0040000DC0500001A04000008070000CA08000046050000CA080000220B00009E07000000000000010000005B1D00000D17000000000000060000000600000002000000020000001C010000D30E000000000000010000000C1A00006809000000000000020000000200000002000000020000001C010000E40C000001000000000000000C1A00009E03000000000000000000000000000002000000020000001C010000E40C00000000000000000000A9450000222C000000000000000000000D00000004000000040000001C010000E40C00003C0F00006009000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000001200000053006500720076006900630065005200650066006500720065006E00630065007300000004000B008DB10000B80B000073B40000B80B000073B40000D4490000FC8D0000D44900000000000002000000F0F0F00000000000000000000000000000000000010000000800000000000000D49F00001B3B0000F01300005801000032000000010000020000F013000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61210046004B005F0053006500720076006900630065005200650066006500720065006E006300650073005F0041007A0075007200650053006500720076006900630065002143341208000000F62900008910000078563412070000001401000053006F006C007500740069006F006E0020002800640062006F002900000030003000300039003400300030003000300030003000300036003000320030003000300030003000300032003400300030003000300035003200350033003400310033003100300030003000340030003000300030003000310030003000300031003000300032003700320037003300360061006400360065003500660039003500380036006200610063003200640035003300310065006100620063003300610063006300360036003600630032006600380065006300380037003900660061003900340066003800660037006200000000000000000000000000000005000000540000002C0000002C0000002C000000340000000000000000000000F629000089100000000000002D010000070000000C000000070000001C010000E40C00008C0A0000B0040000DC0500001A04000008070000CA08000046050000CA080000220B00009E07000000000000010000005B1D00000F0E000000000000030000000300000002000000020000001C010000D30E000000000000010000000C1A00008306000000000000010000000100000002000000020000001C010000E40C000001000000000000000C1A00009E03000000000000000000000000000002000000020000001C010000E40C00000000000000000000A9450000222C000000000000000000000D00000004000000040000001C010000E40C00003C0F00006009000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000900000053006F006C007500740069006F006E00000004000B006E280000CA0800009D230000CA0800009D230000EA240000CB1E0000EA2400000000000002000000F0F0F00000000000000000000000000000000000010000000B0000000000000008120000D3140000E61000005801000032000000010000020000E610000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611D0046004B005F00500072006F0062006C0065006D0054006F0053006F006C007500740069006F006E005F0053006F006C007500740069006F006E0021433412080000002B2A00008719000078563412070000001401000053006F006C007500740069006F006E005200650066006500720065006E0063006500730020002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000003B000000000000000000000000000000000000003C010000000000000000000000000000E00C9415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C0000003400000000000000000000002B2A000087190000000000002D010000080000000C000000070000001C010000E40C00008C0A0000B0040000DC0500001A04000008070000CA08000046050000CA080000220B00009E07000000000000010000005B1D00000D17000000000000060000000600000002000000020000001C010000D30E000000000000010000000C1A00006809000000000000020000000200000002000000020000001C010000E40C000001000000000000000C1A00009E03000000000000000000000000000002000000020000001C010000E40C00000000000000000000A9450000222C000000000000000000000D00000004000000040000001C010000E40C00003C0F00006009000078563412040000006E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000001300000053006F006C007500740069006F006E005200650066006500720065006E00630065007300000004000B006E2800008C0A00001D2500008C0A00001D25000050460000302A0000504600000000000002000000F0F0F00000000000000000000000000000000000010000000E000000000000004B120000AD2800002312000058010000320000000100000200002312000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611F0046004B005F0053006F006C007500740069006F006E005200650066006500720065006E006300650073005F0053006F006C007500740069006F006E00310021433412080000007A2A0000BD16000078563412070000001401000053006F006C007500740069006F006E0054006F00530065007200760069006300650020002800640062006F00290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000003B000000000000000000000000000000000000003C010000000000000000000000000000C00B9415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000540000002C0000002C0000002C0000003400000000000000000000007A2A0000BD160000000000002D010000070000000C000000070000001C010000E40C00008C0A0000B0040000DC0500001A04000008070000CA08000046050000CA080000220B00009E07000000000000010000005A1D0000FB14000000000000050000000500000002000000020000001C010000D30E000000000000010000000C1A00004D0C000000000000030000000300000002000000020000001C010000E40C000001000000000000000C1A00009E03000000000000000000000000000002000000020000001C010000E40C00000000000000000000A9450000222C000000000000000000000D00000004000000040000001C010000E40C00003C0F00006009000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000001200000053006F006C007500740069006F006E0054006F005300650072007600690063006500000004000B006452000060090000E354000060090000E3540000FC210000E4570000FC2100000000000002000000F0F0F00000000000000000000000000000000000010000001100000000000000925500009A1300008F10000058010000310000000100000200008F10000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611D0046004B005F0053006F006C007500740069006F006E0054006F0053006500720076006900630065005F0053006F006C007500740069006F006E0004000B00C48600004E0C00008B8400004E0C00008B840000922200005E820000922200000000000002000000F0F0F000000000000000000000000000000000000100000013000000000000003A850000901B000060130000580100003F0000000100000200006013000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61210046004B005F0053006F006C007500740069006F006E0054006F0053006500720076006900630065005F0041007A00750072006500530065007200760069006300650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000014000000D21200000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000200000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000021000000480400000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000003300000012000000000000000C000000AAE9FFFFF4F9FFFF0100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0033003300300030002C0031002C0032003700300030002C0035002C0031003800300030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003700390035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0033003300300030002C00310032002C0033003900300030002C00310031002C0032003400300030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0033003300300030002C0031002C0032003700300030002C0035002C0031003800300030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003700390035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0033003300300030002C00310032002C0033003900300030002C00310031002C0032003400300030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0033003300300030002C0031002C0032003700300030002C0035002C0031003800300030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003700390035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0033003300300030002C00310032002C0033003900300030002C00310031002C00320034003000300000000400000004000000000000004A0000000100350001000000640062006F00000046004B005F00500072006F0062006C0065006D0054006F0053006F006C007500740069006F006E005F00500072006F0062006C0065006D0000000000000000000000C402000000000500000005000000040000000800000001BF202810BF20280000000000000000AD070000000000060000000600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0033003300300030002C0031002C0032003700300030002C0035002C0031003800300030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003700390035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0033003300300030002C00310032002C0033003900300030002C00310031002C0032003400300030000000070000000700000000000000540000000111EF7501000000640062006F00000046004B005F0053006500720076006900630065005200650066006500720065006E006300650073005F0041007A00750072006500530065007200760069006300650000000000000000000000C402000000000800000008000000070000000800000001BB202850BB20280000000000000000AD070000000000090000000900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0033003300300030002C0031002C0032003700300030002C0035002C0031003800300030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003700390035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0033003300300030002C00310032002C0033003900300030002C00310031002C00320034003000300000000A0000000A000000000000004C0000000184816201000000640062006F00000046004B005F00500072006F0062006C0065006D0054006F0053006F006C007500740069006F006E005F0053006F006C007500740069006F006E0000000000000000000000C402000000000B0000000B0000000A0000000800000001BB202810BB20280000000000000000AD0700000000000C0000000C00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0033003300300030002C0031002C0032003700300030002C0035002C0031003800300030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003700390035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0033003300300030002C00310032002C0033003900300030002C00310031002C00320034003000300000000D0000000D0000000000000050000000014FA22E01000000640062006F00000046004B005F0053006F006C007500740069006F006E005200650066006500720065006E006300650073005F0053006F006C007500740069006F006E00310000000000000000000000C402000000000E0000000E0000000D0000000800000001BA2028D0BA20280000000000000000AD0700000000000F0000000F00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000030000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0033003300300030002C0031002C0032003700300030002C0035002C0031003800300030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0033003700390035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0033003300300030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0033003300300030002C00310032002C0033003900300030002C00310031002C00320034003000300000001000000010000000000000004C0000000100350001000000640062006F00000046004B005F0053006F006C007500740069006F006E0054006F0053006500720076006900630065005F0053006F006C007500740069006F006E0000000000000000000000C402000000001100000011000000100000000800000001BD2028D0BD20280000000000000000AD070000000000120000001200000000000000540000000111EF7501000000640062006F00000046004B005F0053006F006C007500740069006F006E0054006F0053006500720076006900630065005F0041007A00750072006500530065007200760069006300650000000000000000000000C402000000001300000013000000120000000800000001BE2028D0BE20280000000000000000AD0700000000001E00000012000000010000000F000000A6000000B1000000070000000100000006000000A5000000DD000000040000000200000003000000A2000000AC00000010000000090000000F000000A1000000AE0000000D000000090000000C000000A4000000CC0000000A00000009000000030000009E000000B50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F5739000002000018C251532CD501020200001048450000000000000000000000000000000000340200004400610074006100200053006F0075007200630065003D00620077006F006F0064007900730071006C0061007A007500720065002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074003B0049006E0069007400690061006C00200043006100740061006C006F0067003D00730071006C0074006F0061007A007500720065003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D006200750063006B003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B0045006E00630072007900700074003D0054007200750065003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F0022000000008005001200000043006F006D0070006C006500740065000000000226002400000053006F006C007500740069006F006E0054006F005300650072007600690063006500000008000000640062006F000000000226002600000053006F006C007500740069006F006E005200650066006500720065006E00630065007300000008000000640062006F000000000226001200000053006F006C007500740069006F006E00000008000000640062006F000000000226002400000053006500720076006900630065005200650066006500720065006E00630065007300000008000000640062006F0000000002260024000000500072006F0062006C0065006D0054006F0053006F006C007500740069006F006E00000008000000640062006F0000000002260010000000500072006F0062006C0065006D00000008000000640062006F000000000224001A00000041007A007500720065005300650072007600690063006500000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProblemToSolution]  WITH NOCHECK ADD  CONSTRAINT [FK_ProblemToSolution_Problem] FOREIGN KEY([SolutionID])
REFERENCES [dbo].[Problem] ([ProblemID])
GO
ALTER TABLE [dbo].[ProblemToSolution] CHECK CONSTRAINT [FK_ProblemToSolution_Problem]
GO
ALTER TABLE [dbo].[ProblemToSolution]  WITH CHECK ADD  CONSTRAINT [FK_ProblemToSolution_Solution] FOREIGN KEY([ProblemID])
REFERENCES [dbo].[Solution] ([SolutionID])
GO
ALTER TABLE [dbo].[ProblemToSolution] CHECK CONSTRAINT [FK_ProblemToSolution_Solution]
GO
ALTER TABLE [dbo].[ServiceReferences]  WITH CHECK ADD  CONSTRAINT [FK_ServiceReferences_AzureService] FOREIGN KEY([AzureServiceID])
REFERENCES [dbo].[AzureService] ([AzureServiceID])
GO
ALTER TABLE [dbo].[ServiceReferences] CHECK CONSTRAINT [FK_ServiceReferences_AzureService]
GO
ALTER TABLE [dbo].[SolutionReferences]  WITH CHECK ADD  CONSTRAINT [FK_SolutionReferences_Solution1] FOREIGN KEY([SolutionID])
REFERENCES [dbo].[Solution] ([SolutionID])
GO
ALTER TABLE [dbo].[SolutionReferences] CHECK CONSTRAINT [FK_SolutionReferences_Solution1]
GO
ALTER TABLE [dbo].[SolutionToService]  WITH CHECK ADD  CONSTRAINT [FK_SolutionToService_AzureService] FOREIGN KEY([AzureServiceID])
REFERENCES [dbo].[AzureService] ([AzureServiceID])
GO
ALTER TABLE [dbo].[SolutionToService] CHECK CONSTRAINT [FK_SolutionToService_AzureService]
GO
ALTER TABLE [dbo].[SolutionToService]  WITH CHECK ADD  CONSTRAINT [FK_SolutionToService_Solution] FOREIGN KEY([SolutionID])
REFERENCES [dbo].[Solution] ([SolutionID])
GO
ALTER TABLE [dbo].[SolutionToService] CHECK CONSTRAINT [FK_SolutionToService_Solution]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
ALTER DATABASE [solutions] SET  READ_WRITE 
GO
