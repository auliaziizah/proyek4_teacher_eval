<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Jawaban;
use Illuminate\Support\Facades\Validator;


class JawabanController extends Controller
{
    public function read_all()
    {
        $jawaban = Jawaban::all();
        return response()->json(['message' => 'Success', 'data' => $jawaban]);
    }

    public function read($id_penilaian, $id_guru, $id_komponen)
    {
        // Validasi parameter
        $validator = Validator::make(compact('id_penilaian', 'id_guru', 'id_komponen'), [
            'id_penilaian' => 'required|integer',
            'id_guru' => 'required|integer',
            'id_komponen' => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Parameter tidak valid',
                'errors' => $validator->errors()->all()
            ], 400);
        }

        // Ambil data jawaban sesuai dengan id_penilaian, id_guru, dan id_komponen
        $jawaban = Jawaban::where([
            'id_penilaian' => $id_penilaian,
            'id_guru' => $id_guru,
            'id_komponen' => $id_komponen,
        ])->get(); // Mengubah dari first() menjadi get() untuk mengambil semua data yang cocok

        // Jika data ditemukan, kembalikan response JSON
        if ($jawaban->isNotEmpty()) {
            return response()->json([
                'success' => true,
                'message' => 'Data jawaban ditemukan',
                'data' => $jawaban
            ], 200);
        } else {
            // Jika tidak ditemukan, kembalikan response JSON dengan pesan tidak ditemukan
            return response()->json([
                'success' => false,
                'message' => 'Data jawaban tidak ditemukan',
                'data' => null
            ], 404);
        }
    }  

    public function read_jawaban($id_penilaian, $id_guru, $id_komponen, $id_pertanyaan)
    {
        // Validasi parameter
        $validator = Validator::make(compact('id_penilaian', 'id_guru', 'id_komponen', 'id_pertanyaan'), [
            'id_penilaian' => 'required|integer',
            'id_guru' => 'required|integer',
            'id_komponen' => 'required|integer',
            'id_pertanyaan' => 'required|integer',
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Parameter tidak valid',
                'errors' => $validator->errors()->all()
            ], 400);
        }
    
        // Ambil data jawaban sesuai dengan id_penilaian, id_guru, dan id_komponen
        $jawaban = Jawaban::where([
            'id_penilaian' => $id_penilaian,
            'id_guru' => $id_guru,
            'id_komponen' => $id_komponen,
            'id_pertanyaan' => $id_pertanyaan,
        ])->first();
    
        // Jika data ditemukan, kembalikan response JSON
        if ($jawaban) {
            return response()->json([
                'success' => true,
                'message' => 'Data jawaban ditemukan',
                'data' => $jawaban
            ], 200);
        } else {
            // Jika tidak ditemukan, kembalikan response JSON dengan pesan tidak ditemukan
            return response()->json([
                'success' => false,
                'message' => 'Data jawaban tidak ditemukan',
                'data' => null
            ], 404);
        }
    }    

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'id_penilaian' => 'required|integer',
            'id_guru' => 'required|integer',
            'id_komponen' => 'required|integer',
            'id_pertanyaan' => 'required|integer',
            'skor' => 'required|integer',
            'ketersediaan' => 'required|integer',
            'keterangan' => 'nullable|string',
        ]);

        $jawaban = Jawaban::create($validatedData);
        return response()->json(['message' => 'Data berhasil disimpan', 'data' => $jawaban]);
    }

    public function delete($id)
    {
        $jawaban = Jawaban::find($id);

        if (!$jawaban) {
            return response()->json(['message' => 'Jawaban not found'], 404);
        }

        $jawaban->delete();
        return response()->json(['message' => 'Data berhasil dihapus']);
    }
}
