USE [Facturacion]
GO
/****** Object:  Schema [app]    Script Date: 20/7/2018 3:59:59 p. m. ******/
CREATE SCHEMA [app]
GO
/****** Object:  Table [app].[Clientes]    Script Date: 20/7/2018 3:59:59 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Clientes](
	[ClienteId] [int] IDENTITY(1,1) NOT NULL,
	[Rif] [varchar](25) NOT NULL,
	[Nombres] [varchar](125) NOT NULL,
	[Apellidos] [varchar](255) NOT NULL,
	[Correo] [varchar](55) NOT NULL,
	[Telefono] [varchar](25) NOT NULL,
	[Direccion] [varchar](255) NOT NULL,
	[Estado] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[ClienteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Factura]    Script Date: 20/7/2018 4:00:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Factura](
	[FacturaId] [int] IDENTITY(1,1) NOT NULL,
	[OrdenId] [int] NOT NULL,
	[ClienteId] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[FacturaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Orden]    Script Date: 20/7/2018 4:00:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Orden](
	[OrdenId] [int] IDENTITY(1,1) NOT NULL,
	[ProductoId] [int] NOT NULL,
	[ClienteId] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Total] [varchar](125) NOT NULL,
	[Estado] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Orden] PRIMARY KEY CLUSTERED 
(
	[OrdenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Productos]    Script Date: 20/7/2018 4:00:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Productos](
	[ProductoId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](125) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[Precio] [varchar](255) NOT NULL,
	[Stock] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[ProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Roles]    Script Date: 20/7/2018 4:00:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Roles](
	[RolId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](125) NOT NULL,
	[Estado] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RolId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [app].[Usuarios]    Script Date: 20/7/2018 4:00:00 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Usuarios](
	[UsuarioId] [int] IDENTITY(1,1) NOT NULL,
	[RolId] [int] NOT NULL,
	[Nombres] [varchar](125) NOT NULL,
	[Apellidos] [varchar](255) NOT NULL,
	[Correo] [varchar](255) NOT NULL,
	[Clave] [varchar](255) NOT NULL,
	[Estado] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [app].[Clientes] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [app].[Clientes] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [app].[Factura] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [app].[Factura] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [app].[Orden] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [app].[Orden] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [app].[Productos] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [app].[Productos] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [app].[Roles] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [app].[Roles] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [app].[Usuarios] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [app].[Usuarios] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [app].[Factura]  WITH CHECK ADD FOREIGN KEY([ClienteId])
REFERENCES [app].[Clientes] ([ClienteId])
GO
ALTER TABLE [app].[Factura]  WITH CHECK ADD FOREIGN KEY([OrdenId])
REFERENCES [app].[Orden] ([OrdenId])
GO
ALTER TABLE [app].[Orden]  WITH CHECK ADD FOREIGN KEY([ClienteId])
REFERENCES [app].[Clientes] ([ClienteId])
GO
ALTER TABLE [app].[Orden]  WITH CHECK ADD FOREIGN KEY([ProductoId])
REFERENCES [app].[Productos] ([ProductoId])
GO
ALTER TABLE [app].[Usuarios]  WITH CHECK ADD FOREIGN KEY([RolId])
REFERENCES [app].[Roles] ([RolId])
GO
