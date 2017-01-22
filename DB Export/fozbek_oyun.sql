-- phpMyAdmin SQL Dump
-- version 4.6.5.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:3306
-- Üretim Zamanı: 22 Oca 2017, 04:53:49
-- Sunucu sürümü: 5.6.33
-- PHP Sürümü: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `fozbek_oyun`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `oyun`
--

CREATE TABLE `oyun` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `can` int(11) NOT NULL DEFAULT '90',
  `tecrube` int(11) NOT NULL DEFAULT '0',
  `iksirSayisi` int(11) NOT NULL DEFAULT '3',
  `oldurulenDusmanMagara` int(11) NOT NULL DEFAULT '0',
  `oldurulenDusmanHelos` int(11) NOT NULL DEFAULT '0',
  `helosGirisKalanDusman` int(11) NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `oyun`
--

INSERT INTO `oyun` (`id`, `username`, `password`, `can`, `tecrube`, `iksirSayisi`, `oldurulenDusmanMagara`, `oldurulenDusmanHelos`, `helosGirisKalanDusman`) VALUES
(1, 'fatih', '1234', 150, 0, 3, 3, 0, 2),
(4, 'fatihrr12', '1234', 90, 0, 3, 0, 0, 2),
(7, 'baho', '1234', 90, 0, 3, 0, 0, 2),
(8, 'fati', '1234', 90, 0, 3, 0, 0, 2),
(9, 'ahmet', '1234', 90, 0, 3, 0, 0, 2),
(10, 'fatih3', '1234', 90, 0, 3, 0, 0, 2),
(11, 'baris', '1234', 90, 0, 3, 0, 0, 2),
(12, 'patates', '1234', 90, 0, 3, 0, 0, 2);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `oyun`
--
ALTER TABLE `oyun`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `oyun`
--
ALTER TABLE `oyun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
