<?php

namespace Database\Seeders;

use App\Enums\OrderStatus;
use App\Enums\OrderType;
use App\Enums\UserRole;
use App\Models\Order;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Admin Account
        User::factory()->create([
            'name' => 'System Admin',
            'email' => 'admin@lokl.com',
            'password' => Hash::make('password123'),
            'role' => UserRole::ADMIN,
        ]);

        // Customer Account
        $customer = User::factory()->create([
            'name' => 'John Customer',
            'email' => 'customer@lokl.com',
            'password' => Hash::make('password123'),
            'role' => UserRole::CUSTOMER,
        ]);

        // Rider Account
        $rider = User::factory()->create([
            'name' => 'Flash Rider',
            'email' => 'rider@lokl.com',
            'password' => Hash::make('password123'),
            'role' => UserRole::RIDER,
        ]);

        // Sample customer orders
        Order::factory(5)->create([
            'customer_id' => $customer->id,
            'status' => OrderStatus::PENDING,
        ]);

        // Sample rider accepted jobs
        Order::factory(3)->create([
            'customer_id' => $customer->id,
            'rider_id' => $rider->id,
            'status' => OrderStatus::ACCEPTED,
            'type' => OrderType::ERRAND,
            'description' => 'Pick up groceries from SM Supermarket.',
        ]);

        // Global pending jobs
        Order::factory(15)->create([
            'status' => OrderStatus::PENDING,
            'customer_id' => User::factory()->create(['role' => UserRole::CUSTOMER])->id,
        ]);
    }
}
