use transport_db; 
// 1. Membuat akun report_user dengan hak hanya baca (padanan CREATE USER + GRANT SELECT) db.createUser({ 
user: "report_user", 
pwd: "<PASSWORD_PLACEHOLDER>", 
roles: [{ role: "read", db: "transport_db" }] 
}); 

// 2. Memeriksa konfigurasi hak akses (padanan SHOW GRANTS) 
db.getUser("report_user"); 

// 3. Mencabut hak akses baca (padanan REVOKE SELECT) db.revokeRolesFromUser("report_user", [{ role: "read", db: "transport_db" }]); 

// 4. Memeriksa ulang status hak akses setelah pencabutan 
db.getUser("report_user"); 
```[cite: 16, 17] 

