<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PertanyaanSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $dataPertanyaan = [
            [
                'id_komponen' => 1,
                'pertanyaan' => 'Kalender Pendidikan?',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id_komponen' => 2,
                'pertanyaan' => 'Analisi KKM?',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id_komponen' => 3,
                'pertanyaan' => 'Daftar Nilai?',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        DB::table('data_pertanyaan')->insert($dataPertanyaan);
    }
}
