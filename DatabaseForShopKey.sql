USE [CuongNM]
GO
/****** Object:  Table [dbo].[BalanceHistory]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BalanceHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[User_Username] [varchar](25) NOT NULL,
	[Status] [bit] NOT NULL,
	[Amount] [float] NOT NULL,
	[Reason] [varchar](100) NOT NULL,
	[ChangeDate] [datetime] NOT NULL,
	[NewBalance] [float] NOT NULL,
 CONSTRAINT [BalanceHistory_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[User_Username] [varchar](25) NOT NULL,
	[Total] [float] NOT NULL,
 CONSTRAINT [Cart_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[User_Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItem]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItem](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[User_Username] [varchar](25) NOT NULL,
	[Product_ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [CartItem_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
 CONSTRAINT [Category_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepositHistory]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepositHistory](
	[DepositID] [int] IDENTITY(1,1) NOT NULL,
	[User_Username] [varchar](25) NOT NULL,
	[Amount] [float] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[ActionBy] [varchar](25) NOT NULL,
 CONSTRAINT [DepositRequest_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[DepositID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ProductSoldName] [nvarchar](255) NOT NULL,
	[OrderHistory_OrderID] [int] NOT NULL,
	[ProductKey] [varchar](255) NOT NULL,
	[ExpirationDate] [varchar](10) NULL,
 CONSTRAINT [OrderDetail_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderHistory]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHistory](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[User_Username] [varchar](25) NOT NULL,
 CONSTRAINT [OrderHistory_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Price] [float] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Category_CategoryID] [int] NOT NULL,
 CONSTRAINT [Product_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductKey]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductKey](
	[KeyID] [int] IDENTITY(1,1) NOT NULL,
	[Product_ProductID] [int] NOT NULL,
	[ProductKey] [varchar](255) NOT NULL,
	[ExpirationDate] [varchar](10) NULL,
	[isExpired] [bit] NOT NULL,
 CONSTRAINT [ProductKey_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[KeyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
 CONSTRAINT [Role_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[FirstName] [nvarchar](75) NOT NULL,
	[LastName] [nvarchar](75) NOT NULL,
	[Username] [varchar](25) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Role_RoleID] [int] NOT NULL,
	[IsVerified] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [User_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserBalance]    Script Date: 3/26/2024 9:06:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserBalance](
	[User_Username] [varchar](25) NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [UserBalance_HE172187_pk] PRIMARY KEY CLUSTERED 
(
	[User_Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BalanceHistory] ON 

INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (1, N'hieptv', 1, 10000000, N'Deposit Successfully.', CAST(N'2023-10-31T01:44:58.247' AS DateTime), 10000000)
INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (2, N'hieptv', 1, 100000000, N'Deposit Successfully.', CAST(N'2023-10-31T14:58:50.247' AS DateTime), 100000000)
INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (3, N'hieptv', 1, 1000000000, N'Deposit Successfully.', CAST(N'2023-11-07T17:31:35.283' AS DateTime), 1096000000)
INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (4, N'user2', 1, 99999998430674944, N'Deposit Successfully.', CAST(N'2024-03-16T02:03:01.007' AS DateTime), 99999998430674944)
INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (5, N'user3', 1, 100000000, N'Deposit Successfully.', CAST(N'2024-03-16T12:23:33.780' AS DateTime), 99500000)
INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (6, N'user2', 1, 1, N'Deposit Successfully.', CAST(N'2024-03-16T17:03:39.380' AS DateTime), 99999998403674944)
INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (7, N'user2', 1, 1, N'Deposit Successfully.', CAST(N'2024-03-16T17:03:43.023' AS DateTime), 99999998403674944)
INSERT [dbo].[BalanceHistory] ([ID], [User_Username], [Status], [Amount], [Reason], [ChangeDate], [NewBalance]) VALUES (8, N'user2', 1, -1, N'Deposit Successfully.', CAST(N'2024-03-22T08:19:39.357' AS DateTime), 99999998403674944)
SET IDENTITY_INSERT [dbo].[BalanceHistory] OFF
GO
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'abc123', 0)
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'abc1231111', 0)
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'hieptv', 0)
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'mra123', 0)
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'thaihuu', 0)
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'tranhiwp', 0)
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'user2', 0)
INSERT [dbo].[Cart] ([User_Username], [Total]) VALUES (N'user3', 9000000)
GO
SET IDENTITY_INSERT [dbo].[CartItem] ON 

INSERT [dbo].[CartItem] ([ItemID], [User_Username], [Product_ProductID], [Quantity]) VALUES (34, N'user3', 1, 1)
INSERT [dbo].[CartItem] ([ItemID], [User_Username], [Product_ProductID], [Quantity]) VALUES (35, N'user3', 6, 1)
INSERT [dbo].[CartItem] ([ItemID], [User_Username], [Product_ProductID], [Quantity]) VALUES (36, N'user3', 7, 1)
SET IDENTITY_INSERT [dbo].[CartItem] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (1, N'System')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (2, N'Offices')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (3, N'Tools and Utilities')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (5, N'Games')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[DepositHistory] ON 

INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (1, N'hieptv', 10000000, CAST(N'2023-10-31T01:44:58.247' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (2, N'hieptv', 100000000, CAST(N'2023-10-31T14:58:50.247' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (3, N'hieptv', 1000000000, CAST(N'2023-11-07T17:31:35.283' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (4, N'user2', 99999998430674944, CAST(N'2024-03-16T02:03:01.007' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (5, N'user3', 100000000, CAST(N'2024-03-16T12:23:33.780' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (6, N'user2', 1, CAST(N'2024-03-16T17:03:39.380' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (7, N'user2', 1, CAST(N'2024-03-16T17:03:43.023' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (8, N'user2', -1, CAST(N'2024-03-22T08:19:39.357' AS DateTime), N'admin')
INSERT [dbo].[DepositHistory] ([DepositID], [User_Username], [Amount], [ActionDate], [ActionBy]) VALUES (13, N'user2', 100, CAST(N'2024-03-22T00:00:00.000' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[DepositHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (10, N'Minecraft Java & Bedrock Deluxe Edition', 10, N'RZHYZ-BUYAR-FNOKG-ISXPN-EKIYD-FLWLS', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (11, N'Minecraft Java & Bedrock Deluxe Edition', 10, N'RQQUU-UQIZC-XHHHD-NXFOY-FPYGR-TPCZM', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (12, N'FC 24', 11, N'GWEXO-ALIJS-NALZX-ICFSF-GTAKS-JBAMR', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (13, N'FC 24', 11, N'QTITD-FRDQS-VKELG-EUGXZ-UPOEP-JODEV', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (14, N'Microsoft Windows 11 Pro', 12, N'DKHWK-IVKTN-FLINB-QGNXX-FLRUT-RLQDE', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (15, N'Microsoft Windows 11 Pro', 12, N'PFFCG-DWFYA-LHVGX-AXTOF-SXQTD-YDLOH', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (16, N'Microsoft Office 365', 13, N'PUZKU-YYYRL-UTDPZ-FAXYX-QOWRQ-JFYGG', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (17, N'Microsoft Office 365', 13, N'TIZHT-XBFHT-EXXLM-ZPYYI-RWPNS-GFTJQ', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (18, N'Grand Theft Auto V', 14, N'ENYYY-UACQZ-XUVTX-CPCMZ-YSYZP-WDOVE', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (19, N'Grand Theft Auto V', 14, N'RJZSA-XVRSS-IEKOP-ULSPO-SJKOQ-OQOIX', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (20, N'Red Dead Redemption 2', 15, N'RBNQK-XKDUC-BXBWL-PAZFI-TLUMS-SRAHP', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (21, N'Red Dead Redemption 2', 15, N'JPNST-USEPL-WFCSP-ZVENR-UITYG-ZFNNL', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (22, N'Microsoft Office 365', 16, N'VBJWM-EKKOV-TPZQQ-UXRGO-XWNGS-CFFTN', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (23, N'Microsoft Office 365', 17, N'LKVOS-HPTBL-YTIRB-OLAKB-BDGKG-RGAPZ', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (24, N'Minecraft Java & Bedrock Deluxe Edition', 18, N'LJRAM-VEPHD-BLJVB-NSXQR-GWMTB-RZZTT', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (25, N'FC 24', 19, N'IOTDF-FNGTE-ZLPAT-SUQQO-PLLRC-YZTCM', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (26, N'Grand Theft Auto V', 20, N'TKOFL-LQLBK-DXQDT-DJBVR-JTIGI-HLJRT', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (27, N'Red Dead Redemption 2', 21, N'XAZDO-KSROZ-IMXCL-AGFPN-FTYBQ-FEBBA', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (28, N'Microsoft Office 365', 22, N'TDCDJ-ANOWZ-RZCBE-TINZB-FPPPR-AIZLH', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (29, N'Microsoft Office 365', 22, N'NKIPJ-APYDY-XQCVL-JOEVG-MQLUE-GOJHT', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (30, N'Microsoft Windows 11 Pro', 23, N'QWNSF-AIFJY-KBSIU-KNRVA-YBQOA-YBPWH', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (31, N'Microsoft Windows 11 Pro', 23, N'NSMAJ-NTNHP-VVXMC-TTAMK-EHWIC-NWUQT', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (32, N'Grand Theft Auto V', 24, N'YMKEE-PJLKC-AIRXI-UNWCC-MWQGO-GCEUF', NULL)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [ProductSoldName], [OrderHistory_OrderID], [ProductKey], [ExpirationDate]) VALUES (33, N'Microsoft Office 2019 Professional Plus for Windows', 25, N'YFCKV-VKYCR-CMNWI-JFYKW-YZWOR-FGOIM', NULL)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderHistory] ON 

INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (10, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (11, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (12, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (13, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (14, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (15, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (16, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (17, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (18, N'user3')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (19, N'user3')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (20, N'user3')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (21, N'user3')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (22, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (23, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (24, N'user2')
INSERT [dbo].[OrderHistory] ([OrderID], [User_Username]) VALUES (25, N'user2')
SET IDENTITY_INSERT [dbo].[OrderHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (1, N'Microsoft Windows 11 Pro', N'4a2ed62a-f219-41a1-94ee-9bd72285765d.png', 5000000, N'<p>Windows 11 is the latest major release of Microsoft''s Windows NT operating system, released on October 5, 2021. It succeeded Windows 10 (2015) and is available for free for any Windows 10 devices that meet the new Windows 11 system requirements.</p>
<p>Windows 11 features major changes to the Windows shell influenced by the canceled Windows 10X, including a redesigned Start menu, the replacement of its "live tiles" with a separate "Widgets" panel on the taskbar, the ability to create tiled sets of windows that can be minimized and restored from the taskbar as a group, and new gaming technologies inherited from Xbox Series X and Series S such as Auto HDR and DirectStorage on compatible hardware. Internet Explorer (IE) has been replaced by the Chromium-based Microsoft Edge as the default web browser, like its predecessor, Windows 10, and Microsoft Teams is integrated into the Windows shell. Microsoft also announced plans to allow more flexibility in software that can be distributed via the Microsoft Store and to support Android apps on Windows 11 (including a partnership with Amazon to make its app store available for the function).</p>
<p>Citing security considerations, the system requirements for Windows 11 were increased over Windows 10. Microsoft only officially supports the operating system on devices using an eighth-generation Intel Core CPU or newer (with some minor exceptions), a second-generation AMD Ryzen CPU or newer, or a Qualcomm Snapdragon 850 ARM system-on-chip or newer, with UEFI and Trusted Platform Module (TPM) 2.0 supported and enabled (although Microsoft may provide exceptions to the TPM 2.0 requirement for OEMs). While the OS can be installed on unsupported processors, Microsoft does not guarantee the availability of updates. Windows 11 removed support for 32-bit x86 and 32-bit ARM CPUs and devices that use BIOS firmware.</p>', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (2, N'Microsoft Office 365', N'a4998e74-51d2-4d46-add4-caaf86b537f8.png', 2500000, N'<p>Microsoft 365 is a product family of productivity software, collaboration and cloud-based services owned by Microsoft. It encompasses online services such as Outlook.com, OneDrive, Microsoft Teams, programs formerly marketed under the name Microsoft Office (including applications such as Word, Excel, PowerPoint, and Outlook on Microsoft Windows, macOS, mobile devices, and on the web), enterprise products and services associated with these products such as Exchange Server, SharePoint, and Yammer. It also covers subscription plans encompassing these products, including those that include subscription-based licenses to desktop and mobile software, and hosted email and intranet services.</p>
<p>The branding Office 365 was introduced in 2010 to refer to a subscription-based software as a service platform for the corporate market, including hosted services such as Exchange, SharePoint, and Lync Server, and Office on the web. Some plans also included licenses for the Microsoft Office 2010 software. Upon the release of Office 2013, Microsoft began to promote the service as the primary distribution model for the Microsoft Office suite, adding consumer-focused plans integrating with services such as OneDrive and Skype, and emphasizing ongoing feature updates (as opposed to non-subscription licenses, where new versions require purchase of a new license, and do not receive feature updates).</p>', 2)
INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (3, N'Grand Theft Auto V', N'9d9cbeec-999b-4818-941e-5973c777daa2.jpg', 500000, N'<p>Grand Theft Auto V is a 2013 action-adventure game developed by Rockstar North and published by Rockstar Games. It is the seventh main entry in the Grand Theft Auto series, following 2008''s Grand Theft Auto IV, and the fifteenth instalment overall. Set within the fictional state of San Andreas, based on Southern California, the single-player story follows three protagonists&mdash;retired bank robber Michael De Santa, street gangster Franklin Clinton, and drug dealer and gunrunner Trevor Philips&mdash;and their attempts to commit heists while under pressure from a corrupt government agency and powerful criminals. The open world design lets players freely roam San Andreas''s open countryside and the fictional city of Los Santos, based on Los Angeles.</p>
<p>The game is played from either a third-person or first-person perspective, and its world is navigated on foot and by vehicle. Players control the three lead protagonists throughout single-player and switch among them, both during and outside missions. The story is centred on the heist sequences, and many missions involve shooting and driving gameplay. A "wanted" system governs the aggression of law enforcement response to players who commit crimes. Grand Theft Auto Online, the game''s online multiplayer mode, lets up to 30 players engage in a variety of different cooperative and competitive game modes.</p>
<p>The game''s development began around the time of Grand Theft Auto IV''s release and was shared between many of Rockstar''s studios worldwide. The development team drew influence from many of their previous projects such as Red Dead Redemption and Max Payne 3 and designed the game around three lead protagonists to innovate on the core structure of its predecessors. Much of the development work constituted the open world''s creation, and several team members conducted field research around California to capture footage for the design team. The game''s soundtrack features an original score composed by a team of producers who collaborated over several years. Grand Theft Auto V was released in September 2013 for the PlayStation 3 and Xbox 360, in November 2014 for the PlayStation 4 and Xbox One, in April 2015 for Windows, and in March 2022 for the PlayStation 5 and Xbox Series X/S.</p>', 5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (4, N'Microsoft Office 2019 Professional Plus for Windows', N'd710e07f-54de-4f06-8946-7640ec5c85cb.jpg', 650000, N'', 2)
INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (5, N'FC 24', N'7c7b7805-c9b6-4fe3-b7ea-0bbbf06763f5.jpg', 1500000, N'<p>EA Sports FC 24 is an association football-themed simulation video game developed by EA Vancouver and EA Romania and published by EA Sports. It is the inaugural installment in the EA Sports FC series following on from the successful FIFA video game series after Electronic Arts''s partnership with FIFA concluded with FIFA 23. EA Sports FC 24 is the 31st overall installment of EA''s football simulation games, and launched worldwide on 29 September 2023 for Nintendo Switch, PlayStation 4, PlayStation 5, Windows, Xbox One, and Xbox Series X/S.</p>', 5)
INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (6, N'JetBrains All Products Pack', N'6984ad69-a871-49df-99db-b1c7fd5f54b4.jpg', 490000, N'<p>JetBrains is known as an online platform for programming languages. Launched in 2019, the platform quickly received support from users. This is considered a professional development toolkit for a variety of languages ​​and technologies. JetBrains is among the top 100 best software companies in the world providing many convenient solutions.</p>', 3)
INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (7, N' Win 10', N'fd9daa7b-e56f-48bc-982e-e9f65659b4db.png', 3500000, N'', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [Image], [Price], [Description], [Category_CategoryID]) VALUES (8, N'Code  Adobe Premiere Pro - 1 Month', N'b9ffa701-b126-4374-9a5c-4a8a72e6c0a6.jpg', 99000, N'', 3)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductKey] ON 

INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (7, 1, N'QASMK-HZFLZ-FZNUO-PZYDY-APNPT-LLAFG', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (8, 1, N'NTCHJ-TCWCF-YVFDL-MNFGV-BKMYO-DUCUK', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (9, 1, N'AZBUF-WFPAK-SWOLM-IQAOE-SROIM-KHIFJ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (10, 1, N'DFXTQ-TDFWA-FOVZE-UWRAU-AACFG-JIYZV', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (17, 2, N'QTPCU-DJRTL-WGHJU-TSKKB-HPMFG-JATRS', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (18, 2, N'AEBUR-OADZX-WMEKH-DCQCZ-RHMCZ-MUEFO', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (19, 2, N'TGYJB-ETAFC-TDSRI-OUTDC-RAUIF-GFEHO', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (20, 2, N'PDGUL-FBRBF-NLUHZ-FGNNH-DJLZK-FKUVM', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (28, 3, N'HZJGA-BDLVF-BDHIA-JVMSB-VXMMQ-DEYQG', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (29, 3, N'NMTMP-UQGLP-SWXVY-VKYFX-CXMKD-UAPDC', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (30, 3, N'NYJJV-UFWHA-TDSVX-JCWBV-KRFRN-IUDVM', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (31, 3, N'YALYN-YFMEY-SNJPS-VGGWP-HDFMQ-YZCTW', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (32, 3, N'LJKDF-CGXEO-MBOIG-AQBDU-LGVBD-CDOFJ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (33, 3, N'ZWAHK-NDDYE-AWDGZ-CTKJE-NFONO-BVZNZ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (34, 3, N'BCQPP-ATRMQ-BOBUO-TQKQE-WRBEA-HRBEB', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (35, 3, N'VLSBX-DFKPX-XVFYU-VZLDR-NQUNI-PDCQI', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (36, 3, N'VHPQT-SQEGU-FDVUM-SEBDE-BRPSN-HWIUA', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (37, 3, N'JPHTR-CHEFA-AIQOD-HMUGT-ZZYCG-RFVCX', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (38, 3, N'MAPIX-ITMJS-YJZYC-DZXRP-IJZCP-XKEPM', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (39, 3, N'GVSVA-EFEPE-TTXTZ-GLFRB-ZJQGT-AGXLQ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (44, 6, N'VDLCR-EEIJD-TXSTC-DJCAW-WWSEN-TRUVZ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (45, 6, N'WIIIO-HTAMJ-KBYQT-QFISA-GVPTT-KJMMI', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (46, 6, N'FQAVD-BUMUK-ZWSBA-UCVRA-UBTCI-IKCVL', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (47, 6, N'URXJI-CWMDH-UHCVD-IYWEV-ACEVR-UPXPE', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (48, 6, N'ARCOZ-RHDZY-HEIVI-NGGXE-BRHTE-RBCDJ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (49, 6, N'DGTRC-FQWWJ-UCPIQ-SWUSG-WZGZW-QZATW', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (50, 6, N'CXNCO-MDJDQ-HOIWQ-FXVNQ-EFHFI-LTXNK', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (51, 6, N'UMJVP-HICKP-CUGYN-QKRHX-MESZQ-CLLTK', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (52, 6, N'DPIUE-ZWWDX-WBWIQ-TXPCI-BEFGC-CRIIV', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (53, 6, N'VSDTV-HSDJZ-EQYUR-IOBRE-SMSCK-LYEDV', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (54, 6, N'PHNNP-KDVGW-FOVGY-UYMWJ-AHLEL-ZHNDA', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (55, 6, N'JLJCL-PJSCR-ZOIPF-DLTWC-TBXDS-OCHCZ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (56, 6, N'EEUHS-ZBAXI-OBLQR-YOGJB-YCTXM-WKPJB', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (57, 6, N'ZRLUY-FWULN-QDJMN-UPUFR-WCTHN-CMOGX', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (58, 6, N'ZPQWH-BFLGD-OVNDD-FXGYP-YSNJY-MRNIB', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (59, 6, N'GMKXQ-MIMVN-EXCWF-NZABQ-WWDYW-MIMKT', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (66, 5, N'CIZKK-AVKQI-LJPXV-YXOXD-NWHFY-TAKOO', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (67, 5, N'LLPZE-ZSQRE-LPDEX-MZPIN-JGNMG-LJLBV', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (68, 5, N'DHKTM-XOCKY-CHDXN-KFVAT-MBFME-LACWP', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (69, 5, N'RHMAR-UANOD-PNIRI-VWWZD-XAKXF-OSPJZ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (70, 5, N'FMFQD-UQMDG-OTGFO-FQBLN-HHSZP-UBJLJ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (75, 4, N'YUEJJ-GBRTJ-FXZRC-STHFH-VUIUN-SDABC', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (76, 4, N'LCGUD-DLNKS-CXEGL-GUGZP-OKRBX-DXOKB', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (77, 4, N'EMXYA-OQZAM-TDQUB-CXIOZ-WZUQY-ABTGF', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (78, 4, N'NNULG-WSAYW-GPHRN-DJHMI-QDZKA-CIUDO', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (79, 4, N'HCMVD-KZGIW-BOXJY-JUWKD-JUERE-NKOBQ', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (80, 4, N'TNVNX-WONNB-HHGHR-JQOTZ-WRXBF-BPEIS', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (81, 2, N'gfsndgjhnbdf', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (82, 7, N'YTMG3-N6DKC-DKB77-7M9GH-8HVX7', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (83, 7, N'BT79Q-G7N6G-PGBYW-4YWX6-6F4BT', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (84, 7, N'TX9XD-98N7V-6WMQ6-BX7FG-H8Q99', NULL, 0)
INSERT [dbo].[ProductKey] ([KeyID], [Product_ProductID], [ProductKey], [ExpirationDate], [isExpired]) VALUES (85, 7, N'3KHY7-WNT83-DGQKR-F7HPR-844BM', NULL, 0)
SET IDENTITY_INSERT [dbo].[ProductKey] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Customer')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Admin')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Cuong', N'Manh', N'abc123', N'5d86abf285a048a4fb8b2f9070382b83f0528c0b3314b9aedc057c5147362101', N'taaaa@gmail.com', 1, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Cuong', N'Manh', N'abc1231111', N'5d86abf285a048a4fb8b2f9070382b83f0528c0b3314b9aedc057c5147362101', N'taaaa@gmail.com', 1, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Admin', N'Cuong', N'admin', N'bdd4469e2c051f30b8dc7017e98b9727c1f3f52612489474bab407090cbc51c4', N'cuongnmhe172187@fpt.edu.vn', 2, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Tran', N'Hiep', N'hieptv', N'4f44241bdafb4b5be99f5a60a4b524b74afb572e2d998a8153b411ba8c779478', N'cuongnmhe172187@fpt.edu.vn', 1, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Cuong', N'Viet', N'mra123', N'bdd4469e2c051f30b8dc7017e98b9727c1f3f52612489474bab407090cbc51c4', N'cuongnmhe1721871@fpt.edu.vn', 1, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Thai', N'Huu', N'thaihuu', N'bdd4469e2c051f30b8dc7017e98b9727c1f3f52612489474bab407090cbc51c4', N'cuong2k31111@gmail.com', 1, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Cuong', N'Cuong', N'tranhiwp', N'2769112f253df4764a72cb026d5f3a11d237e4c4435b3f385a14054d6be903fe', N'cuongnmhe172187@fpt.edu.vn', 1, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'Cuong', N'Manh', N'user2', N'6ae844ef094a3fbf51c02b1d1f9abdf5704d83912cc3da37b05e2864ec847036', N'cuongnmhe172187@fpt.edu.vn', 1, 0, 1)
INSERT [dbo].[User] ([FirstName], [LastName], [Username], [Password], [Email], [Role_RoleID], [IsVerified], [IsActive]) VALUES (N'aaaaa', N'aaaaaaaaaaa', N'user3', N'6dcd679a2dff9108b13d2f9513675eff63994882dc0c794fa9501e2b17808558', N'cuongnmhe172187@fpt.edu.vn', 1, 0, 1)
GO
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'abc123', 0)
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'abc1231111', 0)
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'hieptv', 1095500000)
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'mra123', 0)
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'thaihuu', 0)
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'tranhiwp', 0)
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'user2', 99999998387524944)
INSERT [dbo].[UserBalance] ([User_Username], [Amount]) VALUES (N'user3', 0)
GO
ALTER TABLE [dbo].[BalanceHistory]  WITH CHECK ADD  CONSTRAINT [BalanceHistory_HE172187_User_HE172187] FOREIGN KEY([User_Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[BalanceHistory] CHECK CONSTRAINT [BalanceHistory_HE172187_User_HE172187]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [Cart_HHE172187_User_HE172187] FOREIGN KEY([User_Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [Cart_HHE172187_User_HE172187]
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD  CONSTRAINT [CartItem_HE172187_Cart_HE172187] FOREIGN KEY([User_Username])
REFERENCES [dbo].[Cart] ([User_Username])
GO
ALTER TABLE [dbo].[CartItem] CHECK CONSTRAINT [CartItem_HE172187_Cart_HE172187]
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD  CONSTRAINT [CartItem_HE172187_Product_HE172187] FOREIGN KEY([Product_ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[CartItem] CHECK CONSTRAINT [CartItem_HE172187_Product_HE172187]
GO
ALTER TABLE [dbo].[DepositHistory]  WITH CHECK ADD  CONSTRAINT [DepositRequest_HE172187_User_HE172187] FOREIGN KEY([User_Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[DepositHistory] CHECK CONSTRAINT [DepositRequest_HE172187_User_HE172187]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [OrderDetail_HE172187_OrderHistory_HE172187] FOREIGN KEY([OrderHistory_OrderID])
REFERENCES [dbo].[OrderHistory] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [OrderDetail_HE172187_OrderHistory_HE172187]
GO
ALTER TABLE [dbo].[OrderHistory]  WITH CHECK ADD  CONSTRAINT [OrderHistory_HE172187_User_HE172187] FOREIGN KEY([User_Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[OrderHistory] CHECK CONSTRAINT [OrderHistory_HE172187_User_HE172187]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([Category_CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[ProductKey]  WITH CHECK ADD  CONSTRAINT [FK_ProductKey_Product] FOREIGN KEY([Product_ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductKey] CHECK CONSTRAINT [FK_ProductKey_Product]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [User_Role] FOREIGN KEY([Role_RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [User_Role]
GO
ALTER TABLE [dbo].[UserBalance]  WITH CHECK ADD  CONSTRAINT [UserBalance_HE172187_User_HE172187] FOREIGN KEY([User_Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[UserBalance] CHECK CONSTRAINT [UserBalance_HE172187_User_HE172187]
GO
