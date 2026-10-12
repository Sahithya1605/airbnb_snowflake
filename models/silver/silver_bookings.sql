{{ config(
    materialized = 'incremental', 
    unique_key = 'booking_id'
) }}

SELECT 
    booking_id,
    listing_id,
    booking_date,
    {{ multiply('nights_booked', 'booking_amount', 2) }} + Cleaning_fee + Service_fee as total_amount,
    booking_status,
    created_at
FROM {{ ref('bronze_bookings') }}

{% if is_incremental() %}
    WHERE created_at > (SELECT COALESCE(MAX(created_at), '1900-01-01') FROM {{ this }})
{% endif %}
