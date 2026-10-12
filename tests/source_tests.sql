{{ config(
    severity = 'warning'
}}
select 1
from {{ source('staging','bookings') }}
Where booking_amount < 200