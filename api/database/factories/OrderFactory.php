<?php

namespace Database\Factories;

use App\Enums\OrderStatus;
use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Order>
 */
class OrderFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'tracking_no' => 'LL-' . strtoupper(fake()->bothify('??-####')),
            'status' => OrderStatus::PENDING,
            'origin_lat' => fake()->latitude(10.7, 10.8),
            'origin_lng' => fake()->longitude(122.5, 122.6),
            'dest_lat' => fake()->latitude(10.7, 10.8),
            'dest_lng' => fake()->longitude(122.5, 122.6),
            'fee' => fake()->randomFloat(2, 40, 200),
        ];
    }
}
