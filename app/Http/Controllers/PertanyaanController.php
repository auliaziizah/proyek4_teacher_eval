<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Models\Pertanyaan;
use App\Models\Komponen;

class PertanyaanController extends Controller
{
    public function read_all()
    {
        $pertanyaan = Pertanyaan::all();
        return response()->json(['message' => 'Success', 'data' => $pertanyaan]);
    }

    public function read($id)
    {
        $komponen = Komponen::find($id);

        if (!$komponen) {
            return response()->json(['message' => 'Komponen not found'], 404);
        }

        $pertanyaan = Pertanyaan::where('id_komponen', $id)->get();

        if ($pertanyaan->isEmpty()) {
            return response()->json(['message' => 'No questions found for this component'], 404);
        }

        return response()->json(['message' => 'Success', 'data' => $pertanyaan]);
    }

    public function store(Request $request)
    {
        $input = $request->all();
        $komponen = Pertanyaan::create($input);
        return response()->json(['message' => 'Data berhasil disimpan', 'data' => $komponen]);
    }

    public function update(Request $request, $id)
    {
        $pertanyaan = Pertanyaan::find($id);
        $pertanyaan->update($request->all());
        return response()->json(['message' => 'Data berhasil diupdate', 'data' => $pertanyaan]);
    }

    public function delete ($id)
    {
        $pertanyaan = Pertanyaan::find($id);
        $pertanyaan->delete();
        return response()->json(['message' => 'Data berhasil dihapus', 'data' => null]);
    }
}
