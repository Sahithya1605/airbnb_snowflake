{{ config(materialized = 'incremental', unique_key = 'host_id') }}

SELECT host_id, 
replace(host_name, '', '_') as host_name,
host_since  as host_since,
is_superhost as is_superhost,
response_rate as response_rate,
case 
when response_rate > 95 then 'very good'
when response_rate > 80 then 'good'
when response_rate > 60 then 'medium'
else 'bad' 
end as response_rate_tag,
created_at as created_at 
from {{ ref('bronze_hosts') }}

