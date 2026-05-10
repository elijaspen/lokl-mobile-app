<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'trackingCode' => $this->tracking_no,
            'type' => $this->type->value,
            'status' => $this->status->value,
            'category' => $this->category,
            'description' => $this->description,
            'fee' => (float) $this->fee,
            'distance' => (float) $this->distance,
            'origin' => [
                'lat' => (float) $this->origin_lat,
                'lng' => (float) $this->origin_lng,
                'address' => $this->origin_address,
            ],
            'destination' => [
                'lat' => (float) $this->dest_lat,
                'lng' => (float) $this->dest_lng,
                'address' => $this->dest_address,
            ],
            'createdAt' => $this->created_at?->toDateTimeString(),
        ];
    }
}
