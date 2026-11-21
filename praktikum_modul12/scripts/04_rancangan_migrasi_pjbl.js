// 1. Inisialisasi Database Target
use db_biznusa;

// 2. Migrasi Skema ke Pola Embedded Document (Denormalisasi Dokumen)
// Menggabungkan tabel relasional: transaksi, staf_umkm, dan pembayaran
// ke dalam satu koleksi 'transaksi' untuk memangkas operasi $lookup (JOIN).
db.transaksi.insertMany([
  {
    id_transaksi: "TR001",
    total_transaksi: 150000,
    staf: {
      id_staf: "ST001",
      nama_staf: "Andi Pratama"
    },
    pembayaran: {
      id_pembayaran: "PB001",
      status_pembayaran: "Lunas"
    }
  },
  {
    id_transaksi: "TR002",
    total_transaksi: 250000,
    staf: {
      id_staf: "ST002",
      nama_staf: "Siti Aminah"
    },
    pembayaran: {
      id_pembayaran: "PB002",
      status_pembayaran: "Belum Lunas"
    }
  },
  {
    id_transaksi: "TR003",
    total_transaksi: 175000,
    staf: {
      id_staf: "ST003",
      nama_staf: "Budi Santoso"
    },
    pembayaran: {
      id_pembayaran: "PB003",
      status_pembayaran: "Lunas"
    }
  }
]);

// 3. Strategi Optimisasi: Pembuatan Compound Index
// Mencegah Full Collection Scan (COLLSCAN) saat memfilter berdasarkan id_staf
// dan status_pembayaran ketika volume transaksi meningkat.
db.transaksi.createIndex(
  { "staf.id_staf": 1, "pembayaran.status_pembayaran": 1 },
  { name: "idx_staf_status_pembayaran" }
);

// 4. Rancangan Query Fitur Utama (Tanpa $lookup karena sudah di-embed)
// Kebutuhan: Menampilkan id_transaksi, total_transaksi, status_pembayaran,
// dan nama_staf untuk staf ST001 dengan status pembayaran "Lunas".
db.transaksi.find(
  {
    "staf.id_staf": "ST001",
    "pembayaran.status_pembayaran": "Lunas"
  },
  {
    _id: 0,
    id_transaksi: 1,
    total_transaksi: 1,
    "pembayaran.status_pembayaran": 1,
    "staf.nama_staf": 1
  }
);

// Alternatif menggunakan Aggregation Pipeline ($match + $project)
db.transaksi.aggregate([
  {
    $match: {
      "staf.id_staf": "ST001",
      "pembayaran.status_pembayaran": "Lunas"
    }
  },
  {
    $project: {
      _id: 0,
      id_transaksi: 1,
      total_transaksi: 1,
      status_pembayaran: "$pembayaran.status_pembayaran",
      nama_staf: "$staf.nama_staf"
    }
  }
]);

// 5. Inspeksi Rencana Eksekusi (Memastikan penggunaan IXSCAN)
db.transaksi.find(
  {
    "staf.id_staf": "ST001",
    "pembayaran.status_pembayaran": "Lunas"
  },
  {
    _id: 0,
    id_transaksi: 1,
    total_transaksi: 1,
    "pembayaran.status_pembayaran": 1,
    "staf.nama_staf": 1
  }
).explain("executionStats");

// 6. Rancangan Kontrol Akses RBAC (Prinsip Least Privilege)
// A. Peran Owner UMKM: Akses penuh baca dan tulis pada biznusa_db
db.createUser({
  user: "owner_umkm",
  pwd: "<GANTI_DENGAN_PASSWORD_KUAT>",
  roles: [{ role: "readWrite", db: "biznusa_db" }]
});

// B. Peran Staf UMKM (Kasir/Operasional): Akses baca & tulis terbatas pada database operasional
db.createUser({
  user: "staf_umkm",
  pwd: "<GANTI_DENGAN_PASSWORD_KUAT>",
  roles: [
    {
      role: "readWrite",
      db: "db_biznusa"
    }
  ]
});

// C. Peran Auditor / Pelaporan: Hanya baca (read-only), dilarang mengubah atau menghapus data
db.createUser({
  user: "auditor_laporan",
  pwd: "<GANTI_DENGAN_PASSWORD_KUAT>",
  roles: [{ role: "read", db: "biznusa_db" }]
});

// Verifikasi konfigurasi role pengguna
db.getUser("auditor_laporan");
