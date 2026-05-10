<?php

namespace Database\Factories;

use App\Enums\OrderStatus;
use App\Enums\OrderType;
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
            'tracking_no' => 'LL-'.strtoupper(fake()->bothify('??-####')),
            'type' => fake()->randomElement(OrderType::class),
            'status' => OrderStatus::PENDING,
            'category' => fake()->randomElement(['Food', 'Document', 'Parcel']),
            'description' => fake()->sentence(),
            'origin_lat' => fake()->latitude(14.5, 14.6),
            'origin_lng' => fake()->longitude(120.9, 121.1),
            'origin_address' => fake()->streetAddress().', '.fake()->city(),
            'dest_lat' => fake()->latitude(14.5, 14.6),
            'dest_lng' => fake()->longitude(120.9, 121.1),
            'dest_address' => fake()->streetAddress().', '.fake()->city(),
            'distance' => fake()->randomFloat(2, 0.5, 10),
            'fee' => fake()->randomFloat(2, 40, 200),
        ];
    }
}
