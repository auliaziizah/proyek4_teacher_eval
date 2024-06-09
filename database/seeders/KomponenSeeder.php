<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class KomponenSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        $dataKomponen = [
            [
                'nama_komponen' => 'Penilaian Perangkat Pembelajaran',
                'tipe_jawaban' => 'skor',
                'kesimpulan' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nama_komponen' => 'Pemantauan Perangkat Pembelajaran',
                'tipe_jawaban' => 'nilai',
                'kesimpulan' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nama_komponen' => 'Alat Penialain Kompetensi Guru',
                'tipe_jawaban' => 'field',
                'kesimpulan' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        DB::table('data_komponen')->insert($dataKomponen);
    }
}
