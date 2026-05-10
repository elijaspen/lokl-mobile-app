<?php

namespace App\Enums;

enum OrderType: string
{
    case DELIVERY = 'delivery';
    case ERRAND = 'errand';
}
