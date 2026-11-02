-- 1. Menambahkan kolom denormalisasi
ALTER TABLE db_biznusa.staf_umkm
ADD COLUMN total_transaksi DECIMAL(15,2) DEFAULT 0;

-- 2. Memperbarui nilai denormalisasi berdasarkan total transaksi setiap staf
UPDATE db_biznusa.staf_umkm s
SET total_transaksi = (
    SELECT COALESCE(SUM(t.total_transaksi), 0)
    FROM db_biznusa.transaksi t
    WHERE t.id_staf = s.id_staf
);

-- 3. Menampilkan hasil denormalisasi
SELECT
    id_staf,
    nama_staf,
    total_transaksi
FROM db_biznusa.staf_umkm;
