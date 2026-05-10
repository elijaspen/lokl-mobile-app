<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\OrderResource;
use App\Models\Order;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class OrderController extends Controller
{
    /**
     * List all orders for the mobile app.
     */
    public function index(): AnonymousResourceCollection
    {
        // Use the Resource collection to transform all 50 orders
        return OrderResource::collection(Order::latest()->get());
    }

    /**
     * Fetch a single order and transform it via the Resource.
     */
    public function show(Order $order): OrderResource
    {
        return new OrderResource($order);
    }
}
