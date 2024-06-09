<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Komponen extends Model
{
    protected $table = 'data_komponen';
    protected $fillable = ['nama_komponen', 'tipe_jawaban', 'kesimpulan'];
}
