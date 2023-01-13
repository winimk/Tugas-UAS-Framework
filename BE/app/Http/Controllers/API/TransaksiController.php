<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Transaksi;
use App\Models\Paket;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;


class TransaksiController extends Controller
{
    public function index()
    {
        // $data = Transaksi::get();
        $data = Transaksi::join('users', 'transaksi.id_user', '=', 'users.id')
            ->get(['transaksi.*', 'users.name as nama_customer', DB::raw('(CASE WHEN users.role= "1" THEN "admin" WHEN users.role= "2" THEN "customer" ELSE "" END) as role')]);
        $output = array(
            'error' => false,
            'msg' => 'Data Berhasil Ditampilkan',
            'data' => $data
        );
        return $output;
    }

    public function get_by_id_user_cust($id)
    {
        $data = Transaksi::join('users', 'transaksi.id_user', '=', 'users.id')
            ->where('transaksi.id_user', '=', $id)
            ->get(['transaksi.*', 'users.name as nama_customer', DB::raw('(CASE WHEN users.role= "1" THEN "admin" WHEN users.role= "2" THEN "customer" ELSE "" END) as role')]);

        return response()->json(['error' => false, 'data' => $data]);
    }

    public function get_by_id_user_admin($id)
    {
        $data = Transaksi::join('paket', 'transaksi.id_paket', '=', 'paket.id_paket')
            ->join('users', 'paket.id_user', '=', 'users.id')
            ->where('paket.id_user', '=', $id)
            ->get(['transaksi.*', DB::raw('(CASE WHEN users.role= "1" THEN "admin" WHEN users.role= "2" THEN "customer" ELSE "" END) as role')]);

        return response()->json(['error' => false, 'data' => $data]);
    }

    // public function get_by_id_paket($id)
    // {
    //     // var_dump(Paket::find($id));
    //     // var_dump(Paket::where('id_paket', $id)->first()); 
    //     // die;

    //     return response()->json(['error' => false, 'data' => Paket::find($id)]);

    //     // return response()->json(['error' => false, 'data' => Paket::where('status', $id)->get()]);

    // }

    public function create(Request $request)
    {
        // var_dump($request->all());
        // die;
        $request->validate([
            'id_paket' => 'required',
            'id_user' => 'required',
            'lama' => 'required',
            'total' => 'required'
        ]);

        $lama = $request->lama;
        $total = $request->total;

        //get dt paket
        $dt_paket = Paket::find($request->id_paket);
        if ($dt_paket == null) {
            return response()->json(['error' => true, 'msg' => 'insert data unsuccessfully - Paket does not exist']);
        }
        $nama_paket = $dt_paket->nama_paket;
        $kecepatan = $dt_paket->kecepatan;
        $harga = $dt_paket->harga;
        $disc = $dt_paket->disc;

        //get dt user customer
        $dt_user = User::find($request->id_user);
        if ($dt_user == null) {
            return response()->json(['error' => true, 'msg' => 'insert data unsuccessfully - User Customer does not exist']);
        }
        $nama_user = $dt_user->name;
        $email = $dt_user->email;
        $alamat = $dt_user->alamat;
        $no_tlp = $dt_user->no_tlp;

        //current datetime
        $mytime = Carbon::now()->setTimezone('Asia/Jakarta');
        $tgl_transaksi = $mytime->toDateTimeString();


        //check total
        //Rumus 1
        // $jumlah_nominal = $harga * $lama;
        // $jumlah_diskon = $disc * $lama;
        // $htg_total = $jumlah_nominal - ($jumlah_nominal * ($jumlah_diskon / 100));

        // Rumus 2
        $harga_diskon = $harga - ($harga * ($disc / 100));
        $htg_total = $harga_diskon * $lama;

        if ($htg_total != $total) {
            return response()->json(['error' => true, 'msg' => 'insert data unsuccessfully - Total does not match']);
        }

        $insert = array(
            'id_paket'      => $request->id_paket,
            'id_user'       => $request->id_user,
            'nama_user'     =>  $nama_user,
            'email'         =>  $email,
            'alamat'        =>  $alamat,
            'no_tlp'        =>  $no_tlp,
            'tgl_transaksi' => $tgl_transaksi,
            'nama_paket'    => $nama_paket,
            'kecepatan'     => $kecepatan,
            'harga'         => $harga,
            'disc'          =>  $disc,
            'lama'          => $lama,
            'total'         => $htg_total,
        );

        $create =  Transaksi::create($insert);
        if ($create) {
            return response()->json(['error' => false, 'msg' => 'insert data successfully']);
        } else {
            return response()->json(['error' => true, 'msg' => 'insert data unsuccessfully']);
        }
    }

    // public function update(Request $request)
    // {
    //     // dd($request->all());
    //     $request->validate([
    //         'id_user' => 'required',
    //         'nama_paket' => 'required',
    //         'kecepatan' => 'required',
    //         'harga' => 'required',
    //         'disc' => 'required',
    //         'status' => 'required',
    //     ]);
    //     $update = Paket::where('id_paket', $request->id_paket)->update($request->all());
    //     if ($update) {
    //         return response()->json(['error' => false, 'msg' => 'update data successfully']);
    //     } else {
    //         return response()->json(['error' => true, 'msg' => 'update data unsuccessfully']);
    //     }
    // }
}
