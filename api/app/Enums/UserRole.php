<?php

namespace App\Enums;

enum UserRole: string
{
    case CUSTOMER = 'customer';
    case RIDER = 'rider';
    case ADMIN = 'admin';
}
