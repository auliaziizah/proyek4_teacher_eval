<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Guru;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $nip = $request->input('nip');
        $password = $request->input('password');

        // Validasi input
        $request->validate([
            'nip' => 'required',
            'password' => 'required'
        ]);

        $guru = Guru::where('nip', $nip)->first();

        if ($guru) {
            // Memeriksa apakah password cocok
            if ($password === $guru->password) {
                // Tentukan peran pengguna berdasarkan NIP
                $role = $nip === '221511004' ? 'kepala_sekolah' : 'guru';

                // Set sesi isLoggedIn menjadi true setelah login berhasil
                $request->session()->put([
                    'id' => $guru->id,
                    'nip' => $guru->nip,
                    'logged_in' => true,
                    'role' => $role 
                ]);
                return response()->json(['token' => 'example_token', 'role' => $role, 'message' => 'Login successful'], 200);
            } else {
                return response()->json(['message' => 'Wrong Password'], 401);
            }
        } else {
            return response()->json(['message' => 'Username not Found'], 404);
        }
    }

    public function logout(Request $request)
    {
        $request->session()->flush();
        return response()->json(['message' => 'Logged out successfully'], 200);
    }
}
