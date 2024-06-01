<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Models\Pertanyaan;

class PertanyaanController extends Controller
{
    public function read_all()
    {
        $komponen = Komponen::all();
        return response()->json(['message' => 'Success', 'data' => $komponen]);
    }

    public function store(Request $request)
    {
        $input = $request->all();
        $komponen = Komponen::create($input);
        return response()->json(['message' => 'Data berhasil disimpan', 'data' => $komponen]);
    }

    public function update(Request $request, $id)
    {
        $komponen = Komponen::find($id);
        $komponen->update($request->all());
        return response()->json(['message' => 'Data berhasil diupdate', 'data' => $komponen]);
    }

    public function delete ($id)
    {
        $komponen = Komponen::find($id);
        $komponen->delete();
        return response()->json(['message' => 'Data berhasil dihapus', 'data' => null]);
    }
}
