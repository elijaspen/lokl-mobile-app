<?php

namespace App\Enums;

enum OrderStatus: string
{
    case PENDING = 'pending';
    case ACCEPTED = 'accepted';
    case TRANSIT = 'in_transit';
    case ARRIVED = 'arrived';
    case COMPLETED = 'completed';
    case CANCELLED = 'cancelled';
}
