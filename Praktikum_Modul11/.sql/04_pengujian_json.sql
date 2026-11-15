SELECT
    nama_staf,
    JSON_EXTRACT(
        detail_staf,
        '$.jabatan'
    ) AS jabatan
FROM staf_umkm;
SELECT
    nama_staf,
    JSON_EXTRACT(
        detail_staf,
        '$.status_pembayaran'
    ) AS status_pembayaran
FROM staf_umkm;
SELECT
    nama_staf,
    JSON_EXTRACT(
        detail_staf,
        '$.metode_pembayaran'
    ) AS metode_pembayaran
FROM staf_umkm;

UPDATE staf_umkm
SET detail_staf = JSON_SET(
    detail_staf,
    '$.jabatan',
    'Koordinator UMKM'
)
WHERE id_staf = 'ST001';
SELECT
    nama_staf,
    JSON_EXTRACT(
        detail_staf,
        '$.jabatan'
    ) AS jabatan
FROM staf_umkm
WHERE id_staf = 'ST001';

UPDATE staf_umkm
SET detail_staf = JSON_SET(
    detail_staf,
    '$.catatan',
    'Data staf telah diperbarui'
)
WHERE id_staf = 'ST001';
SELECT
    nama_staf,
    detail_staf
FROM staf_umkm
WHERE id_staf = 'ST001';

UPDATE staf_umkm
SET detail_staf = JSON_REMOVE(
    detail_staf,
    '$.catatan'
)
WHERE id_staf = 'ST001';
SELECT
    nama_staf,
    detail_staf
FROM staf_umkm;

SELECT
    nama_staf,
    total_transaksi,
    detail_staf
FROM staf_umkm
WHERE JSON_UNQUOTE(
    JSON_EXTRACT(
        detail_staf,
        '$.status_pembayaran'
    )
) = 'Lunas';
SELECT
    nama_staf,
    total_transaksi
FROM staf_umkm
WHERE JSON_UNQUOTE(
    JSON_EXTRACT(
        detail_staf,
        '$.metode_pembayaran'
    )
) = 'Transfer';

SELECT JSON_OBJECT(
    'id_owner', 'OW001',
    'nama_owner', 'Bu Yuyun Winarti',
    'nama_usaha', 'UMKM BizNusa'
) AS data_owner;

SELECT JSON_ARRAY(
    'MySQL',
    'MariaDB',
    'PostgreSQL'
) AS daftar_dbms;

SELECT
    JSON_VALID(
        '{"nama_staf":"Andi Pratama","status":"Aktif"}'
    ) AS json_valid;

SELECT
    nama_staf,
    JSON_LENGTH(detail_staf) AS jumlah_atribut
FROM praktikum_modul11.staf_umkm;
