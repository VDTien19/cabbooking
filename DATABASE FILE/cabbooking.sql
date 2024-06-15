-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 14, 2024 lúc 06:09 PM
-- Phiên bản máy phục vụ: 8.4.0
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cabbooking`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_list`
--

CREATE TABLE `booking_list` (
  `id` int NOT NULL,
  `ref_code` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `client_id` int NOT NULL,
  `cab_id` int NOT NULL,
  `pickup_zone` text COLLATE utf8mb4_general_ci NOT NULL,
  `drop_zone` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0 = Pending,\r\n1 = Driver has Confirmed,\r\n2 = Pickup,\r\n3 = drop-off,\r\n4 = cancelled',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `booking_list`
--

INSERT INTO `booking_list` (`id`, `ref_code`, `client_id`, `cab_id`, `pickup_zone`, `drop_zone`, `status`, `date_created`, `date_updated`) VALUES
(25, '202406-00001', 18, 6, 'Khánh Vân', 'Hà Nội', 4, '2024-06-09 00:46:44', '2024-06-09 10:12:23'),
(26, '202406-00002', 18, 2, 'Đại học Thăng Long', 'Hà Đông', 4, '2024-06-10 15:27:09', '2024-06-10 15:58:28'),
(27, '202406-00002', 18, 2, 'Khánh Vân', 'Hà Nội', 4, '2024-06-10 15:59:00', '2024-06-10 16:12:33'),
(28, '202406-00002', 18, 10, 'Hà Nội', 'TP.HCM\r\n', 4, '2024-06-10 16:09:43', '2024-06-10 16:13:47'),
(29, '202406-00002', 20, 5, 'Thái Bình', 'Hà Nội', 3, '2024-06-11 10:46:14', '2024-06-14 09:25:55'),
(30, '202406-00002', 18, 6, 'Hà Nội', 'Đà Nẵng', 3, '2024-06-14 09:29:06', '2024-06-14 09:29:49'),
(31, '202406-00005', 18, 18, 'Hà Nội', 'HCM', 3, '2024-06-14 12:13:56', '2024-06-14 17:43:14');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cab_list`
--

CREATE TABLE `cab_list` (
  `id` int NOT NULL,
  `reg_code` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int NOT NULL,
  `cab_reg_no` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `body_no` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `cab_model` text COLLATE utf8mb4_general_ci NOT NULL,
  `price` int NOT NULL,
  `cab_driver` text COLLATE utf8mb4_general_ci NOT NULL,
  `driver_contact` text COLLATE utf8mb4_general_ci NOT NULL,
  `driver_address` text COLLATE utf8mb4_general_ci NOT NULL,
  `password` text COLLATE utf8mb4_general_ci NOT NULL,
  `image_path` text COLLATE utf8mb4_general_ci,
  `image_car` text COLLATE utf8mb4_general_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cab_list`
--

INSERT INTO `cab_list` (`id`, `reg_code`, `category_id`, `cab_reg_no`, `body_no`, `cab_model`, `price`, `cab_driver`, `driver_contact`, `driver_address`, `password`, `image_path`, `image_car`, `status`, `delete_flag`, `date_created`, `date_updated`) VALUES
(1, '202202-00002', 1, '18B - 987.65', 'Fusion-130', 'Ford Fusion', 10000, 'Ngô Bá Khá', '091234567', 'Quảng Ninh', '1a429989249392a7d291e9f7891350f3', 'uploads/dirvers/1.png?v=1644981064', 'uploads/cabs/1718361360_fusion130.jpg', 1, 0, '2022-03-02 10:59:12', '2024-06-14 21:22:43'),
(2, '202202-00001', 2, '29H - 192.03', 'Camry-440', 'Toyota Camry', 12000, 'Nguyễn Văn Bình', '094569871', 'Hà Nội', '1a429989249392a7d291e9f7891350f3', 'uploads/1718331480_1.png', 'uploads/cabs/1718361300_camry440.jpg', 1, 0, '2022-03-02 11:13:30', '2024-06-14 18:00:17'),
(3, '202203-00001', 1, '36A - 394.92', 'Prius-1010', 'Toyota Prius', 11000, 'Duy Henry', '0839283923', 'Lào Cai', '1a429989249392a7d291e9f7891350f3', 'uploads/dirvers/3.png?v=1648051050', 'uploads/cabs/1718361420_toyoytaprius.png', 1, 0, '2022-03-02 21:42:30', '2024-06-14 21:23:10'),
(4, '202203-00002', 1, '30H - 839.72', 'Soul-009', 'Kia Soul', 11000, 'Bùi Xuân Huấn', '7896478540', 'Bắc Ninh', '1a429989249392a7d291e9f7891350f3', NULL, 'uploads/cabs/1718361420_kiasoul.jpg', 1, 0, '2022-03-02 21:59:17', '2024-06-14 21:25:28'),
(5, '202203-00003', 1, '88G - 832.82', 'Civic-7781', 'Honda Civic', 12500, 'Đỗ Nam Trung', '7895410000', '56 Hai Bà Trưng\r\n', '1a429989249392a7d291e9f7891350f3', 'uploads/1718331960_tải xuống (1).jpg', 'uploads/cabs/1718361480_hondacivic.jpg', 1, 0, '2022-03-02 22:06:47', '2024-06-14 21:23:47'),
(6, '202203-00004', 2, '35C - 123.45', 'ESV-7700', 'Cadillac Escalade ESV', 11500, 'Nam Cường', '7850001010', 'Hà Nam', '1a429989249392a7d291e9f7891350f3', 'uploads/dirvers/6.png?v=1648311872', 'uploads/cabs/1718361480_cadilac.jpg', 1, 0, '2022-03-02 22:09:32', '2024-06-14 21:24:49'),
(7, '202203-00005', 1, '30T - 419.75', 'iTen-1010', 'Hyundai i10', 11000, 'Phan Bảo Nam', '4785478500', 'Hà Tĩnh', '1a429989249392a7d291e9f7891350f3', 'uploads/dirvers/7.png?v=1648312063', 'uploads/cabs/1718361540_huyndai10.jpg', 1, 0, '2022-03-02 22:12:43', '2024-06-14 21:26:24'),
(8, '202203-00006', 1, '63H - 666.66', 'Skoda-162TSI', 'Skoda Superb 162TSI', 11000, 'Vũ Đức Đam', '2547854444', 'Ninh Bình', '1a429989249392a7d291e9f7891350f3', NULL, 'uploads/cabs/1718361540_skoda.png', 1, 0, '2022-03-02 22:16:57', '2024-06-14 21:38:15'),
(9, '202203-00007', 1, '35A - 999.99', 'Picanto-7785', 'Kia Picanto', 11500, 'Alexandro Tiến', '4558889850', 'Hà Giang', '1a429989249392a7d291e9f7891350f3', NULL, 'uploads/cabs/1718361540_kiapicanto.png', 1, 0, '2022-03-02 22:18:41', '2024-06-14 21:38:28'),
(10, '202203-00008', 3, '17H - 555.55', 'Galaxy-7777', 'Ford Galaxy', 12500, 'Trần Văn Bôn', '2589654570', 'Bắc Giang', '1a429989249392a7d291e9f7891350f3', NULL, 'uploads/cabs/1718361540_fordgalaxy.jpg', 1, 0, '2022-03-02 13:00:24', '2024-06-14 21:39:47'),
(15, '202406-00001', 2, '35A - 782.45', 'Attrage- 2024', 'Mitsubishi Atrage', 10000, 'Vũ Đức Tiến', '09422852933', 'Ninh Bình', '1a429989249392a7d291e9f7891350f3', NULL, 'uploads/cabs/1718361600_mitsubishiattrage.jpg', 1, 0, '2024-06-09 09:46:23', '2024-06-14 21:40:05'),
(16, '202406-00002', 2, '21A - 234.56', 'Mercerdesc S650', 'Mercerdesc S650', 20000, 'Nguyễn Văn Bôn', '0243423423', 'Hà Nội', '1a429989249392a7d291e9f7891350f3', 'uploads/1718338860_avt.png', 'uploads/cabs/1718361600_mercs650.jpg', 1, 0, '2024-06-14 11:20:04', '2024-06-14 21:40:19'),
(17, '202406-00003', 3, '35A - 782.98', 'Phúc Hưng', 'Mercerdesc S650', 20000, 'Hưng Donal', '0342343742', 'Quảng Bình', '1a429989249392a7d291e9f7891350f3', 'uploads/1718339820_logo_avt.jpg', 'uploads/cabs/1718361600_mercs6502.jpg', 1, 0, '2024-06-14 11:26:07', '2024-06-14 21:40:31'),
(18, '202406-00004', 3, '98H - 394.97', 'Merc S450', 'Mercerdesc S450', 18000, 'Lê Văn Luyện', '0242342354', 'Bắc Giang', '1a429989249392a7d291e9f7891350f3', 'uploads/dirvers/1718340360_avt.png', 'uploads/cabs/1718361660_mercs450.jpg', 1, 0, '2024-06-14 11:45:19', '2024-06-14 21:40:46'),
(20, '202406-00005', 3, '17B - 928.26', 'Ford Ranger', 'Ford Ranger', 14000, 'Đỗ Trung Kiên', '0273282332', 'Thái Bình', '1a429989249392a7d291e9f7891350f3', NULL, 'uploads/cabs/1718361660_fordranger.jpg', 1, 0, '2024-06-14 17:22:22', '2024-06-14 21:41:02'),
(21, '202203-00002', 1, '30H - 839.72', 'Soul-009', 'Kia Soul', 11000, 'Bùi Xuân Huấn', '7896478540', 'Bắc Ninh', '1a429989249392a7d291e9f7891350f3', NULL, 'uploads/cabs/1718361420_kiasoul.jpg', 1, 0, '2022-03-02 21:59:17', '2024-06-14 17:37:43');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category_list`
--

CREATE TABLE `category_list` (
  `id` int NOT NULL,
  `name` text COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `category_list`
--

INSERT INTO `category_list` (`id`, `name`, `description`, `delete_flag`, `status`, `date_created`, `date_updated`) VALUES
(1, '5 chỗ', 'D&ograve;ng xe 5 chỗ của ch&uacute;ng t&ocirc;i bao gồm c&aacute;c mẫu như Hyundai Kona, Honda HR-V v&agrave; Mazda CX-3. Những chiếc xe n&agrave;y c&oacute; k&iacute;ch thước nhỏ gọn, vận h&agrave;nh linh hoạt v&agrave; tiết kiệm nhi&ecirc;n liệu, rất ph&ugrave; hợp di chuyển trong th&agrave;nh phố. Ch&uacute;ng t&ocirc;i đảm bảo xe lu&ocirc;n sạch sẽ, an to&agrave;n v&agrave; thoải m&aacute;i cho kh&aacute;ch.', 0, 1, '2022-03-01 10:03:54', '2024-06-09 09:52:17'),
(2, '6 chỗ', 'D&ograve;ng xe 6 chỗ như Mitsubishi Xpander v&agrave; Suzuki Ertiga. Những chiếc xe n&agrave;y c&oacute; k&iacute;ch thước lớn hơn xe 5 chỗ, nhưng vẫn di chuyển linh hoạt trong th&agrave;nh phố. Đ&acirc;y l&agrave; lựa chọn ph&ugrave; hợp cho gia đ&igrave;nh c&oacute; 5-6 th&agrave;nh vi&ecirc;n.', 0, 1, '2022-03-01 10:08:10', '2024-06-09 09:52:11'),
(3, '7 chỗ', 'D&ograve;ng xe 7 chỗ của ch&uacute;ng t&ocirc;i bao gồm Toyota Innova, Honda Odyssey v&agrave; Hyundai Santa Fe. Những mẫu xe n&agrave;y rộng r&atilde;i, c&oacute; 3 h&agrave;ng ghế, c&oacute; thể chở được nhiều h&agrave;nh kh&aacute;ch c&ugrave;ng nhiều h&agrave;nh l&yacute;. Ch&uacute;ng rất th&iacute;ch hợp cho c&aacute;c gia đ&igrave;nh hoặc những chuyến đi xa.', 0, 1, '2022-03-03 12:59:29', '2024-06-09 09:52:02');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `client_list`
--

CREATE TABLE `client_list` (
  `id` int NOT NULL,
  `firstname` text COLLATE utf8mb4_general_ci NOT NULL,
  `middlename` text COLLATE utf8mb4_general_ci,
  `lastname` text COLLATE utf8mb4_general_ci NOT NULL,
  `gender` text COLLATE utf8mb4_general_ci NOT NULL,
  `contact` text COLLATE utf8mb4_general_ci NOT NULL,
  `address` text COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` text COLLATE utf8mb4_general_ci NOT NULL,
  `image_path` text COLLATE utf8mb4_general_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_added` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `client_list`
--

INSERT INTO `client_list` (`id`, `firstname`, `middlename`, `lastname`, `gender`, `contact`, `address`, `email`, `password`, `image_path`, `status`, `delete_flag`, `date_created`, `date_added`) VALUES
(18, 'Vũ', 'Đức', 'Tiến', 'Nam', '0942852933', 'xóm 5, Vân Tiến\r\nYên Khánh', 'vuductientienti@gmail.com', '1a429989249392a7d291e9f7891350f3', 'uploads/clients/1718341860_logo_avt.jpg', 1, 0, '2024-06-09 00:45:22', '2024-06-14 12:11:05'),
(19, 'Vũ', '', 'Tiến', 'Nam', '0942852933', 'xóm 5, Vân Tiến\r\nYên Khánh', 'vu_duc_tien@outlook.com.vn', 'e10adc3949ba59abbe56e057f20f883e', NULL, 1, 0, '2024-06-10 15:47:53', NULL),
(20, 'Phạm', 'Bảo ', 'Nguyên', 'Nam', '0839274829', 'Thái Bình', 'pbn@gmail.com', '6e97123d7be0c38c111ff6d7d6b274cd', NULL, 1, 0, '2024-06-11 10:45:07', NULL),
(21, 'Vũ', '', 'Tiến', 'Nam', '1234567890', 'xóm 5, Vân Tiến\r\nYên Khánh', 'tienne@gmail.com', '1a429989249392a7d291e9f7891350f3', NULL, 1, 0, '2024-06-12 10:43:44', NULL),
(22, 'Vũ', '', 'Tiến', 'Nam', '0839274829', 'Van Dien', 'tien1@gmail.com', '1a429989249392a7d291e9f7891350f3', NULL, 1, 0, '2024-06-12 10:54:02', NULL),
(23, 'Phạm', '', 'Nguyên', 'Male', '0123456788', 'Van Dien', 'nguyen1@gmail.com', '27ff2ffe376b2edcc7c2de309173f0d8', NULL, 1, 0, '2024-06-12 11:07:10', '2024-06-14 23:07:26'),
(24, 'Vũ', '', 'Tiến', 'Nam', '234567890', 'xóm 5, Vân Tiến\r\nYên Khánh', 'tran.pdung.204@gmail.com', '1a429989249392a7d291e9f7891350f3', NULL, 1, 0, '2024-06-13 09:33:57', NULL),
(25, 'Vũ', '', 'Tiến', 'Male', '034567891', 'xóm 5, Vân Tiến\r\nYên Khánh', 'tientienti@gmail.com', '1a429989249392a7d291e9f7891350f3', 'uploads/1718249220_1633049820_avatar3.png', 1, 0, '2024-06-13 10:27:14', '2024-06-13 10:36:12'),
(26, 'Vũ', '', 'Tiến', 'Male', '0235235323', 'Van Dien', 'tienni@gmail.com', '1a429989249392a7d291e9f7891350f3', 'uploads/1718268600_1633049820_avatar3.png', 1, 0, '2024-06-13 15:50:08', '2024-06-14 23:06:11'),
(29, 'Vũ', '', 'Tiến', 'Nam', '0987654321', 'xóm 5, Vân Tiến\r\nYên Khánh', 'tienti@gmail.com', '1a429989249392a7d291e9f7891350f3', 'uploads/1718272260_409105750_784779980339093_33913091246728177_n.jpg', 1, 0, '2024-06-13 15:58:19', '2024-06-13 16:51:01'),
(36, 'Vũ', '', 'Tiến', 'Nam', '1234567890', 'Van Dien', 'tinne@gmail.com', '1a429989249392a7d291e9f7891350f3', NULL, 1, 0, '2024-06-13 17:45:36', NULL),
(37, 'Vũ', '', 'Tiến', 'Male', '02348234322', 'xóm 5, Vân Tiến\r\nYên Khánh', 'ttt@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', NULL, 1, 0, '2024-06-13 17:46:51', '2024-06-14 23:08:06'),
(38, 'Vũ', '', 'Tiến', 'Nam', '5858998008', 'Van Dien', 't123@gmail.com', 'fcea920f7412b5da7be0cf42b8c93759', NULL, 1, 0, '2024-06-13 17:47:43', NULL),
(39, 'Vũ', '', 'Tiến', 'Nam', '1234567890', 'xóm 5, Vân Tiến\r\nYên Khánh', 'tien89@gmail.com', 'fcea920f7412b5da7be0cf42b8c93759', NULL, 1, 0, '2024-06-13 17:49:39', NULL),
(40, 'Vũ', '', 'Tiến', 'Nam', '14567807', 'xóm 5, Vân Tiến\r\nYên Khánh', 'hhe@gmail.com', 'fcea920f7412b5da7be0cf42b8c93759', NULL, 1, 0, '2024-06-13 17:51:08', NULL),
(41, 'Vũ', 'Bảo ', 'Tiến', 'Nam', '0343649134', 'Van Dien', 'ThanhXuanAnhVaEm.2k3@hotmail.com', 'fcea920f7412b5da7be0cf42b8c93759', NULL, 1, 0, '2024-06-13 17:53:44', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `system_info`
--

CREATE TABLE `system_info` (
  `id` int NOT NULL,
  `meta_field` text COLLATE utf8mb4_general_ci NOT NULL,
  `meta_value` text COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Cab Booking System'),
(6, 'short_name', 'CabBooking'),
(11, 'logo', 'uploads/1718276280_cabicon.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/1718164200_cover.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `firstname` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `lastname` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `username` text COLLATE utf8mb4_general_ci NOT NULL,
  `password` text COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` text COLLATE utf8mb4_general_ci,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Admin', 'Tiến', 'admin', '1a429989249392a7d291e9f7891350f3', 'uploads/1624000_adminicn.png', NULL, 1, '2022-01-19 14:02:37', '2024-06-09 09:43:30'),
(8, 'Phạm Bảo', 'Nguyên', 'nguyen_staff', '1a429989249392a7d291e9f7891350f3', 'uploads/avatar-8.png?v=1648396920', NULL, 2, '2022-03-01 16:14:00', '2024-06-09 09:55:41'),
(9, 'Đỗ Trung', 'Kiên', 'kien_staff', '1a429989249392a7d291e9f7891350f3', 'uploads/avatar-9.png?v=1648396901', NULL, 2, '2022-03-27 21:46:41', '2024-06-09 09:54:46'),
(10, 'Nguyễn', 'Hoàng Dũng', 'dung_staff', '1a429989249392a7d291e9f7891350f3', NULL, NULL, 2, '2024-06-13 10:15:20', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `booking_list`
--
ALTER TABLE `booking_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cab_id` (`cab_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Chỉ mục cho bảng `cab_list`
--
ALTER TABLE `cab_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `category_list`
--
ALTER TABLE `category_list`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `client_list`
--
ALTER TABLE `client_list`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Chỉ mục cho bảng `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `booking_list`
--
ALTER TABLE `booking_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `cab_list`
--
ALTER TABLE `cab_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `category_list`
--
ALTER TABLE `category_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `client_list`
--
ALTER TABLE `client_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT cho bảng `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `booking_list`
--
ALTER TABLE `booking_list`
  ADD CONSTRAINT `booking_list_ibfk_1` FOREIGN KEY (`cab_id`) REFERENCES `cab_list` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_list_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client_list` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `cab_list`
--
ALTER TABLE `cab_list`
  ADD CONSTRAINT `cab_list_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_list` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
