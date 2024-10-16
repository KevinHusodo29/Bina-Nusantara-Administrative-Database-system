-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2023 at 05:44 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `administrasi_binus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `transfer_student_to_department` (`student_nim` CHAR(10), `target_department_code` CHAR(10))   BEGIN
    UPDATE binus_mahasiswa
    SET Jurusan_Kode = target_department_code
    WHERE Mahasiswa_NIM = student_nim;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_student_status` (`student_nim` VARCHAR(20), `new_status` VARCHAR(10))   BEGIN
    UPDATE binus_administrasi
    SET Mahasiswa_status = new_status
    WHERE Mahasiswa_NIM = student_nim;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `count_students_by_nim_prefix` (`prefix` CHAR(2)) RETURNS INT(11)  BEGIN
    DECLARE student_count INT;

    SELECT COUNT(*) INTO student_count
    FROM binus_mahasiswa
    WHERE SUBSTRING(Mahasiswa_NIM, 1, 2) = prefix;

    RETURN student_count;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_courses_in_faculty` (`faculty_code` VARCHAR(10)) RETURNS INT(11)  BEGIN
    DECLARE course_count INT;

    SELECT COUNT(*) INTO course_count
    FROM binus_matakuliah
    JOIN binus_jurusan ON binus_matakuliah.Jurusan_Kode = binus_jurusan.Jurusan_Kode
    WHERE binus_jurusan.Fakultas_kode = faculty_code;

    RETURN course_count;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `binus_administrasi`
--

CREATE TABLE `binus_administrasi` (
  `Mahasiswa_NIM` char(12) NOT NULL,
  `Mahasiswa_Status` char(10) NOT NULL
) ;

--
-- Dumping data for table `binus_administrasi`
--

INSERT INTO `binus_administrasi` (`Mahasiswa_NIM`, `Mahasiswa_Status`) VALUES
('2301123456', 'PAID'),
('2310987654', 'Paid'),
('2408765432', 'Upcoming'),
('2412345678', 'Unpaid'),
('2509876543', 'Paid'),
('2512345678', 'Unpaid'),
('2609876543', 'Paid'),
('2612345678', 'Paid'),
('2712345678', 'Unpaid'),
('2701234567', 'Upcoming'),
('2323456789', 'Paid'),
('2423456789', 'Upcoming'),
('2523456789', 'Paid'),
('2623456789', 'Paid'),
('2723456789', 'Unpaid'),
('2334567890', 'Unpaid'),
('2434567890', 'Upcoming'),
('2534567890', 'Upcoming'),
('2634567890', 'Upcoming'),
('2734567890', 'Paid');

-- --------------------------------------------------------

--
-- Table structure for table `binus_fakultas`
--

CREATE TABLE `binus_fakultas` (
  `Fakultas_Kode` char(10) NOT NULL,
  `Fakultas_Nama` varchar(50) NOT NULL
) ;

--
-- Dumping data for table `binus_fakultas`
--

INSERT INTO `binus_fakultas` (`Fakultas_Kode`, `Fakultas_Nama`) VALUES
('FD', 'Fakultas Desain'),
('FEK', 'Fakultas Ekonomika dan Komunikasi'),
('FH', 'Fakultas Humaniora'),
('FSBM', 'Sekolah Bisnis dan Manajemen'),
('FSI', 'Fakultas Sistem Informasi'),
('FT', 'Fakultas Teknik'),
('FTI', 'Fakultas Teknik Informatika');

-- --------------------------------------------------------

--
-- Table structure for table `binus_hargasks`
--

CREATE TABLE `binus_hargasks` (
  `MatKul_Kode` char(4) NOT NULL,
  `Harga_SKS` int(10) NOT NULL,
  `Harga_Total` int(10) NOT NULL
) ;

--
-- Dumping data for table `binus_hargasks`
--

INSERT INTO `binus_hargasks` (`MatKul_Kode`, `Harga_SKS`, `Harga_Total`) VALUES
('123A', 200000, 400000),
('124B', 250000, 750000),
('125C', 100000, 400000),
('126D', 300000, 600000),
('127E', 150000, 450000),
('128F', 350000, 1050000),
('129G', 175000, 700000),
('130H', 200000, 400000),
('131I', 225000, 450000),
('132J', 300000, 600000),
('133K', 100000, 400000),
('134L', 125000, 500000),
('135M', 350000, 1050000);

-- --------------------------------------------------------

--
-- Table structure for table `binus_jurusan`
--

CREATE TABLE `binus_jurusan` (
  `Jurusan_Kode` char(10) NOT NULL,
  `Fakultas_kode` char(10) NOT NULL,
  `Kampus_Kode` char(10) NOT NULL,
  `Jurusan_Nama` varchar(50) NOT NULL
) ;

--
-- Dumping data for table `binus_jurusan`
--

INSERT INTO `binus_jurusan` (`Jurusan_Kode`, `Fakultas_kode`, `Kampus_Kode`, `Jurusan_Nama`) VALUES
('ACC', 'FEK', '292', 'Akuntansi'),
('ARS', 'FT', '327', 'Arsitektur'),
('ARS', 'FT', '356', 'Arsitektur'),
('CS', 'FTI', '292', 'Cyber Security'),
('CS', 'FTI', '315', 'Cyber Security'),
('CS', 'FTI', '327', 'Cyber Security'),
('DI', 'FD', '327', 'Desain Interior'),
('DKV', 'FD', '315', 'Desain Komunikasi Visual Animasi'),
('DKV', 'FD', '339', 'Desain Komunikasi Visual Animasi'),
('HI', 'FH', '315', 'Hubungan Internasional'),
('IF', 'FTI', '292', 'Teknik Informatika'),
('IF', 'FTI', '315', 'Teknik Informatika'),
('IF', 'FTI', '327', 'Teknik Informatika'),
('IF', 'FTI', '339', 'Teknik Informatika'),
('IF', 'FTI', '342', 'Teknik Informatika'),
('IF', 'FTI', '356', 'Teknik Informatika'),
('MGT', 'FSBM', '356', 'Manajemen'),
('PSI', 'FH', '356', 'Psikologi'),
('SE', 'FH', '292', 'Sastra Inggris'),
('SE', 'FH', '356', 'Sastra Inggris'),
('SI', 'FSI', '342', 'Sistem Informasi'),
('TI', 'FT', '292', 'Teknik Industri'),
('TI', 'FT', '315', 'Teknik Industri'),
('TKOM', 'FT', '292', 'Teknik Komputer'),
('TKOM', 'FT', '327', 'Teknik Komputer'),
('TKOM', 'FT', '339', 'Teknik Komputer'),
('TKOM', 'FT', '342', 'Teknik Komputer');

-- --------------------------------------------------------

--
-- Table structure for table `binus_kampus`
--

CREATE TABLE `binus_kampus` (
  `Kampus_Kode` char(5) NOT NULL,
  `Kampus_Nama` varchar(50) NOT NULL,
  `Kampus_Alamat` varchar(50) NOT NULL,
  `Kampus_NoTelp` char(15) NOT NULL
) ;

--
-- Dumping data for table `binus_kampus`
--

INSERT INTO `binus_kampus` (`Kampus_Kode`, `Kampus_Nama`, `Kampus_Alamat`, `Kampus_NoTelp`) VALUES
('292', 'Binus @Kemanggisan', 'Jl. K.H. Syahdan No. 9, Kemanggisan, Jakarta Barat', '215345830'),
('315', 'Binus @Semarang', 'Gedung Griya Bina Artha (Gedung Bank BPD Jateng) L', '243569090'),
('327', 'Binus @Bandung', 'Jl. Pasirkaliki No. 25-27, Paskal Hyper Square, Ba', '2220568888'),
('339', 'Binus @Malang', 'Araya Mansion No. 8-22 Pandanwangi, Blimbing, Mala', '3413036969'),
('342', 'Binus @Bekasi', 'Jl. Lingkar Bulevar Blok WA No. 1, Summarecon Beka', '2182424949'),
('356', 'Binus @Alam Sutera', 'Jl. Alam Sutera Boulevard No. 1, Alam Sutera, Tang', '2153696919');

-- --------------------------------------------------------

--
-- Table structure for table `binus_mahasiswa`
--

CREATE TABLE `binus_mahasiswa` (
  `Mahasiswa_NIM` char(12) NOT NULL,
  `Mahasiswa_Nama` varchar(50) NOT NULL,
  `Mahasiswa_gender` varchar(10) NOT NULL,
  `Mahasiswa_DOB` date NOT NULL,
  `Mahasiswa_TempatTanggalLahir` varchar(50) NOT NULL,
  `Mahasiswa_Alamat` varchar(50) NOT NULL,
  `Mahasiswa_NoTelp` char(15) NOT NULL,
  `Mahasiswa_Email` varchar(50) NOT NULL,
  `Jurusan_Kode` char(10) NOT NULL
) ;

--
-- Dumping data for table `binus_mahasiswa`
--

INSERT INTO `binus_mahasiswa` (`Mahasiswa_NIM`, `Mahasiswa_Nama`, `Mahasiswa_gender`, `Mahasiswa_DOB`, `Mahasiswa_TempatTanggalLahir`, `Mahasiswa_Alamat`, `Mahasiswa_NoTelp`, `Mahasiswa_Email`, `Jurusan_Kode`) VALUES
('2301123456', 'Andika Pratama', 'male', '1995-02-05', 'Jakarta', 'Jl. Merdeka No. 123, Jakarta Barat', '81576473461', 'Andika.Pratama@binus.ac.id', 'DKV'),
('2310987654', 'Rina Sari', 'Female', '1998-05-12', 'Bandung', 'Jl. Pahlawan No. 45, Bandung', '81679640867', 'Rina.Sari@binus.ac.id', 'ARS'),
('2323456789', 'Nia Amelia', 'Female', '1999-02-20', 'Balikpapan', 'Jl. Imam Bonjol No. 45, Balikpapan', '81669267557', 'Nia.Amelia@binus.ac.id', 'IF'),
('2334567890', 'Hendra Wijaya', 'Male', '1994-11-02', 'Ambon', 'Jl. Pattimura No. 23, Ambon', '81766823340', 'Hendra.Wijaya@binus.ac.id', 'SI'),
('2408765432', 'Budi Santoso', 'Male', '1992-07-18', 'Surabaya', 'Jl. Mawar Indah No. 67, Surabaya', '81704969213', 'Budi.Santoso@binus.ac.id', 'ARS'),
('2412345678', 'Dian Purnama', 'Female', '1996-09-03', 'Yogyakarta', 'Jl. Diponegoro No. 89, Yogyakarta', '81222415503', 'Dian.Purnama@binus.ac.id', 'TI'),
('2423456789', 'Rizki Fauzi', 'Male', '1993-03-08', 'Pekanbaru', 'Jl. Ahmad Yani No. 89, Pekanbaru', '81501299930', 'Rizki.Fauzi@binus.ac.id', 'CS'),
('2434567890', 'Eka Saputra', 'Female', '1998-01-10', 'Pontianak', 'Jl. Tanjungpura No. 67, Pontianak', '81638236765', 'Eka.Saputra@binus.ac.id', 'MGT'),
('2509876543', 'Galuh Wijaya', 'Male', '1990-11-21', 'Malang', 'Jl. Cendrawasih No. 34, Malang', '81950359074', 'Galuh.Wijaya@binus.ac.id', 'TI'),
('2512345678', 'Aditya Nugraha', 'Male', '1994-04-07', 'Medan', 'Jl. Sisingamangaraja No. 56, Medan', '81718210275', 'Aditya.Nugraha@binus.ac.id', 'TKOM'),
('2523456789', 'Dewi Permata', 'Female', '1997-05-25', 'Banjarmasin', 'Jl. A. Yani No. 34, Banjarmasin', '81492068593', 'Dewi.Permata@binus.ac.id', 'CS'),
('2534567890', 'Lina Puspita', 'Female', '1992-03-16', 'Jayapura', 'Jl. Abepura No. 12, Jayapura', '81664629537', 'Lina.Puspita@binus.ac.id', 'HI'),
('2609876543', 'Siti Rahayu', 'Female', '1997-06-15', 'Semarang', 'Jl. Slamet Riyadi No. 78, Semarang', '81913271594', 'Siti.Rahayu@binus.ac.id', 'TKOM'),
('2612345678', 'Irfan Maulana', 'Male', '1993-08-09', 'Makassar', 'Jl. Pettarani No. 23, Makassar', '81715967371', 'Irfan.Maulana@binus.ac.id', 'IF'),
('2623456789', 'Ahmad Rizal', 'Male', '1995-07-11', 'Padang', 'Jl. M. H. Thamrin No. 56, Padang', '81372966782', 'Ahmad.Rizal@binus.ac.id', 'DI'),
('2634567890', 'Bayu Kurniawan', 'Male', '1996-04-22', 'Mataram', 'Jl. Panji Suroso No. 34, Mataram', '81636997512', 'Bayu.Kurniawan@binus.ac.id', 'PSI'),
('2701234567', 'Faisal Ramadhan', 'Male', '1991-12-14', 'Denpasar', 'Jl. Gatot Subroto No. 67, Denpasar', '81139868376', 'Faisal.Ramadhan@binus.ac.id', 'IF'),
('2712345678', 'Maya Fitriani', 'Female', '1989-10-26', 'Palembang', 'Jl. Sudirman No. 12, Palembang', '81454714974', 'Maya.Fitriani@binus.ac.id', 'IF'),
('2723456789', 'Sari Utami', 'Female', '1990-09-17', 'Manado', 'Jl. Soekarno-Hatta No. 78, Manado', '81670043040', 'Sari.Utami@binus.ac.id', 'DKV'),
('2734567890', 'Anisa Putri', 'Female', '1991-06-29', 'Samarinda', 'Jl. Dr. Soetomo No. 56, Samarinda', '81264559872', 'Anisa.Putri@binus.ac.id', 'SE');

-- --------------------------------------------------------

--
-- Table structure for table `binus_matakuliah`
--

CREATE TABLE `binus_matakuliah` (
  `MatKul_Kode` char(4) NOT NULL,
  `Jurusan_Kode` char(10) NOT NULL,
  `MatKul_Nama` varchar(50) NOT NULL,
  `MatKul_SKS` int(5) NOT NULL
) ;

--
-- Dumping data for table `binus_matakuliah`
--

INSERT INTO `binus_matakuliah` (`MatKul_Kode`, `Jurusan_Kode`, `MatKul_Nama`, `MatKul_SKS`) VALUES
('123A', 'ACC', 'Akuntansi Keuangan', 2),
('124B', 'ARS', 'Arsitektur Modern', 3),
('125C', 'TI', 'Pemodelan Bisnis', 4),
('126D', 'TKOM', 'Jaringan Komputer', 2),
('127E', 'IF', 'Algoritma Pemrograman', 3),
('128F', 'CS', 'Keamanan Jaringan', 3),
('129G', 'DI', 'Desain Interior Modern', 4),
('130H', 'DKV', 'Desain Grafis', 2),
('131I', 'SI', 'Sistem Basis Data', 2),
('132J', 'MGT', 'Manajemen Strategik', 2),
('133K', 'HI', 'Sejarah Dunia', 4),
('134L', 'PSI', 'Psikologi Abnormal', 4),
('135M', 'SE', 'Sastra Banding', 3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_course_details`
-- (See below for the actual view)
--
CREATE TABLE `vw_course_details` (
`MatKul_Kode` char(4)
,`MatKul_Nama` varchar(50)
,`MatKul_SKS` int(5)
,`Department_Name` varchar(50)
,`Faculty_Name` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_students_by_nim_23`
-- (See below for the actual view)
--
CREATE TABLE `vw_students_by_nim_23` (
`Mahasiswa_NIM` char(12)
,`Mahasiswa_Nama` varchar(50)
,`Mahasiswa_gender` varchar(10)
,`Mahasiswa_DOB` date
,`Mahasiswa_TempatTanggalLahir` varchar(50)
,`Mahasiswa_Alamat` varchar(50)
,`Mahasiswa_NoTelp` char(15)
,`Mahasiswa_Email` varchar(50)
,`Jurusan_Kode` char(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_students_by_nim_24`
-- (See below for the actual view)
--
CREATE TABLE `vw_students_by_nim_24` (
`Mahasiswa_NIM` char(12)
,`Mahasiswa_Nama` varchar(50)
,`Mahasiswa_gender` varchar(10)
,`Mahasiswa_DOB` date
,`Mahasiswa_TempatTanggalLahir` varchar(50)
,`Mahasiswa_Alamat` varchar(50)
,`Mahasiswa_NoTelp` char(15)
,`Mahasiswa_Email` varchar(50)
,`Jurusan_Kode` char(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_students_by_nim_25`
-- (See below for the actual view)
--
CREATE TABLE `vw_students_by_nim_25` (
`Mahasiswa_NIM` char(12)
,`Mahasiswa_Nama` varchar(50)
,`Mahasiswa_gender` varchar(10)
,`Mahasiswa_DOB` date
,`Mahasiswa_TempatTanggalLahir` varchar(50)
,`Mahasiswa_Alamat` varchar(50)
,`Mahasiswa_NoTelp` char(15)
,`Mahasiswa_Email` varchar(50)
,`Jurusan_Kode` char(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_students_by_nim_26`
-- (See below for the actual view)
--
CREATE TABLE `vw_students_by_nim_26` (
`Mahasiswa_NIM` char(12)
,`Mahasiswa_Nama` varchar(50)
,`Mahasiswa_gender` varchar(10)
,`Mahasiswa_DOB` date
,`Mahasiswa_TempatTanggalLahir` varchar(50)
,`Mahasiswa_Alamat` varchar(50)
,`Mahasiswa_NoTelp` char(15)
,`Mahasiswa_Email` varchar(50)
,`Jurusan_Kode` char(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_students_by_nim_27`
-- (See below for the actual view)
--
CREATE TABLE `vw_students_by_nim_27` (
`Mahasiswa_NIM` char(12)
,`Mahasiswa_Nama` varchar(50)
,`Mahasiswa_gender` varchar(10)
,`Mahasiswa_DOB` date
,`Mahasiswa_TempatTanggalLahir` varchar(50)
,`Mahasiswa_Alamat` varchar(50)
,`Mahasiswa_NoTelp` char(15)
,`Mahasiswa_Email` varchar(50)
,`Jurusan_Kode` char(10)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_course_details` exported as a table
--
DROP TABLE IF EXISTS `vw_course_details`;
CREATE TABLE`vw_course_details`(
    `MatKul_Kode` char(4) COLLATE utf8mb4_general_ci NOT NULL,
    `MatKul_Nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `MatKul_SKS` int(5) NOT NULL,
    `Department_Name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Faculty_Name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `vw_students_by_nim_23` exported as a table
--
DROP TABLE IF EXISTS `vw_students_by_nim_23`;
CREATE TABLE`vw_students_by_nim_23`(
    `Mahasiswa_NIM` char(12) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_gender` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_DOB` date NOT NULL,
    `Mahasiswa_TempatTanggalLahir` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Alamat` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_NoTelp` char(15) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Jurusan_Kode` char(10) COLLATE utf8mb4_general_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `vw_students_by_nim_24` exported as a table
--
DROP TABLE IF EXISTS `vw_students_by_nim_24`;
CREATE TABLE`vw_students_by_nim_24`(
    `Mahasiswa_NIM` char(12) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_gender` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_DOB` date NOT NULL,
    `Mahasiswa_TempatTanggalLahir` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Alamat` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_NoTelp` char(15) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Jurusan_Kode` char(10) COLLATE utf8mb4_general_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `vw_students_by_nim_25` exported as a table
--
DROP TABLE IF EXISTS `vw_students_by_nim_25`;
CREATE TABLE`vw_students_by_nim_25`(
    `Mahasiswa_NIM` char(12) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_gender` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_DOB` date NOT NULL,
    `Mahasiswa_TempatTanggalLahir` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Alamat` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_NoTelp` char(15) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Jurusan_Kode` char(10) COLLATE utf8mb4_general_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `vw_students_by_nim_26` exported as a table
--
DROP TABLE IF EXISTS `vw_students_by_nim_26`;
CREATE TABLE`vw_students_by_nim_26`(
    `Mahasiswa_NIM` char(12) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_gender` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_DOB` date NOT NULL,
    `Mahasiswa_TempatTanggalLahir` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Alamat` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_NoTelp` char(15) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Jurusan_Kode` char(10) COLLATE utf8mb4_general_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `vw_students_by_nim_27` exported as a table
--
DROP TABLE IF EXISTS `vw_students_by_nim_27`;
CREATE TABLE`vw_students_by_nim_27`(
    `Mahasiswa_NIM` char(12) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_gender` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_DOB` date NOT NULL,
    `Mahasiswa_TempatTanggalLahir` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Alamat` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_NoTelp` char(15) COLLATE utf8mb4_general_ci NOT NULL,
    `Mahasiswa_Email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
    `Jurusan_Kode` char(10) COLLATE utf8mb4_general_ci NOT NULL
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `binus_administrasi`
--
ALTER TABLE `binus_administrasi`
  ADD KEY `Mahasiswa_NIM` (`Mahasiswa_NIM`);

--
-- Indexes for table `binus_fakultas`
--
ALTER TABLE `binus_fakultas`
  ADD PRIMARY KEY (`Fakultas_Kode`);

--
-- Indexes for table `binus_hargasks`
--
ALTER TABLE `binus_hargasks`
  ADD PRIMARY KEY (`MatKul_Kode`);

--
-- Indexes for table `binus_jurusan`
--
ALTER TABLE `binus_jurusan`
  ADD PRIMARY KEY (`Jurusan_Kode`,`Fakultas_kode`,`Kampus_Kode`),
  ADD KEY `Fakultas_kode` (`Fakultas_kode`),
  ADD KEY `Kampus_Kode` (`Kampus_Kode`);

--
-- Indexes for table `binus_kampus`
--
ALTER TABLE `binus_kampus`
  ADD PRIMARY KEY (`Kampus_Kode`);

--
-- Indexes for table `binus_mahasiswa`
--
ALTER TABLE `binus_mahasiswa`
  ADD PRIMARY KEY (`Mahasiswa_NIM`),
  ADD KEY `Jurusan_Kode` (`Jurusan_Kode`);

--
-- Indexes for table `binus_matakuliah`
--
ALTER TABLE `binus_matakuliah`
  ADD PRIMARY KEY (`MatKul_Kode`),
  ADD KEY `Jurusan_Kode` (`Jurusan_Kode`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `binus_administrasi`
--
ALTER TABLE `binus_administrasi`
  ADD CONSTRAINT `binus_administrasi_ibfk_1` FOREIGN KEY (`Mahasiswa_NIM`) REFERENCES `binus_mahasiswa` (`Mahasiswa_NIM`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `binus_hargasks`
--
ALTER TABLE `binus_hargasks`
  ADD CONSTRAINT `binus_hargasks_ibfk_1` FOREIGN KEY (`MatKul_Kode`) REFERENCES `binus_matakuliah` (`MatKul_Kode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `binus_jurusan`
--
ALTER TABLE `binus_jurusan`
  ADD CONSTRAINT `binus_jurusan_ibfk_1` FOREIGN KEY (`Fakultas_kode`) REFERENCES `binus_fakultas` (`Fakultas_Kode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `binus_jurusan_ibfk_2` FOREIGN KEY (`Kampus_Kode`) REFERENCES `binus_kampus` (`Kampus_Kode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `binus_mahasiswa`
--
ALTER TABLE `binus_mahasiswa`
  ADD CONSTRAINT `binus_mahasiswa_ibfk_1` FOREIGN KEY (`Jurusan_Kode`) REFERENCES `binus_jurusan` (`Jurusan_Kode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `binus_matakuliah`
--
ALTER TABLE `binus_matakuliah`
  ADD CONSTRAINT `binus_matakuliah_ibfk_1` FOREIGN KEY (`Jurusan_Kode`) REFERENCES `binus_jurusan` (`Jurusan_Kode`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
