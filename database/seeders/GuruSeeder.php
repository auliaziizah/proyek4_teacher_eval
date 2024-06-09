<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class GuruSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('gurus')->insert([
            [
                'nip' => '1234567',
                'nama' => 'Kepala Sekolah',
                'pangkat' => 'IV/a',
                'golongan' => 'IV',
                'email' => 'kepsek@gmail.com',
                'password' => 'kepsek123',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nip' => '221511004',
                'nama' => 'Aulia Aziiah Fauziyyah',
                'pangkat' => 'III/a',
                'golongan' => 'III',
                'email' => 'aulia@gmail.com',
                'password' => 'aulia123',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nip' => '221511015',
                'nama' => 'Jonanda Pantas Agitha Brahmana',
                'pangkat' => 'II/a',
                'golongan' => 'II',
                'email' => 'jonanda@gmail.com',
                'password' => 'jonanda123',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nip' => '221511026',
                'nama' => 'Paulina Lestari Simatupang ',
                'pangkat' => 'I/a',
                'golongan' => 'I',
                'email' => 'paulina@gmail.com',
                'password' => 'paulina123',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
