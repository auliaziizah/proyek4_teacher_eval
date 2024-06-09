<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pengumpulan extends Model
{
    protected $table = 'data_pengumpulan'; // Nama tabel yang digunakan oleh model
    protected $fillable = ['file_name', 'file_path', 'guru_id'];

    public function guru()
    {
        return $this->belongsTo(Guru::class, 'guru_id');
    }
}
