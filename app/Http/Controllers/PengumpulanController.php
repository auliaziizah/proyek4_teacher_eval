<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pengumpulan;
use Illuminate\Support\Facades\Storage;

class PengumpulanController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function read_all()
    {
        $pengumpulan = Pengumpulan::all();
        return response()->json(['data' => $pengumpulan], 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'id_guru' => 'required|exists:gurus,id', // Ensure the id_guru exists in the gurus table
            'file' => 'required|file|mimes:pdf,doc,docx,xls,xlsx,png,jpg,jpeg|max:2048', // Adjust the allowed file types and size as needed
        ]);

        try {
            // Handle file upload
            if ($request->hasFile('file')) {
                $file = $request->file('file');
                $filename = time() . '_' . $file->getClientOriginalName();
                $path = $file->storeAs('uploads', $filename, 'public');
            }

            // Create new Pengumpulan entry
            $pengumpulan = new Pengumpulan();
            $pengumpulan->id_guru = $request->id_guru;
            $pengumpulan->file = $path ?? '';
            $pengumpulan->save();

            return response()->json(['message' => 'File berhasil dikumpulkan', 'data' => $pengumpulan], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal mengumpulkan file', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function delete($id)
    {
        $pengumpulan = Pengumpulan::find($id);

        if ($pengumpulan) {
            // Delete file from storage
            Storage::disk('public')->delete($pengumpulan->file);

            // Delete entry from database
            $pengumpulan->delete();

            return response()->json(['message' => 'File berhasil dihapus'], 200);
        } else {
            return response()->json(['message' => 'File tidak ditemukan'], 404);
        }
    }
}
