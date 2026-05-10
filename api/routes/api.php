<?php

use App\Http\Controllers\Api\OrderController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

/**
 * Order Management Endpoints
 */
Route::controller(OrderController::class)->group(function () {
    // GET /api/orders - Fetches the list of all 50+ orders
    Route::get('/orders', 'index');

    // GET /api/orders/{order} - Fetches detailed info for a single order
    Route::get('/orders/{order}', 'show');
});
