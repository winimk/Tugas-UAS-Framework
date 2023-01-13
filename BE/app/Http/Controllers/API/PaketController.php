<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Paket;
use App\Http\Controllers\API\URL;

class PaketController extends Controller
{
    protected $path_photoproduk;

    public function __construct()
    {
        $this->path_photoproduk = asset('folGambarProduk') . '/';
    }

    public function index()
    {
        $data = Paket::get();

        $output = array(
            'error' => false,
            'msg' => 'Data Berhasil Ditampilkan',
            'path_photo' => $this->path_photoproduk,
            'data' => $data
        );
        return $output;
    }

    public function get_by_id($id)
    {
        // var_dump(Paket::find($id));
        // var_dump(Paket::where('id_paket', $id)->first()); 
        // die;

        return response()->json(['error' => false, 'path_photo' => $this->path_photoproduk, 'data' => Paket::find($id)]);
    }

    public function get_by_status($id)
    {
        return response()->json(['error' => false, 'path_photo' => $this->path_photoproduk, 'data' => Paket::where('status', $id)->get()]);
    }

    public function create(Request $request)
    {
        // header('Access-Control-Allow-Origin', '*');
        // header('Access-Control-Allow-Methods', 'GET,POST,PUT,PATCH,DELETE,OPTIONS');

        $request->validate([
            'id_user' => 'required',
            'nama_paket' => 'required',
            'kecepatan' => 'required',
            'harga' => 'required',
            'disc' => 'required',
            'status' => 'required',
            'gambar_produk' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            // 'gambar_produk' => 'nullable|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $profileImage = "";
        if ($image = $request->file('gambar_produk')) {
            $destinationPath = 'folGambarProduk/';
            $profileImage = date('YmdHis') . "." . $image->getClientOriginalExtension();
            $image->move($destinationPath, $profileImage);
        }

        $data_insert = $request->all();
        $data_insert['gambar_produk'] = $profileImage;

        $create =  Paket::create($data_insert);
        if ($create) {
            return response()->json(['error' => false, 'msg' => 'insert data successfully']);
        } else {
            return response()->json(['error' => true, 'msg' => 'insert data unsuccessfully']);
        }
        // return response()->json(['mahasiswa' => Paket::all()]);
    }

    public function update(Request $request)
    {
        // dump("ini api update");
        // dd($request->all());
        $request->validate([
            'id_user' => 'required',
            'nama_paket' => 'required',
            'kecepatan' => 'required',
            'harga' => 'required',
            'disc' => 'required',
            'status' => 'required',
            'gambar_produk' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $profileImage = "";
        if ($image = $request->file('gambar_produk')) {
            $destinationPath = 'folGambarProduk/';
            $profileImage = date('YmdHis') . "." . $image->getClientOriginalExtension();
            $image->move($destinationPath, $profileImage);
        }

        $data_update = $request->all();
        $data_update['gambar_produk'] = $profileImage;

        $image = Paket::find($request->id_paket); //get dtlama

        $update = Paket::where('id_paket', $request->id_paket)->update($data_update);
        if ($update) {
            @unlink("folGambarProduk/" . $image->gambar_produk);

            return response()->json(['error' => false, 'msg' => 'update data successfully']);
        } else {
            return response()->json(['error' => true, 'msg' => 'update data unsuccessfully']);
        }
    }

    public function destroy($id)
    {
        $image = Paket::find($id);
        $del = Paket::where('id_paket', $id)->delete();
        if ($del) {
            @unlink("folGambarProduk/" . $image->gambar_produk);
            return response()->json(['error' => false, 'msg' => 'delete data successfully']);
        } else {
            return response()->json(['error' => true, 'msg' => 'delete data successfully']);
        }
    }
}
