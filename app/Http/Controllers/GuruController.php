<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Guru;

class GuruController extends Controller
{
    public function read_all()
    {
        $gurus = Guru::all();
        return response()->json(['message' => 'Success', 'data' => $gurus]);
    }

    public function read($id)
    {
        $guru = Guru::find($id);

        if (!$guru) {
            return response()->json(['message' => 'Guru not found'], 404);
        }

        return response()->json(['message' => 'Data berhasil ditemukan', 'data' => $guru]);
    }

    public function store(Request $request)
    {
        $guru = Guru::create($request->all());
        return response()->json(['message' => 'Data berhasil disimpan', 'data' => $guru]);
    }

    public function update(Request $request, $id)
    {
        $guru = Guru::find($id);
        $guru->update($request->all());
        return response()->json(['message' => 'Data berhasil diupdate', 'data' => $guru]);
    }

    public function delete ($id)
    {
        $guru = Guru::find($id);
        $guru->delete();
        return response()->json(['message' => 'Data berhasil dihapus', 'data' => null]);
    }
}
