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



// public function tambahPenilaian(Request $request)
// {
//     // Validasi input
//     $validatedData = $request->validate([
//         'judul_penilaian_penilaian' => 'required|string',
//         'tgl_penilaian' => 'required|date',
//         'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // Validasi foto (opsional, nullable jika foto tidak wajib)
//     ]);

//     // Cek apakah ada file foto yang diunggah
//     if ($request->hasFile('image')) {
//         $image = $request->file('image');
//         // Simpan image ke storage atau lokasi yang Anda tentukan
//         $namaimage = time().'.'.$image->getClientOriginalExtension();
//         $lokasiimage = storage_path('app/public/image');
//         $image->move($lokasiimage, $namaimage);
//         // Simpan nama image ke dalam database
//         $validatedData['image'] = $namaimage;
//     }

//     // Buat instance Penilaian dan simpan ke database
//     $penilaian = new Penilaian();
//     $penilaian->judul_penilaian = $validatedData['judul_penilaian'];
//     $penilaian->tgl_penilaian = $validatedData['tgl_penilaian'];
//     $penilaian->image = $validatedData['image'] ?? null; // Gunakan image yang diunggah jika ada
//     $penilaian->save();

//     return response()->json(['message' => 'Penilaian berhasil ditambahkan'], 201);
// }