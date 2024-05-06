<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GuruController;
use App\Http\Controllers\PenilaianController;

use App\Http\Controllers\AuthController;
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

Route::get('/guru', [GuruController::class,'read_all']);
Route::get('/guru/{id}', [GuruController::class,'read']);
Route::post('/guru/create', [GuruController::class,'store']);
Route::put('/guru/update/{id}', [GuruController::class,'update']);
Route::delete('/guru/delete/{id}', [GuruController::class, 'delete']);

Route::get('/penilaian', [PenilaianController::class, 'read_all']);
Route::get('/penilaian/{id}', [PenilaianController::class,'read']);
Route::post('/penilaian/create', [PenilaianController::class, 'store']);
Route::put('/penilaian/update/{id}', [PenilaianController::class,'update']);
Route::delete('/penilaian/delete/{id}', [PenilaianController::class, 'delete']);


