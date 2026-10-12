{% macro trimmer(col_name) %}
    upper(trim({{ col_name }}))
{% endmacro %}
