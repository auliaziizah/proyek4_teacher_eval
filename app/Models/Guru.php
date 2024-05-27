<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Passport\HasApiTokens;

class Guru extends Authenticatable
{
    use HasApiTokens;
    protected $fillable = ['nip', 'nama', 'pangkat', 'golongan', 'email', 'password'];
    public static $rules = [
        'nip' => 'unique:gurus',
    ];
    protected $hidden = [
        'remember_token',
    ];
}
