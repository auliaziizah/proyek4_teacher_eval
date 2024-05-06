<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->only('nip', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $token = $user->createToken('Token Name')->plainTextToken;

            return response()->json(['token' => $token], 200);
        }

        // Cek jika NIP tidak ditemukan
        $user = User::where('nip', $request->nip)->first();
        if (!$user) {
            return response()->json(['error' => 'NIP tidak ditemukan'], 404);
        }

        // Cek jika password salah
        if (!Hash::check($request->password, $user->password)) {
            return response()->json(['error' => 'Password salah'], 401);
        }

        // Jika ada kesalahan lain yang tidak tertangani
        return response()->json(['error' => 'Terjadi kesalahan saat proses login'], 500);
    }
}
