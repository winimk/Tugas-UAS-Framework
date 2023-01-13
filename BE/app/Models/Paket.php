<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Paket extends Model
{
    use HasFactory;
    protected $table = 'paket';
    protected $primaryKey = 'id_paket';
    protected $keyType = 'integer';
    // use HasFactory;
    // protected $fillable = ['*'];
    protected $fillable = ['id_user', 'nama_paket', 'kecepatan', 'harga', 'disc', 'status', 'gambar_produk'];
}
