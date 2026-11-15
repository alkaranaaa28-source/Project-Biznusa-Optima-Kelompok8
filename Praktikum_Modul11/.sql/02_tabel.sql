DROP TABLE IF EXISTS staf_umkm;
DROP TABLE IF EXISTS owner_umkm;

CREATE TABLE owner_umkm (
    id_owner VARCHAR(10) PRIMARY KEY,
    nama_owner VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE staf_umkm (
    id_staf VARCHAR(10) PRIMARY KEY,
    nama_staf VARCHAR(100) NOT NULL,
    id_owner VARCHAR(10),
    total_transaksi DECIMAL(15,2) DEFAULT 0,
    detail_staf JSON NOT NULL,

    CONSTRAINT fk_staf_owner
    FOREIGN KEY (id_owner)
    REFERENCES owner_umkm(id_owner)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pengguna_objek (
    id_pengguna VARCHAR(10) PRIMARY KEY,
    nama_pengguna VARCHAR(150) NOT NULL,
    jenis_pengguna VARCHAR(50) NOT NULL,
    informasi_tambahan JSON
) ENGINE=InnoDB;
