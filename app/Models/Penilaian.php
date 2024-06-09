<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penilaian extends Model
{
    protected $table = 'data_penilaian';
    protected $fillable = ['judul_penilaian', 'tgl_penilaian']; 
}