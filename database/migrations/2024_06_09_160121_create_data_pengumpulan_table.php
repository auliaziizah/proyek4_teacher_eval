<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDataPengumpulanTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('data_pengumpulan', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('file_name');
            $table->string('file_path');
            $table->unsignedBigInteger('id_guru');
            $table->timestamps(); // Menambahkan kolom created_at dan updated_at
            $table->foreign('id_guru')->references('id')->on('gurus')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('data_pengumpulan');
    }
}
