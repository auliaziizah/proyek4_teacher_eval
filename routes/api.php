<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\GuruController;
use App\Http\Controllers\JawabanController;
use App\Http\Controllers\KomponenController;
use App\Http\Controllers\PenilaianController;
use App\Http\Controllers\PertanyaanController;
use App\Http\Controllers\PengumpulanController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout']);

# Guru
Route::get('/guru', [GuruController::class,'read_all']);
Route::get('/guru/{id}', [GuruController::class,'read']);
Route::post('/guru/create', [GuruController::class,'store']);
Route::put('/guru/update/{id}', [GuruController::class,'update']);
Route::delete('/guru/delete/{id}', [GuruController::class, 'delete']);
# Penilaian
Route::get('/penilaian', [PenilaianController::class, 'read_all']);
Route::get('/penilaian/{id}', [PenilaianController::class,'read']);
Route::post('/penilaian/create', [PenilaianController::class, 'store']);
Route::put('/penilaian/update/{id}', [PenilaianController::class,'update']);
Route::delete('/penilaian/delete/{id}', [PenilaianController::class, 'delete']);
# Komponen
Route::get('/komponen', [KomponenController::class,'read_all']);
Route::get('/komponen/{id}', [PertanyaanController::class,'read']);
Route::post('/komponen/create', [KomponenController::class,'store']);
Route::put('/komponen/update/{id}', [KomponenController::class,'update']);
Route::delete('/komponen/delete/{id}', [KomponenController::class, 'delete']);
# Pertanyaan
Route::get('/pertanyaan', [PertanyaanController::class,'read_all']);
Route::get('/pertanyaan/{id}', [PertanyaanController::class,'read']);
Route::post('/pertanyaan/create', [PertanyaanController::class,'store']);
Route::put('/pertanyaan/update/{id}', [PertanyaanController::class,'update']);
Route::delete('/pertanyaan/delete/{id}', [PertanyaanController::class, 'delete']);
# Jawaban
Route::get('/jawaban', [JawabanController::class,'read_all']);
Route::get('/jawaban/{id}', [JawabanController::class,'read']);
Route::post('/jawaban/create', [JawabanController::class,'store']);
Route::put('/jawaban/update/{id}', [JawabanController::class,'update']);
Route::delete('/jawaban/delete/{id}', [JawabanController::class, 'delete']);
# Pengumpulan
Route::get('/pengumpulan', [PengumpulanController::class,'read_all']);
Route::post('/pengumpulan/create', [PengumpulanController::class,'store']);
Route::delete('/pengumpulan/delete/{id}', [PengumpulanController::class, 'delete']);