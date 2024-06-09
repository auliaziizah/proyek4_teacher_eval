<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('data_jawaban', function (Blueprint $table) {
            $table->id();
            $table->integer('id_penilaian');
            $table->integer('id_guru');
            $table->integer('id_komponen');
            $table->integer('id_pertanyaan');
            $table->integer('skor');
            $table->integer('ketersediaan');
            $table->string('keterangan');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('data_jawaban');
    }
};
