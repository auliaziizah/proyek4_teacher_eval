<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penilaian extends Model
{
    protected $table = 'penilaians'; // Nama tabel yang digunakan oleh model

    protected $fillable = ['judul_penilaian', 'tgl_penilaian', 'komponen_penilaian', 'image']; // Kolom yang dapat diisi secara massal

    // Jika kolom tanggal bukan tipe data DateTime
    protected $casts = [
        'tgl_penilaian' => 'datetime',
    ];

    // Relasi atau method lainnya dapat ditambahkan di sini sesuai kebutuhan
}