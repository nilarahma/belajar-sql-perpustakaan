SELECT 
    a.id_anggota,
    a.nama_anggota,
    a.no_telepon,
    COUNT(p.id_pinjam) AS total_peminjaman,
    COALESCE(SUM(p.total_denda), 0) AS total_denda
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
GROUP BY a.id_anggota, a.nama_anggota, a.no_telepon
ORDER BY total_peminjaman DESC
LIMIT 5;

SELECT 
    a.id_anggota,
    a.nama_anggota,
    a.no_telepon,
    a.tanggal_daftar,
    COUNT(p.id_pinjam) AS total_pinjam,
    SUM(p.total_denda) AS total_denda,
    COUNT(DISTINCT b.id_buku) AS jumlah_judul_unik,
    ROUND(AVG(DATEDIFF(p.tgl_kembali, p.tgl_pinjam)), 1) AS rata_hari_pinjam
FROM anggota a
INNER JOIN peminjaman p ON a.id_anggota = p.id_anggota
INNER JOIN eksemplar e ON p.no_reg_eksemplar = e.no_reg_eksemplar
INNER JOIN buku b ON e.id_buku = b.id_buku
GROUP BY a.id_anggota, a.nama_anggota, a.no_telepon, a.tanggal_daftar
ORDER BY total_pinjam DESC
LIMIT 5;






SELECT 
    k.nama_kategori,
    b.judul_buku,
    b.penerbit,
    COUNT(p.id_pinjam) AS total_dipinjam
FROM kategori k
INNER JOIN buku b ON k.id_kategori = b.id_kategori
INNER JOIN eksemplar e ON b.id_buku = e.id_buku
INNER JOIN peminjaman p ON e.no_reg_eksemplar = p.no_reg_eksemplar
GROUP BY k.id_kategori, k.nama_kategori, b.id_buku, b.judul_buku, b.penerbit
ORDER BY k.nama_kategori, total_dipinjam DESC;






SELECT 
    YEAR(p.tgl_pinjam) AS tahun,
    a.nama_anggota,
    COUNT(p.id_pinjam) AS total_pinjam
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
GROUP BY YEAR(p.tgl_pinjam), a.id_anggota, a.nama_anggota
ORDER BY tahun, total_pinjam DESC;






SELECT 
    b.id_buku,
    b.judul_buku,
    b.penerbit,
    k.nama_kategori,
    COUNT(p.id_pinjam) AS total_dipinjam
FROM buku b
INNER JOIN kategori k ON b.id_kategori = k.id_kategori
INNER JOIN eksemplar e ON b.id_buku = e.id_buku
INNER JOIN peminjaman p ON e.no_reg_eksemplar = p.no_reg_eksemplar
GROUP BY b.id_buku, b.judul_buku, b.penerbit, k.nama_kategori
ORDER BY total_dipinjam DESC
LIMIT 3;




SELECT 
    YEAR(tgl_pinjam) AS tahun,
    MONTH(tgl_pinjam) AS bulan,
    MONTHNAME(tgl_pinjam) AS nama_bulan,
    COUNT(id_pinjam) AS total_pinjam
FROM peminjaman
GROUP BY YEAR(tgl_pinjam), MONTH(tgl_pinjam), MONTHNAME(tgl_pinjam)
ORDER BY total_pinjam DESC;