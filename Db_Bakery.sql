USE [master]
GO
/****** Object:  Database [Bd_Bakery]    Script Date: 9/18/2024 3:17:45 AM ******/
CREATE DATABASE [Bd_Bakery]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bd_Bakery', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Bd_Bakery.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bd_Bakery_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Bd_Bakery_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Bd_Bakery] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bd_Bakery].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bd_Bakery] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bd_Bakery] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bd_Bakery] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bd_Bakery] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bd_Bakery] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bd_Bakery] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bd_Bakery] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bd_Bakery] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bd_Bakery] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bd_Bakery] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bd_Bakery] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bd_Bakery] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bd_Bakery] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bd_Bakery] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bd_Bakery] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bd_Bakery] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bd_Bakery] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bd_Bakery] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bd_Bakery] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bd_Bakery] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bd_Bakery] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bd_Bakery] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bd_Bakery] SET RECOVERY FULL 
GO
ALTER DATABASE [Bd_Bakery] SET  MULTI_USER 
GO
ALTER DATABASE [Bd_Bakery] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bd_Bakery] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bd_Bakery] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bd_Bakery] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bd_Bakery] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bd_Bakery] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Bd_Bakery', N'ON'
GO
ALTER DATABASE [Bd_Bakery] SET QUERY_STORE = ON
GO
ALTER DATABASE [Bd_Bakery] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Bd_Bakery]
GO
/****** Object:  Table [dbo].[TblCashReg]    Script Date: 9/18/2024 3:17:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCashReg](
	[income] [decimal](18, 2) NULL,
	[cost] [decimal](18, 2) NULL,
	[profit] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblProducts]    Script Date: 9/18/2024 3:17:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblProducts](
	[productId] [tinyint] IDENTITY(1,1) NOT NULL,
	[productName] [varchar](20) NULL,
	[productCost] [decimal](18, 2) NULL,
	[productPrice] [decimal](18, 2) NULL,
	[productStock] [smallint] NULL,
 CONSTRAINT [PK_TblProducts] PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblReceipt]    Script Date: 9/18/2024 3:17:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblReceipt](
	[receiptId] [int] IDENTITY(1,1) NOT NULL,
	[unitReceiptId] [smallint] NULL,
	[productReceiptId] [tinyint] NULL,
	[unitAmount] [decimal](18, 2) NULL,
	[unitCost] [decimal](18, 2) NULL,
 CONSTRAINT [PK_TblReceipt] PRIMARY KEY CLUSTERED 
(
	[receiptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblUnits]    Script Date: 9/18/2024 3:17:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUnits](
	[unitId] [smallint] IDENTITY(1,1) NOT NULL,
	[unitName] [varchar](20) NULL,
	[unitStok] [decimal](18, 2) NULL,
	[unitPrice] [decimal](18, 2) NULL,
	[unitNote] [varchar](20) NULL,
 CONSTRAINT [PK_TblUnits] PRIMARY KEY CLUSTERED 
(
	[unitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblProducts] ADD  CONSTRAINT [DF_TblProducts_productCost]  DEFAULT ((0)) FOR [productCost]
GO
ALTER TABLE [dbo].[TblProducts] ADD  CONSTRAINT [DF_TblProducts_productPrice]  DEFAULT ((0)) FOR [productPrice]
GO
ALTER TABLE [dbo].[TblProducts] ADD  CONSTRAINT [DF_TblProducts_productStock]  DEFAULT ((0)) FOR [productStock]
GO
ALTER TABLE [dbo].[TblUnits] ADD  CONSTRAINT [DF_TblUnits_unitNote]  DEFAULT ('Empty') FOR [unitNote]
GO
ALTER TABLE [dbo].[TblReceipt]  WITH CHECK ADD  CONSTRAINT [FK_TblReceipt_TblProducts] FOREIGN KEY([productReceiptId])
REFERENCES [dbo].[TblProducts] ([productId])
GO
ALTER TABLE [dbo].[TblReceipt] CHECK CONSTRAINT [FK_TblReceipt_TblProducts]
GO
ALTER TABLE [dbo].[TblReceipt]  WITH CHECK ADD  CONSTRAINT [FK_TblReceipt_TblUnits] FOREIGN KEY([unitReceiptId])
REFERENCES [dbo].[TblUnits] ([unitId])
GO
ALTER TABLE [dbo].[TblReceipt] CHECK CONSTRAINT [FK_TblReceipt_TblUnits]
GO
USE [master]
GO
ALTER DATABASE [Bd_Bakery] SET  READ_WRITE 
GO
