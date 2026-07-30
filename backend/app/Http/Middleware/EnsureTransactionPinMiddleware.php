<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class EnsureTransactionPinMiddleware
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        if (!$user || empty($user->pin_hash)) {
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'PIN_NOT_SET',
                    'message' => 'Transaction PIN is not set.',
                ],
            ], 403);
        }

        $pin = (string) $request->input('transaction_pin', '');

        if ($pin === '' || !Hash::check($pin, $user->pin_hash)) {
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INVALID_PIN',
                    'message' => 'Invalid transaction PIN.',
                ],
            ], 422);
        }

        return $next($request);
    }
}
