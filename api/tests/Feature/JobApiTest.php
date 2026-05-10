<?php

use App\Enums\OrderStatus;
use App\Enums\UserRole;
use App\Models\Order;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;

uses(RefreshDatabase::class);

test('can list available jobs', function () {
    $rider = User::factory()->create(['role' => UserRole::RIDER]);
    Sanctum::actingAs($rider);

    // Create 2 pending orders (available jobs)
    Order::factory()->count(2)->create(['status' => OrderStatus::PENDING]);
    // Create 1 accepted order (not available)
    Order::factory()->create(['status' => OrderStatus::ACCEPTED]);

    $response = $this->getJson('/api/jobs');

    $response->assertStatus(200)
        ->assertJsonCount(2, 'data')
        ->assertJsonStructure([
            'data' => [
                '*' => [
                    'id',
                    'payout',
                    'distance',
                    'startLocation',
                    'endLocation',
                    'category',
                ],
            ],
        ]);
});

test('rider can accept a job', function () {
    $rider = User::factory()->create(['role' => UserRole::RIDER]);
    Sanctum::actingAs($rider);

    $order = Order::factory()->create(['status' => OrderStatus::PENDING]);

    $response = $this->postJson("/api/jobs/{$order->id}/accept");

    $response->assertStatus(200)
        ->assertJsonPath('data.status', OrderStatus::ACCEPTED->value);

    $this->assertEquals(OrderStatus::ACCEPTED, $order->refresh()->status);
    $this->assertEquals($rider->id, $order->rider_id);
});

test('cannot accept an already accepted job', function () {
    $rider = User::factory()->create(['role' => UserRole::RIDER]);
    Sanctum::actingAs($rider);

    $order = Order::factory()->create(['status' => OrderStatus::ACCEPTED]);

    $response = $this->postJson("/api/jobs/{$order->id}/accept");

    $response->assertStatus(400);
});
