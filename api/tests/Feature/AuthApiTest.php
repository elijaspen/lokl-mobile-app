<?php

use App\Enums\UserRole;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\Sanctum;

uses(RefreshDatabase::class);

test('user can register', function () {
    $data = [
        'name' => 'John Doe',
        'email' => 'john@example.com',
        'password' => 'password123',
        'role' => UserRole::CUSTOMER->value,
    ];

    $response = $this->postJson('/api/register', $data);

    $response->assertStatus(200)
        ->assertJsonStructure(['access_token', 'user'])
        ->assertJsonPath('user.email', 'john@example.com')
        ->assertJsonPath('user.role', 'customer');
});

test('user can login', function () {
    $user = User::factory()->create([
        'email' => 'jane@example.com',
        'password' => Hash::make('password123'),
        'role' => UserRole::RIDER,
    ]);

    $data = [
        'email' => 'jane@example.com',
        'password' => 'password123',
    ];

    $response = $this->postJson('/api/login', $data);

    $response->assertStatus(200)
        ->assertJsonStructure(['access_token', 'user'])
        ->assertJsonPath('user.role', 'rider');
});

test('authenticated user can get their info', function () {
    $user = User::factory()->create(['role' => UserRole::CUSTOMER]);
    Sanctum::actingAs($user);

    $response = $this->getJson('/api/user');

    $response->assertStatus(200)
        ->assertJsonPath('email', $user->email);
});
