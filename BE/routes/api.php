<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/register', [App\Http\Controllers\API\AuthController::class, 'register']);
//API route for login user
Route::post('/login', [App\Http\Controllers\API\AuthController::class, 'login']);

Route::get('/get_by_status_paket/{id}', [App\Http\Controllers\API\PaketController::class, 'get_by_status']);

//Protecting Routes
Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::post('/logout', [App\Http\Controllers\API\AuthController::class, 'logout']);

    Route::get('/get_all_paket', [App\Http\Controllers\API\PaketController::class, 'index']);
    Route::get('/get_by_id_paket/{id}', [App\Http\Controllers\API\PaketController::class, 'get_by_id']);
    Route::post('/create_paket', [App\Http\Controllers\API\PaketController::class, 'create']);
    Route::post('/update_paket', [App\Http\Controllers\API\PaketController::class, 'update']);
    Route::get('/delete_paket/{id}', [App\Http\Controllers\API\PaketController::class, 'destroy']);

    Route::get('/get_all_tran', [App\Http\Controllers\API\TransaksiController::class, 'index']);
    Route::get('/get_tran_by_customer/{id_cust}', [App\Http\Controllers\API\TransaksiController::class, 'get_by_id_user_cust']);
    Route::get('/get_tran_by_admin/{id_admin}', [App\Http\Controllers\API\TransaksiController::class, 'get_by_id_user_admin']);
    Route::post('/create_tran', [App\Http\Controllers\API\TransaksiController::class, 'create']);
});
