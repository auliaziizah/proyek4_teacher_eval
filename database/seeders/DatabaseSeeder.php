<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call(GuruSeeder::class);
        $this->call(PenilaianSeeder::class);
        $this->call(KomponenSeeder::class);
        $this->call(PertanyaanSeeder::class);
    }
}
