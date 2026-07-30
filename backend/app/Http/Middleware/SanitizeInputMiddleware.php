<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class SanitizeInputMiddleware
{
    public function handle(Request $request, Closure $next): Response
    {
        $clean = collect($request->all())->map(function ($value) {
            if (is_string($value)) {
                $value = trim($value);
                return preg_replace('/[\x00-\x1F\x7F]/u', '', $value);
            }

            return $value;
        })->toArray();

        $request->merge($clean);

        return $next($request);
    }
}
