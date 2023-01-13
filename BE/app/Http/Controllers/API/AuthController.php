<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Auth;
use Validator;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        // header("Access-Control-Allow-Origin: *");
        // header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
        // header('Access-Control-Allow-Credentials: true');
        // header('Access-Control-Allow-Headers: X-Requested-With, Origin, Content-Type, X-Auth-Token, Accept');

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
            'alamat' => 'required|string',
            'no_tlp' => 'required|numeric',
        ]);


        // var_dump($request->all());
        // die;
        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $user = User::create([
            'name' => $request->name,
            'alamat' => $request->alamat,
            'no_tlp' => $request->no_tlp,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => 2,
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        $dtuser = User::where('email', $request['email'])
            ->select(['users.*', DB::raw('(CASE WHEN users.role= "1" THEN "admin" WHEN users.role= "2" THEN "customer" ELSE "" END) as role')])
            ->firstOrFail();

        return response()
            ->json(['error' => false, 'data' => $dtuser, 'access_token' => $token, 'token_type' => 'Bearer',]);
    }

    public function login(Request $request)
    {
        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()
                ->json(['message' => 'Unauthorized'], 401);
        }

        $user = User::where('email', $request['email'])
            ->select(['users.*', DB::raw('(CASE WHEN users.role= "1" THEN "admin" WHEN users.role= "2" THEN "customer" ELSE "" END) as role')])
            ->firstOrFail();
        // if ($user->role == 1) {
        //     $role = "admin";
        // } else if ($user->role == 2) {
        //     $role = "customer";
        // }
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()
            ->json(['error' => false, 'message' => 'Hi ' . $user->name . ', welcome to home', 'access_token' => $token, 'data' => $user, 'token_type' => 'Bearer',]);
    }

    // method for user logout and delete token
    public function logout()
    {
        auth()->user()->tokens()->delete();

        return [
            'error' => false,
            'message' => 'You have successfully logged out and the token was successfully deleted'
        ];
    }
}
