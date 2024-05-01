<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GuruController;
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
