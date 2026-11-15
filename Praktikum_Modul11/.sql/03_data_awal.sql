USE praktikum_modul11;

DESCRIBE staf_umkm;
ALTER TABLE staf_umkm
ADD COLUMN detail_staf JSON;

UPDATE staf_umkm
SET detail_staf = CASE
    WHEN id_staf = 'ST001' THEN
        '{"jabatan":"Staf UMKM","id_transaksi":"TR001","status_pembayaran":"Lunas"}'

    WHEN id_staf = 'ST002' THEN
        '{"jabatan":"Staf UMKM","id_transaksi":"TR002","status_pembayaran":"Belum Lunas","metode_pembayaran":"Transfer"}'

    WHEN id_staf = 'ST003' THEN
        '{"jabatan":"Staf UMKM","id_transaksi":"TR003","status_pembayaran":"Lunas","metode_pembayaran":"Tunai","keterangan":"Transaksi selesai"}'
    
    WHEN id_staf = 'ST005' THEN
    	'{"jabatan":"Staf UMKM","id_transaksi":"TR004","status_pembayaran":"Lunas","metode_pembayaran":"Tunai","keterangan":"Transaksi selesai"}'
END
WHERE id_staf IN ('ST001', 'ST002', 'ST003', 'ST005');

INSERT INTO staf_umkm
(id_staf, nama_staf, id_owner, total_transaksi, detail_staf)
VALUES
(
    'ST001',
    'Andi Pratama',
    'OW001',
    150000,
    '{
        "jabatan": "Staf UMKM",
        "id_transaksi": "TR001",
        "status_pembayaran": "Lunas"
    }'
);
INSERT INTO staf_umkm
(id_staf, nama_staf, id_owner, total_transaksi, detail_staf)
VALUES
(
    'ST002',
    'Siti Aminah',
    'OW001',
    250000,
    '{
        "jabatan": "Staf UMKM",
        "id_transaksi": "TR002",
        "status_pembayaran": "Belum Lunas",
        "metode_pembayaran": "Transfer"
    }'
);
INSERT INTO staf_umkm
(id_staf, nama_staf, id_owner, total_transaksi, detail_staf)
VALUES
(
    'ST003',
    'Budi Santoso',
    'OW001',
    175000,
    '{
        "jabatan": "Staf UMKM",
        "id_transaksi": "TR003",
        "status_pembayaran": "Lunas",
        "metode_pembayaran": "Tunai",
        "keterangan": "Transaksi selesai"
    }'
);
INSERT INTO staf_umkm
(id_staf, nama_staf, id_owner, total_transaksi, detail_staf)
VALUES
(
    'ST005',
    'Rina Amelia',
    'OW001',
    0,
    '{
        "jabatan": "Staf UMKM",
        "id_transaksi": "TR004",
        "status_pembayaran": "Lunas",
        "metode_pembayaran": "Tunai",
        "keterangan": "Transaksi selesai"
    }'
);
SELECT * FROM staf_umkm;

