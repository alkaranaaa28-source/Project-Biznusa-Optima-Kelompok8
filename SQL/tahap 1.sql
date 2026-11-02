USE db_biznusa;
SELECT
    p.status_pembayaran AS `Status Pembayaran`,
    COUNT(t.id_transaksi) AS `Jumlah Transaksi`,
    SUM(t.total_transaksi) AS `Total Transaksi`
FROM db_biznusa.transaksi t
JOIN db_biznusa.pembayaran p
    ON t.id_transaksi = p.id_transaksi
GROUP BY p.status_pembayaran;
