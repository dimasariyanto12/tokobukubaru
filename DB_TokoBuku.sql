-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Des 2019 pada 09.13
-- Versi server: 10.1.37-MariaDB
-- Versi PHP: 7.1.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tokobuku`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_buku`
--

CREATE TABLE `tb_buku` (
  `id_buku` int(11) NOT NULL,
  `judul` varchar(80) NOT NULL,
  `noisbn` varchar(20) NOT NULL,
  `penulis` varchar(60) NOT NULL,
  `penerbit` varchar(60) NOT NULL,
  `tahun` year(4) NOT NULL,
  `stok` int(11) NOT NULL,
  `harga_pokok` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL,
  `ppn` int(11) NOT NULL,
  `diskon` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_buku`
--

INSERT INTO `tb_buku` (`id_buku`, `judul`, `noisbn`, `penulis`, `penerbit`, `tahun`, `stok`, `harga_pokok`, `harga_jual`, `ppn`, `diskon`) VALUES
(6, 'Takut Pacaran Berani Nikah', '34324423424', 'Iwan Safrudin', 'Erlangga', 2019, 44, 43000, 40000, 4000, 1000),
(7, 'HTML Pemula', '3435345345345', 'Graha', 'erlangga', 2019, 60, 131000, 120000, 12000, 1000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_distributor`
--

CREATE TABLE `tb_distributor` (
  `id_distributor` int(11) NOT NULL,
  `nama_distributor` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `telepon` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_distributor`
--

INSERT INTO `tb_distributor` (`id_distributor`, `nama_distributor`, `alamat`, `telepon`) VALUES
(3, 'DImas', 'Jepara', '0895386989706'),
(4, 'Ali Rohmad', 'Kancilan', '0892321324234');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_jual`
--

CREATE TABLE `tb_jual` (
  `id_jual` varchar(10) NOT NULL,
  `total` varchar(50) NOT NULL,
  `uang` varchar(50) NOT NULL,
  `kembali` varchar(50) NOT NULL,
  `id_kasir` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_jual`
--

INSERT INTO `tb_jual` (`id_jual`, `total`, `uang`, `kembali`, `id_kasir`, `tanggal`) VALUES
('PJN00001', '60800', '70000', '9200', 5, '2019-11-06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kasir`
--

CREATE TABLE `tb_kasir` (
  `id_kasir` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `status` enum('aktif','nonaktif') NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `akses` enum('admin','kasir') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_kasir`
--

INSERT INTO `tb_kasir` (`id_kasir`, `nama`, `alamat`, `telepon`, `status`, `username`, `password`, `akses`) VALUES
(1, 'Vera Graha Lestari', 'Kancilan', '08923232242323', 'aktif', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin'),
(5, 'Friska Sylfvia A', 'Bucu', '0897523723272', 'aktif', 'kasir', 'c7911af3adbd12a035b289556d96470a', 'kasir');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_keranjang`
--

CREATE TABLE `tb_keranjang` (
  `id_keranjang` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `id_kasir` int(11) NOT NULL,
  `jumlah` varchar(40) NOT NULL,
  `jumlah_harga` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pasok`
--

CREATE TABLE `tb_pasok` (
  `id_pasok` int(11) NOT NULL,
  `id_distributor` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_pasok`
--

INSERT INTO `tb_pasok` (`id_pasok`, `id_distributor`, `id_buku`, `jumlah`, `tanggal`) VALUES
(8, 3, 6, 24, '06-11-2019'),
(9, 3, 7, 38, '06-11-2019');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_penjualan`
--

CREATE TABLE `tb_penjualan` (
  `id_penjualan` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `jumlah_harga` int(11) NOT NULL,
  `id_jual` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_penjualan`
--

INSERT INTO `tb_penjualan` (`id_penjualan`, `id_buku`, `jumlah`, `jumlah_harga`, `id_jual`) VALUES
(32, 6, 2, 39800, 'PJN00001'),
(33, 7, 1, 21000, 'PJN00001'),
(34, 6, 4, 79600, 'PJN00001'),
(35, 6, 4, 79600, 'PJN00001'),
(36, 6, 2, 86000, 'PJN00001');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_buku`
--
ALTER TABLE `tb_buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `tb_distributor`
--
ALTER TABLE `tb_distributor`
  ADD PRIMARY KEY (`id_distributor`);

--
-- Indeks untuk tabel `tb_jual`
--
ALTER TABLE `tb_jual`
  ADD PRIMARY KEY (`id_jual`),
  ADD KEY `id_kasir` (`id_kasir`);

--
-- Indeks untuk tabel `tb_kasir`
--
ALTER TABLE `tb_kasir`
  ADD PRIMARY KEY (`id_kasir`);

--
-- Indeks untuk tabel `tb_keranjang`
--
ALTER TABLE `tb_keranjang`
  ADD PRIMARY KEY (`id_keranjang`),
  ADD KEY `id_buku` (`id_buku`),
  ADD KEY `id_kasir` (`id_kasir`);

--
-- Indeks untuk tabel `tb_pasok`
--
ALTER TABLE `tb_pasok`
  ADD PRIMARY KEY (`id_pasok`),
  ADD KEY `id_distributor` (`id_distributor`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indeks untuk tabel `tb_penjualan`
--
ALTER TABLE `tb_penjualan`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `id_buku` (`id_buku`),
  ADD KEY `id_jual` (`id_jual`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_buku`
--
ALTER TABLE `tb_buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tb_distributor`
--
ALTER TABLE `tb_distributor`
  MODIFY `id_distributor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tb_kasir`
--
ALTER TABLE `tb_kasir`
  MODIFY `id_kasir` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tb_keranjang`
--
ALTER TABLE `tb_keranjang`
  MODIFY `id_keranjang` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tb_pasok`
--
ALTER TABLE `tb_pasok`
  MODIFY `id_pasok` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `tb_penjualan`
--
ALTER TABLE `tb_penjualan`
  MODIFY `id_penjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tb_pasok`
--
ALTER TABLE `tb_pasok`
  ADD CONSTRAINT `tb_pasok_ibfk_1` FOREIGN KEY (`id_buku`) REFERENCES `tb_buku` (`id_buku`),
  ADD CONSTRAINT `tb_pasok_ibfk_2` FOREIGN KEY (`id_distributor`) REFERENCES `tb_distributor` (`id_distributor`);

--
-- Ketidakleluasaan untuk tabel `tb_penjualan`
--
ALTER TABLE `tb_penjualan`
  ADD CONSTRAINT `tb_penjualan_ibfk_1` FOREIGN KEY (`id_buku`) REFERENCES `tb_buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
