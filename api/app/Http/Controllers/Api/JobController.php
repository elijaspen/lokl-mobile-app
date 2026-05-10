<?php

namespace App\Http\Controllers\Api;

use App\Enums\OrderStatus;
use App\Http\Controllers\Controller;
use App\Http\Resources\JobResource;
use App\Http\Resources\OrderResource;
use App\Models\Order;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class JobController extends Controller
{
    public function index(): AnonymousResourceCollection
    {
        $jobs = Order::where('status', OrderStatus::PENDING)
            ->latest()
            ->get();

        return JobResource::collection($jobs);
    }

    public function accept(Order $order): OrderResource
    {
        if ($order->status !== OrderStatus::PENDING) {
            abort(400, 'This job is no longer available.');
        }

        $order->update([
            'status' => OrderStatus::ACCEPTED,
            'rider_id' => request()->user()->id,
        ]);

        return new OrderResource($order);
    }
}
