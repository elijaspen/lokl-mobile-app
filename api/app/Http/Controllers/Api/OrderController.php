<?php

namespace App\Http\Controllers\Api;

use App\Enums\OrderStatus;
use App\Enums\OrderType;
use App\Enums\UserRole;
use App\Http\Controllers\Controller;
use App\Http\Resources\OrderResource;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Str;
use Illuminate\Validation\Rules\Enum;

class OrderController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $user = $request->user();

        $query = Order::query();

        if ($user->role === UserRole::CUSTOMER) {
            $query->where('customer_id', $user->id);
        } elseif ($user->role === UserRole::RIDER) {
            $query->where('rider_id', $user->id);
        }

        return OrderResource::collection($query->latest()->get());
    }

    public function store(Request $request): OrderResource
    {
        $validated = $request->validate([
            'type' => ['required', new Enum(OrderType::class)],
            'category' => 'required|string',
            'description' => 'nullable|string',
            'origin_lat' => 'required|numeric',
            'origin_lng' => 'required|numeric',
            'origin_address' => 'required|string',
            'dest_lat' => 'required|numeric',
            'dest_lng' => 'required|numeric',
            'dest_address' => 'required|string',
            'fee' => 'required|numeric',
            'distance' => 'nullable|numeric',
        ]);

        $order = Order::create([
            ...$validated,
            'tracking_no' => 'LOKL-'.strtoupper(Str::random(6)),
            'status' => OrderStatus::PENDING,
            'customer_id' => $request->user()->id,
        ]);

        return new OrderResource($order);
    }

    public function show(Order $order): OrderResource
    {
        return new OrderResource($order);
    }
}
