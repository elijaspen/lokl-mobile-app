<?php

namespace App\Models;

use App\Enums\OrderStatus;
use App\Enums\OrderType;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'tracking_no',
        'type',
        'status',
        'category',
        'description',
        'origin_lat',
        'origin_lng',
        'origin_address',
        'dest_lat',
        'dest_lng',
        'dest_address',
        'distance',
        'fee',
        'customer_id',
        'rider_id',
    ];

    /**
     * Get the customer that placed the order.
     */
    public function customer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    /**
     * Get the rider assigned to the order.
     */
    public function rider(): BelongsTo
    {
        return $this->belongsTo(User::class, 'rider_id');
    }

    protected function casts(): array
    {
        return [
            'status' => OrderStatus::class,
            'type' => OrderType::class,
            'fee' => 'decimal:2',
        ];
    }
}
