<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pertanyaan extends Model
{
    protected $table = 'data_pertanyaan';
    protected $fillable = ['id_komponen','pertanyaan']; 
}
