<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Penilaian;

class PenilaianController extends Controller
{
    public function read_all()
    {
        $penilaians = Penilaian::all();
        return response()->json(['message' => 'Succes', 'data' => $penilaians]);
    }

    public function read($id)
    {
        $penilaian = Penilaian::find($id);
       
        if (!$penilaian) {
            return response()->json(['message' => 'Penilaian not found'], 404);
        }

        return response()->json(['message' => 'Data berhasil ditemukan', 'data' => $penilaian]);
    }

    public function store(Request $request)
    {
        $penilaian = Penilaian::create($request->all());
        return response()->json(['message' => 'Data berhasil disimpan', 'data' => $penilaian]);
    }

    public function update(Request $request, $id)
    {
        $penilaian = Penilaian::find($id);
        $penilaian->update($request->all());
        return response()->json(['message' => 'Data berhasil diupdate', 'data' => $penilaian]);
    }

    public function delete ($id)
    {
        $penilaian = Penilaian::find($id);
        $penilaian->delete();
        return response()->json(['message' => 'Data berhasil dihapus', 'data' => null]);
    }

}
