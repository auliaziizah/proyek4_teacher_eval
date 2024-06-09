<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Jawaban;

class JawabanController extends Controller
{
    public function read_all()
    {
        $jawaban = Jawaban::all();
        return response()->json(['message' => 'Success', 'data' => $jawaban]);
    }

    public function read($id)
    {
        $jawaban = Jawaban::find($id);

        if (!$jawaban) {
            return response()->json(['message' => 'Jawaban not found'], 404);
        }

        return response()->json(['message' => 'Data berhasil ditemukan', 'data' => $jawaban]);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'id_penilaian' => 'required|integer',
            'id_guru' => 'required|integer',
            'id_komponen' => 'required|integer',
            'id_pertanyaan' => 'required|integer',
            'skor' => 'required|integer|min:1|max:5',
            'ketersediaan' => 'required|integer|in:0,1',
            'keterangan' => 'nullable|string',
        ]);

        $jawaban = Jawaban::create($validatedData);
        return response()->json(['message' => 'Data berhasil disimpan', 'data' => $jawaban]);
    }

    public function update(Request $request, $id)
    {
        $jawaban = Jawaban::find($id);

        if (!$jawaban) {
            return response()->json(['message' => 'Jawaban not found'], 404);
        }

        $validatedData = $request->validate([
            'id_penilaian' => 'required|integer',
            'id_guru' => 'required|integer',
            'id_komponen' => 'required|integer',
            'id_pertanyaan' => 'required|integer',
            'skor' => 'required|integer|min:1|max:5',
            'ketersediaan' => 'required|integer|in:0,1',
            'keterangan' => 'nullable|string',
        ]);

        $jawaban->update($validatedData);
        return response()->json(['message' => 'Data berhasil diupdate', 'data' => $jawaban]);
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
