<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Jawaban extends Model
{
    use HasFactory;

    protected $table = 'data_jawaban';

    protected $fillable = [
        'id_penilaian',
        'id_guru',
        'id_komponen',
        'id_pertanyaan',
        'skor',
        'ketersediaan',
        'keterangan'
    ];
}
