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
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nama_komponen' => 'Pemantauan Perangkat Pembelajaran',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nama_komponen' => 'Alat Penialain Kompetensi Guru',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        DB::table('data_komponen')->insert($dataKomponen);
    }
}
