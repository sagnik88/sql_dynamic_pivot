
CREATE TABLE [dbo].[vp_contact](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_name] [nvarchar](255) NULL,
 CONSTRAINT [PK_vp_contact] PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[vp_contact_address](
	[contact_address_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_id] [int] NULL,
	[contact_address] [nvarchar](255) NULL,
 CONSTRAINT [pk_vp_contact_number] PRIMARY KEY CLUSTERED 
(
	[contact_address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[vp_contact_phone](
	[contact_phone_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_id] [int] NOT NULL,
	[contact_phone_number] [varchar](max) NULL,
 CONSTRAINT [pk_vp_contact_phone] PRIMARY KEY CLUSTERED 
(
	[contact_phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE TABLE [dbo].[vp_contact_type](
	[contact_type_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_id] [int] NOT NULL,
	[contact_type_name] [nvarchar](255) NULL,
 CONSTRAINT [pk_vp_contact_type] PRIMARY KEY CLUSTERED 
(
	[contact_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]