<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class JobResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'type' => $this->type->value,
            'payout' => (float) $this->fee,
            'distance' => (float) $this->distance,
            'startLocation' => $this->origin_address,
            'endLocation' => $this->dest_address,
            'category' => $this->category,
            'description' => $this->description,
        ];
    }
}
