USE [master]
GO
/****** Object:  Database [BlogDB2]    Script Date: 3/10/2024 10:08:27 PM ******/
CREATE DATABASE [BlogDB2]
GO
ALTER DATABASE [BlogDB2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BlogDB2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BlogDB2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BlogDB2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BlogDB2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BlogDB2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BlogDB2] SET ARITHABORT OFF 
GO
ALTER DATABASE [BlogDB2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BlogDB2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BlogDB2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BlogDB2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BlogDB2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BlogDB2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BlogDB2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BlogDB2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BlogDB2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BlogDB2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BlogDB2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BlogDB2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BlogDB2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BlogDB2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BlogDB2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BlogDB2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BlogDB2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BlogDB2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BlogDB2] SET  MULTI_USER 
GO
ALTER DATABASE [BlogDB2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BlogDB2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BlogDB2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BlogDB2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BlogDB2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BlogDB2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BlogDB2] SET QUERY_STORE = OFF
GO
USE [BlogDB2]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/10/2024 10:08:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 3/10/2024 10:08:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NULL,
	[UserID] [int] NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[CommentDate] [datetime] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 3/10/2024 10:08:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[AuthorID] [int] NULL,
	[CategoryID] [int] NULL,
	[Status] [bit] NULL,
	[PublishedDate] [datetime] NULL,
	[LikesCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/10/2024 10:08:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[UserRole] [nvarchar](20) NOT NULL,
	[Status] [bit] NULL,
	[RegistrationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Status]) VALUES (1, N'Ẩm thực Việt', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Status]) VALUES (2, N'Ẩm thực Ý', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Status]) VALUES (3, N'Ẩm thực Thái', 0)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Status]) VALUES (4, N'Đồ uống', 0)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [UserRole], [Status], [RegistrationDate]) VALUES (1, N'admin', N'admin', N'admin@example.com', N'Admin', 1, CAST(N'2024-03-09T10:05:01.217' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [UserRole], [Status], [RegistrationDate]) VALUES (2, N'user1', N'user', N'user1@example.com', N'User', 1, CAST(N'2024-03-09T10:05:01.217' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [UserRole], [Status], [RegistrationDate]) VALUES (3, N'user2', N'user', N'user2@example.com', N'User', 1, CAST(N'2024-03-09T10:05:01.217' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [UserRole], [Status], [RegistrationDate]) VALUES (4, N'test', N'test', N'testuser@example.com', N'User', 1, CAST(N'2024-03-09T10:22:22.430' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Email], [UserRole], [Status], [RegistrationDate]) VALUES (5, N'test2', N'test2', N'test@mail.com', N'User', 0, CAST(N'2024-03-09T10:50:10.287' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT (getdate()) FOR [CommentDate]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT (getdate()) FOR [PublishedDate]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((0)) FOR [LikesCount]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([PostID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
ON DELETE CASCADE
GO
USE [master]
GO
ALTER DATABASE [BlogDB2] SET  READ_WRITE 
GO
