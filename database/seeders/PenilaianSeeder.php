<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class PenilaianSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        $dataPenilaian = [
            [
                'judul_penilaian' => 'Penilaian 1',
                'tgl_penilaian' => '2024-06-30',
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'judul_penilaian' => 'Penilaian 2',
                'tgl_penilaian' => '2024-09-15',
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
            [
                'judul_penilaian' => 'Penilaian 3',
                'tgl_penilaian' => '2024-12-20',
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ],
        ];

        DB::table('data_penilaian')->insert($dataPenilaian);
    }
}
