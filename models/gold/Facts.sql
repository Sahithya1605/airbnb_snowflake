{% set configs = [
    {
        "table": ref('obt'),
        "columns": "gold_obt.booking_id, gold_obt.listing_id, gold_obt.host_id, gold_obt.total_amount, gold_obt.accommodates, gold_obt.bathrooms, gold_obt.bedrooms, gold_obt.price_per_night, gold_obt.response_rate",
        "alias": "gold_obt"
    },
    {
        "table": ref('dim_listings'),
        "columns": "",
        "alias": "gold_listings",
        "join_condition": "gold_obt.listing_id = gold_listings.listing_id"
    },
    {
        "table": ref('dim_hosts'),
        "columns": "",
        "alias": "gold_hosts",
        "join_condition": "gold_obt.host_id = gold_hosts.host_id"
    }
] %}

SELECT
    {{ configs[0]['columns'] }}
FROM
{% for config in configs %}
    {% if loop.first %}
        {{ config.table }} AS {{ config.alias }}
    {% else %}
        LEFT JOIN {{ config.table }} AS {{ config.alias }}
            ON {{ config.join_condition }}
    {% endif %}
{% endfor %}
