CREATE TABLE CMS_USERS ( 
	USER_ID VARCHAR2(36) NOT NULL,
	USER_NAME VARCHAR2(64) NOT NULL,
	USER_PASSWORD VARCHAR2(32) NOT NULL,
	USER_DESCRIPTION VARCHAR2(255) NOT NULL,
	USER_FIRSTNAME VARCHAR2(50) NOT NULL,
	USER_LASTNAME VARCHAR2(50) NOT NULL,
	USER_EMAIL VARCHAR2(100) NOT NULL,
	USER_LASTLOGIN NUMBER NOT NULL,
	USER_FLAGS INT NOT NULL,
	USER_INFO BLOB,
	USER_ADDRESS VARCHAR2(100) NOT NULL,
	USER_TYPE INT NOT NULL,
	CONSTRAINT PK_USERS PRIMARY KEY(USER_ID) USING INDEX TABLESPACE ${indexTablespace},
	CONSTRAINT UK_USERS UNIQUE(USER_NAME) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_PROJECTS ( 
	PROJECT_ID INT NOT NULL,
	PROJECT_NAME VARCHAR2(64) NOT NULL,
	PROJECT_DESCRIPTION VARCHAR2(255) NOT NULL,
	PROJECT_FLAGS INT NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID VARCHAR2(36) NOT NULL,
	GROUP_ID VARCHAR2(36) NOT NULL,
	MANAGERGROUP_ID VARCHAR2(36) NOT NULL,
	TASK_ID INT NOT NULL,
	DATE_CREATED NUMBER NOT NULL,
	CONSTRAINT PK_PROJECTS PRIMARY KEY(PROJECT_ID) USING INDEX TABLESPACE ${indexTablespace},
	CONSTRAINT UK_PROJECTS UNIQUE(PROJECT_NAME,DATE_CREATED) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_BACKUP_PROJECTS (
	PROJECT_ID INT NOT NULL,
	PROJECT_NAME VARCHAR2(64) NOT NULL,
	PROJECT_DESCRIPTION VARCHAR2(255) NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID VARCHAR2(36) NOT NULL,
	GROUP_ID VARCHAR2(36) NOT NULL,
	MANAGERGROUP_ID VARCHAR2(36) NOT NULL,
	TASK_ID INT NOT NULL,
	DATE_CREATED NUMBER NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	PROJECT_PUBLISHDATE DATE,
	PROJECT_PUBLISHED_BY VARCHAR2(36) NOT NULL,
	PROJECT_PUBLISHED_BY_NAME VARCHAR2(167),
	USER_NAME VARCHAR2(167),
	GROUP_NAME VARCHAR2(64),
	MANAGERGROUP_NAME VARCHAR2(64),			
	CONSTRAINT PK_BACKUP_PROJECTS PRIMARY KEY(PUBLISH_TAG) USING INDEX TABLESPACE ${indexTablespace}
);
 
CREATE TABLE CMS_PROJECTRESOURCES (
	PROJECT_ID NUMBER NOT NULL,
	RESOURCE_PATH VARCHAR2(1024),
	CONSTRAINT PK_PROJECTRESOURCES PRIMARY KEY(PROJECT_ID, RESOURCE_PATH) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_BACKUP_PROJECTRESOURCES (
	PUBLISH_TAG INT NOT NULL,
	PROJECT_ID INT NOT NULL,
	RESOURCE_PATH VARCHAR2(1024),
	CONSTRAINT PK_BACKUP_PROJECTRESOURCES PRIMARY KEY(PUBLISH_TAG, PROJECT_ID, RESOURCE_PATH) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_OFFLINE_PROPERTYDEF ( 
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR2(128) NOT NULL,
	PROPERTYDEF_MAPPING_TYPE INT NOT NULL,
	CONSTRAINT PK_OFFLINE_PROPERTYDEF PRIMARY KEY(PROPERTYDEF_ID) USING INDEX TABLESPACE ${indexTablespace},
	CONSTRAINT UK_OFFLINE_PROPERTYDEF UNIQUE(PROPERTYDEF_NAME, PROPERTYDEF_MAPPING_TYPE) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_ONLINE_PROPERTYDEF ( 
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR2(128) NOT NULL,
	PROPERTYDEF_MAPPING_TYPE INT NOT NULL,
	CONSTRAINT PK_ONLINE_PROPERTYDEF PRIMARY KEY(PROPERTYDEF_ID) USING INDEX TABLESPACE ${indexTablespace},
	CONSTRAINT UK_ONLINE_PROPERTYDEF UNIQUE(PROPERTYDEF_NAME, PROPERTYDEF_MAPPING_TYPE) USING INDEX TABLESPACE ${indexTablespace} 
);

CREATE TABLE CMS_BACKUP_PROPERTYDEF ( 
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR2(128) NOT NULL,
	PROPERTYDEF_MAPPING_TYPE INT NOT NULL,
	CONSTRAINT PK_BACKUP_PROPERTYDEF PRIMARY KEY(PROPERTYDEF_ID) USING INDEX TABLESPACE ${indexTablespace},
	CONSTRAINT UK_BACKUP_PROPERTYDEF UNIQUE(PROPERTYDEF_NAME, PROPERTYDEF_MAPPING_TYPE) USING INDEX TABLESPACE ${indexTablespace} 
);

CREATE TABLE CMS_OFFLINE_PROPERTIES (
	PROPERTY_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR2(2048) NOT NULL,
	CONSTRAINT PK_OFFLINE_PROPERTIES PRIMARY KEY(PROPERTY_ID) USING INDEX TABLESPACE ${indexTablespace}
	STORAGE (FREELISTS 10)
);

CREATE TABLE CMS_ONLINE_PROPERTIES (
	PROPERTY_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR2(2048) NOT NULL,
	CONSTRAINT PK_ONLINE_PROPERTIES PRIMARY KEY(PROPERTY_ID) USING INDEX TABLESPACE ${indexTablespace}
	STORAGE (FREELISTS 10)
);

CREATE TABLE CMS_BACKUP_PROPERTIES (
    BACKUP_ID VARCHAR2(36) NOT NULL,
	PROPERTY_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR2(2048) NOT NULL,
	PUBLISH_TAG INT,
	VERSION_ID INT NOT NULL,
	CONSTRAINT PK_BACKUP_PROPERTIES PRIMARY KEY(PROPERTY_ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_OFFLINE_RESOURCES (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,
	DATE_CREATED NUMBER NOT NULL,
	DATE_LASTMODIFIED NUMBER NOT NULL,
	USER_CREATED VARCHAR2(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PROJECT_LASTMODIFIED INT NOT NULL,
	CONSTRAINT PK_OFFLINE_RESOURCES PRIMARY KEY(RESOURCE_ID) USING INDEX TABLESPACE ${indexTablespace}
	STORAGE (FREELISTS 10)
);

CREATE TABLE CMS_ONLINE_RESOURCES (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED NUMBER NOT NULL,
	DATE_LASTMODIFIED NUMBER NOT NULL,
	USER_CREATED VARCHAR2(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PROJECT_LASTMODIFIED INT NOT NULL,
	CONSTRAINT PK_ONLINE_RESOURCES PRIMARY KEY(RESOURCE_ID) USING INDEX TABLESPACE ${indexTablespace}
	STORAGE (FREELISTS 10)
);

CREATE TABLE CMS_BACKUP_RESOURCES (
	BACKUP_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED NUMBER NOT NULL,
	DATE_LASTMODIFIED NUMBER NOT NULL,
	USER_CREATED VARCHAR2(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PROJECT_LASTMODIFIED INT NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	VERSION_ID INT NOT NULL,
    USER_CREATED_NAME VARCHAR2(64) NOT NULL,
    USER_LASTMODIFIED_NAME VARCHAR2(64) NOT NULL,
	CONSTRAINT PK_BACKUP_RESOURCES PRIMARY KEY(BACKUP_ID) USING INDEX TABLESPACE ${indexTablespace},
	CONSTRAINT UK_BACKUP_RESOURCES UNIQUE(PUBLISH_TAG,RESOURCE_ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_OFFLINE_CONTENTS (
	CONTENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	FILE_CONTENT BLOB NOT NULL,
	CONSTRAINT PK_OFFLINE_CONTENTS PRIMARY KEY(CONTENT_ID) USING INDEX TABLESPACE ${indexTablespace}
)
	STORAGE (INITIAL 256K NEXT 1M PCTINCREASE 0)
	LOB(FILE_CONTENT) STORE AS (
		CHUNK 32K PCTVERSION 20  
	    CACHE
);

CREATE TABLE CMS_ONLINE_CONTENTS (
	CONTENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	FILE_CONTENT BLOB NOT NULL,
	CONSTRAINT PK_ONLINE_CONTENTS PRIMARY KEY(CONTENT_ID) USING INDEX TABLESPACE ${indexTablespace}
)
	STORAGE (INITIAL 256K NEXT 1M PCTINCREASE 0)
	LOB(FILE_CONTENT) STORE AS (
        CHUNK 32K PCTVERSION 20  
        CACHE
);

CREATE TABLE CMS_BACKUP_CONTENTS (
	BACKUP_ID VARCHAR2(36) NOT NULL,
	CONTENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	FILE_CONTENT BLOB NOT NULL,
	PUBLISH_TAG INT,
	VERSION_ID INT NOT NULL,
	CONSTRAINT PK_BACKUP_CONTENTS PRIMARY KEY(BACKUP_ID) USING INDEX TABLESPACE ${indexTablespace}
)	
	STORAGE (INITIAL 256K NEXT 1M PCTINCREASE 0)
	LOB(FILE_CONTENT) STORE AS (
        CHUNK 32K PCTVERSION 20  
        CACHE
);

CREATE TABLE CMS_GROUPS (
	GROUP_ID VARCHAR2(36) NOT NULL,
	PARENT_GROUP_ID VARCHAR2(36) NOT NULL,
	GROUP_NAME VARCHAR2(64) NOT NULL,
	GROUP_DESCRIPTION VARCHAR2(255) NOT NULL,
	GROUP_FLAGS INT NOT NULL,
	CONSTRAINT PK_GROUPS PRIMARY KEY(GROUP_ID) USING INDEX TABLESPACE ${indexTablespace},
	CONSTRAINT UK_GROUPS UNIQUE(GROUP_NAME) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_SYSTEMID (
	TABLE_KEY VARCHAR2(255) NOT NULL,
	ID INT NOT NULL,
	CONSTRAINT PK_SYSTEMID PRIMARY KEY(TABLE_KEY) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_GROUPUSERS (
	GROUP_ID VARCHAR2(36) NOT NULL,
	USER_ID VARCHAR2(36) NOT NULL,
	GROUPUSER_FLAGS INT NOT NULL,
	CONSTRAINT UK_GROUPUSERS UNIQUE(GROUP_ID, USER_ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_TASK ( 
	AUTOFINISH INT, 
	ENDTIME DATE, 
	ESCALATIONTYPEREF INT, 
	ID INT NOT NULL, 
	INITIATORUSERREF VARCHAR2(36), 
	MILESTONEREF INT, 
	NAME VARCHAR(254), 
	ORIGINALUSERREF VARCHAR2(36), 
	AGENTUSERREF VARCHAR2(36), 
	PARENT INT, 
	PERCENTAGE VARCHAR(50), 
	PERMISSION VARCHAR(50), 
	PRIORITYREF INT DEFAULT '2', 
	ROLEREF VARCHAR2(36), 
	ROOT INT, 
	STARTTIME DATE, 
	STATE INT, 
	TASKTYPEREF INT, 
	TIMEOUT DATE, 
	WAKEUPTIME DATE, 
	HTMLLINK VARCHAR(254), 
	ESTIMATETIME INT DEFAULT '86400', 
	CONSTRAINT PK_TASK PRIMARY KEY(ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_TASKTYPE (
	AUTOFINISH INT, 
	ESCALATIONTYPEREF INT, 
	HTMLLINK VARCHAR(254), 
	ID INT NOT NULL, 
	NAME VARCHAR(50), 
	PERMISSION VARCHAR(50), 
	PRIORITYREF INT, 
	ROLEREF VARCHAR2(36), 
	CONSTRAINT PK_TASKTYPE PRIMARY KEY(ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_TASKLOG (
	COMENT LONG, 
	EXTERNALUSERNAME VARCHAR(254), 
	ID INT NOT NULL, 
	STARTTIME DATE, 
	TASKREF INT, 
	USERREF VARCHAR2(36), 
	TYPE INT DEFAULT '0', 
	CONSTRAINT PK_TASKLOG PRIMARY KEY(ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_TASKPAR (
	ID INT NOT NULL, 
	PARNAME VARCHAR(50), 
	PARVALUE VARCHAR(50), 
	REF INT, 
	CONSTRAINT PK_TASKPAR PRIMARY KEY(ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_ONLINE_ACCESSCONTROL (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	PRINCIPAL_ID VARCHAR2(36) NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	CONSTRAINT PK_ONLINE_ACCESSCONTROL PRIMARY KEY(RESOURCE_ID, PRINCIPAL_ID) USING INDEX TABLESPACE ${indexTablespace}
);
   
CREATE TABLE CMS_OFFLINE_ACCESSCONTROL (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	PRINCIPAL_ID VARCHAR2(36) NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	CONSTRAINT PK_OFFLINE_ACCESSCONTROL PRIMARY KEY(RESOURCE_ID, PRINCIPAL_ID) USING INDEX TABLESPACE ${indexTablespace}
);
   
CREATE TABLE CMS_OFFLINE_STRUCTURE (
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR(236) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024),
	STRUCTURE_STATE INT NOT NULL,	
	DATE_RELEASED NUMBER NOT NULL,
	DATE_EXPIRED NUMBER NOT NULL,	
	CONSTRAINT PK_OFFLINE_STRUCTURE PRIMARY KEY (STRUCTURE_ID) USING INDEX TABLESPACE ${indexTablespace}
	STORAGE (FREELISTS 10)
);

CREATE TABLE CMS_ONLINE_STRUCTURE (
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR(236) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024),
	STRUCTURE_STATE INT NOT NULL,	
	DATE_RELEASED NUMBER NOT NULL,
	DATE_EXPIRED NUMBER NOT NULL,		
	CONSTRAINT PK_ONLINE_STRUCTURE PRIMARY KEY (STRUCTURE_ID) USING INDEX TABLESPACE ${indexTablespace}
	STORAGE (FREELISTS 10)
);

CREATE TABLE CMS_BACKUP_STRUCTURE (
	BACKUP_ID VARCHAR2(36) NOT NULL,
    PUBLISH_TAG INT NOT NULL,
    VERSION_ID INT NOT NULL,
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024),
	STRUCTURE_STATE INT NOT NULL,
	DATE_RELEASED NUMBER NOT NULL,
	DATE_EXPIRED NUMBER NOT NULL,		
	CONSTRAINT PK_BACKUP_STRUCTURE PRIMARY KEY (BACKUP_ID) USING INDEX TABLESPACE ${indexTablespace}
);     

CREATE TABLE CMS_PUBLISH_HISTORY (
	HISTORY_ID VARCHAR(36) NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024),
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	CONSTRAINT PK_PUBLISH_HISTORY PRIMARY KEY (HISTORY_ID, PUBLISH_TAG, STRUCTURE_ID, RESOURCE_ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE TABLE CMS_STATICEXPORT_LINKS (
	LINK_ID VARCHAR(36) NOT NULL,
	LINK_RFS_PATH VARCHAR2(1024),
	LINK_TYPE INT NOT NULL,
	LINK_PARAMETER VARCHAR2(1024),
	LINK_TIMESTAMP NUMBER NOT NULL,
	CONSTRAINT CMS_STATICEXPORT_LINKS PRIMARY KEY (LINK_ID) USING INDEX TABLESPACE ${indexTablespace}
);

CREATE INDEX IDX_PUBLISH_HISTORY_01 
	ON CMS_PUBLISH_HISTORY(HISTORY_ID);

CREATE INDEX IDX_GROUPS_01 
	ON CMS_GROUPS(PARENT_GROUP_ID)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_GROUPUSERS_01 
	ON CMS_GROUPUSERS(GROUP_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_GROUPUSERS_02 
	ON CMS_GROUPUSERS(USER_ID)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_PROJECTS_01 
	ON CMS_PROJECTS(GROUP_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_PROJECTS_02 
	ON CMS_PROJECTS(MANAGERGROUP_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_PROJECTS_03 
	ON CMS_PROJECTS(USER_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_PROJECTS_04 
	ON CMS_PROJECTS(PROJECT_NAME)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_PROJECTS_05 
	ON CMS_PROJECTS(TASK_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_PROJECTS_06 
	ON CMS_PROJECTS (PROJECT_FLAGS)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_OFFLINE_RESOURCES_01 
	ON CMS_OFFLINE_RESOURCES (RESOURCE_ID,RESOURCE_TYPE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_RESOURCES_04
	ON CMS_OFFLINE_RESOURCES (RESOURCE_ID, RESOURCE_STATE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_RESOURCES_05
	ON CMS_OFFLINE_RESOURCES (DATE_LASTMODIFIED)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_RESOURCES_06
	ON CMS_OFFLINE_RESOURCES (RESOURCE_ID, DATE_LASTMODIFIED)
	TABLESPACE ${indexTablespace};
  
CREATE INDEX IDX_ONLINE_RESOURCES_01 
	ON CMS_ONLINE_RESOURCES (RESOURCE_ID,RESOURCE_TYPE)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_ONLINE_RESOURCES_04
	ON CMS_ONLINE_RESOURCES (RESOURCE_ID, RESOURCE_STATE)
	TABLESPACE ${indexTablespace};

CREATE INDEX ONLINE_RESOURCES_05
	ON CMS_ONLINE_RESOURCES (DATE_LASTMODIFIED)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_RESOURCES_06
	ON CMS_ONLINE_RESOURCES (RESOURCE_ID, DATE_LASTMODIFIED)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_STRUCTURE_01 
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_STRUCTURE_03 
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_STRUCTURE_04 
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, STRUCTURE_STATE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_STRUCTURE_05 
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_STRUCTURE_06 
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_PATH, RESOURCE_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_STRUCTURE_07 
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, STRUCTURE_STATE, RESOURCE_ID)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_ONLINE_STRUCTURE_01 
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_STRUCTURE_03 
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_STRUCTURE_04 
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, STRUCTURE_STATE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_STRUCTURE_05 
	ON CMS_ONLINE_STRUCTURE (RESOURCE_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_STRUCTURE_06 
	ON CMS_ONLINE_STRUCTURE (RESOURCE_PATH, RESOURCE_ID)
	TABLESPACE ${indexTablespace};
	  
CREATE INDEX IDX_ONLINE_STRUCTURE_07 
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, STRUCTURE_STATE, RESOURCE_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_BACKUP_STRUCTURE_01
	ON CMS_BACKUP_STRUCTURE (STRUCTURE_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_BACKUP_RESOURCES_01
	ON CMS_BACKUP_RESOURCES (RESOURCE_ID)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_OFFLINE_PROPERTIES_01 
	ON CMS_OFFLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID, PROPERTY_MAPPING_TYPE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_PROPERTIES_02 
	ON CMS_OFFLINE_PROPERTIES (PROPERTYDEF_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_PROPERTIES_03 
	ON CMS_OFFLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID, PROPERTY_VALUE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_OFFLINE_PROPERTIES_04
	ON CMS_OFFLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_ONLINE_PROPERTIES_01 
	ON CMS_ONLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID, PROPERTY_MAPPING_TYPE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_PROPERTIES_02 
	ON CMS_ONLINE_PROPERTIES (PROPERTYDEF_ID)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_PROPERTIES_03 
	ON CMS_ONLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID, PROPERTY_VALUE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_PROPERTIES_04
	ON CMS_ONLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_OFFLINE_PROPERTYDEF_01 
	ON CMS_OFFLINE_PROPERTYDEF (PROPERTYDEF_ID, PROPERTYDEF_MAPPING_TYPE)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_ONLINE_PROPERTYDEF_01 
	ON CMS_ONLINE_PROPERTYDEF (PROPERTYDEF_ID, PROPERTYDEF_MAPPING_TYPE)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_TASK_01 
	ON CMS_TASK(PARENT)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_TASK_02 
	ON CMS_TASK(TASKTYPEREF)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_TASKLOG_01 
	ON CMS_TASKLOG(TASKREF)
	TABLESPACE ${indexTablespace};
	
CREATE INDEX IDX_TASKLOG_02 
	ON CMS_TASKLOG(USERREF)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_TASKPAR_01 
	ON CMS_TASKPAR(REF)
	TABLESPACE ${indexTablespace};

CREATE INDEX IDX_PROJECTRESOURCES_01 
	ON CMS_PROJECTRESOURCES(RESOURCE_PATH)
	TABLESPACE ${indexTablespace};