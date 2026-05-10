<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Enums\OrderStatus;

/**
 * @method static \Illuminate\Database\Eloquent\Builder|Order latest()
 * @method static \Illuminate\Database\Eloquent\Builder|Order query()
 * @mixin \Illuminate\Database\Eloquent\Builder
 */
class Order extends Model
{
    use HasFactory;

    protected function casts(): array
    {
        return [
            'status' => OrderStatus::class,
            'fee' => 'decimal:2',
        ];
    }
}
