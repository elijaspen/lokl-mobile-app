<?php

use App\Enums\OrderType;
use App\Enums\UserRole;
use App\Models\Order;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;

uses(RefreshDatabase::class);

test('can list orders', function () {
    $user = User::factory()->create(['role' => UserRole::CUSTOMER]);
    Sanctum::actingAs($user);

    Order::factory()->count(3)->create(['customer_id' => $user->id]);

    $response = $this->getJson('/api/orders');

    $response->assertStatus(200)
        ->assertJsonCount(3, 'data')
        ->assertJsonStructure([
            'data' => [
                '*' => [
                    'id',
                    'trackingCode',
                    'status',
                    'category',
                    'fee',
                    'distance',
                    'origin' => ['lat', 'lng', 'address'],
                    'destination' => ['lat', 'lng', 'address'],
                    'createdAt',
                ],
            ],
        ]);
});

test('can create an order', function () {
    $user = User::factory()->create(['role' => UserRole::CUSTOMER]);
    Sanctum::actingAs($user);

    $data = [
        'type' => OrderType::DELIVERY->value,
        'category' => 'Food',
        'origin_lat' => 14.5547,
        'origin_lng' => 121.0244,
        'origin_address' => 'SM North EDSA',
        'dest_lat' => 14.5794,
        'dest_lng' => 121.0359,
        'dest_address' => 'Ayala Malls Vertis North',
        'fee' => 150.00,
        'distance' => 1.2,
    ];

    $response = $this->postJson('/api/orders', $data);

    $response->assertStatus(201);
    $this->assertDatabaseHas('orders', [
        'category' => 'Food',
        'origin_address' => 'SM North EDSA',
        'customer_id' => $user->id,
    ]);
});

test('can show an order', function () {
    $user = User::factory()->create(['role' => UserRole::CUSTOMER]);
    Sanctum::actingAs($user);

    $order = Order::factory()->create(['customer_id' => $user->id]);

    $response = $this->getJson("/api/orders/{$order->id}");

    $response->assertStatus(200)
        ->assertJsonPath('data.id', $order->id);
});
