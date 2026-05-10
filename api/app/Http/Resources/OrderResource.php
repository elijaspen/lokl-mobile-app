<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Order
 */
class OrderResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            // DB (snake_case) -> API (camelCase)
            'id' => $this->id,
            'trackingCode' => $this->tracking_no,
            'status' => $this->status->value, // Accesses the Enum string
            'fee' => (float) $this->fee,

            // Geographical Data for Flutter Maps
            'origin' => [
                'lat' => (float) $this->origin_lat,
                'lng' => (float) $this->origin_lng,
            ],
            'destination' => [
                'lat' => (float) $this->dest_lat,
                'lng' => (float) $this->dest_lng,
            ],

            // readable dates
            'createdAt' => $this->created_at?->toDateTimeString(),
        ];
    }
}
