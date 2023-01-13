-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Waktu pembuatan: 12 Jan 2023 pada 01.05
-- Versi server: 5.7.34
-- Versi PHP: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `be_cybernet`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `paket`
--

CREATE TABLE `paket` (
  `id_paket` int(11) NOT NULL,
  `id_user` int(20) NOT NULL COMMENT 'id usernya admin (role 1)',
  `nama_paket` text NOT NULL,
  `kecepatan` int(11) NOT NULL,
  `harga` double NOT NULL COMMENT 'harga satuan paket',
  `disc` int(3) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL COMMENT '1=publish,2=draft',
  `gambar_produk` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `paket`
--

INSERT INTO `paket` (`id_paket`, `id_user`, `nama_paket`, `kecepatan`, `harga`, `disc`, `status`, `gambar_produk`, `created_at`, `updated_at`) VALUES
(1, 1, 'Paket DEF', 25, 230000, 8, 1, '', '2023-01-08 12:36:15', '2023-01-08 06:00:48'),
(2, 1, 'Paket Tahun Baru', 30, 350000, 10, 1, '', '2023-01-08 05:53:16', '2023-01-08 05:53:16'),
(3, 1, 'Paket Lebaran', 25, 700000, 30, 2, '', '2023-01-11 14:46:13', '2023-01-11 14:46:13'),
(6, 1, 'Paket Imlek', 25, 230000, 8, 1, '20230111164413.png', '2023-01-11 16:44:13', '2023-01-11 16:44:13'),
(7, 1, '1', 2, 3, 4, 2, '20230112042544.png', '2023-01-12 04:25:44', '2023-01-12 04:25:44'),
(10, 1, '11', 22, 33, 44, 1, '20230112043028.png', '2023-01-12 04:30:28', '2023-01-12 04:30:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 2, 'auth_token', '314bcdf6bfee003f05c1d559120e965c101affe4ae24fc9985637ca8f6f4cbff', '[\"*\"]', NULL, '2023-01-07 18:14:25', '2023-01-07 18:14:25'),
(32, 'App\\Models\\User', 4, 'auth_token', '6aeffecc9fe5782976cdcb3b2317b00727ec619348cf2925056725bb3551cd65', '[\"*\"]', NULL, '2023-01-10 07:11:01', '2023-01-10 07:11:01'),
(33, 'App\\Models\\User', 5, 'auth_token', '02fb8f86f14c40b75bb9a8126e90f3d12ee5f40455464c87b945de807e0f823c', '[\"*\"]', NULL, '2023-01-10 07:17:19', '2023-01-10 07:17:19'),
(34, 'App\\Models\\User', 6, 'auth_token', '434696787d379510eaeae50ff2a11d2654f4703b828fad406efa507c9d468516', '[\"*\"]', NULL, '2023-01-10 07:22:31', '2023-01-10 07:22:31'),
(45, 'App\\Models\\User', 1, 'auth_token', '5e5e7eae6f3c503874612fe6dad7130b5c25820b1fb2efb3acee8fd16629b5a4', '[\"*\"]', '2023-01-11 22:17:12', '2023-01-11 13:55:40', '2023-01-11 22:17:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_paket` int(11) NOT NULL,
  `id_user` int(11) NOT NULL COMMENT 'id usernya customer (role 2)',
  `nama_user` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL COMMENT 'histori email',
  `alamat` text NOT NULL COMMENT 'histori alamat',
  `no_tlp` varchar(20) NOT NULL DEFAULT '0' COMMENT 'histori no tlp',
  `tgl_transaksi` datetime NOT NULL,
  `nama_paket` text NOT NULL COMMENT 'histrori nama paket',
  `kecepatan` int(11) NOT NULL COMMENT 'histori kecepatan',
  `harga` double NOT NULL COMMENT 'histori harga satuan paket',
  `disc` int(3) NOT NULL COMMENT 'histori diskon paket',
  `lama` int(11) NOT NULL COMMENT 'langganan berapa bulan',
  `total` double NOT NULL COMMENT 'histori total nominal pembelian',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_paket`, `id_user`, `nama_user`, `email`, `alamat`, `no_tlp`, `tgl_transaksi`, `nama_paket`, `kecepatan`, `harga`, `disc`, `lama`, `total`, `created_at`, `updated_at`) VALUES
(2, 1, 3, 'Muthia', 'muthia@gmail.com', '', '0', '2023-01-09 09:21:28', 'Paket DEF', 25, 230000, 8, 3, 524400, '2023-01-09 09:21:28', '2023-01-09 09:21:28'),
(8, 1, 3, 'Muthia', 'muthia@gmail.com', '', '0', '2023-01-11 09:04:13', 'Paket DEF', 25, 230000, 8, 4, 846400, '2023-01-11 09:04:13', '2023-01-11 09:04:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int(1) NOT NULL DEFAULT '2' COMMENT '1=admin,2=customer',
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_tlp` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `alamat`, `no_tlp`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Wini MK', 'wini@gmail.com', 1, '', '0', NULL, '$2y$10$UFLjtPnHoft2akynMiSe8O794yYXWePkxkGVD85MTjg9ueByI6.6.', NULL, '2023-01-07 18:12:48', '2023-01-07 18:12:48'),
(3, 'Muthia', 'muthia@gmail.com', 2, '', '0', NULL, '$2y$10$z6bRcZJ7DO.55lG7jfuFau2a7Owosa.Ede30Omrl1Dxh0VaUgndoO', NULL, '2023-01-07 18:16:07', '2023-01-07 18:16:07'),
(8, 'dhoni', 'dhoni@gmail.com', 2, 'Parung Bogor Jawa Barat', '121308', NULL, '$2y$10$/CMfFbEQnkyQ7J9MhmbNhu9oegbMCtG4G1y2joKxgznD25jVUrZXG', NULL, '2023-01-10 07:27:27', '2023-01-10 07:27:27');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `paket`
--
ALTER TABLE `paket`
  ADD PRIMARY KEY (`id_paket`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `paket`
--
ALTER TABLE `paket`
  MODIFY `id_paket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
