- view: events
  sql_table_name: public.mixpanel_looker_alooma
#   derived_table:
#     sql: |
#       SELECT 
#         * 
#         , ROW_NUMBER() OVER (ORDER BY created_at ASC) AS id
#       FROM public.mixpanel_looker_alooma
#     sql_trigger_value: 
#     indexes: [created_at]
#     distkey: [event]
    
  fields:

  - dimension: id
    primary_key: true
    sql: ${TABLE}.id
    
  - dimension: distinct_id

  - dimension: city
    sql: ${TABLE}.city

  - dimension_group: created_at
    type: time
    timeframes: [time, hour, date,week,month]
    sql: ${TABLE}.created_at
    datatype: epoch

  - dimension: current_url
    sql: ${TABLE}.current_url

  - dimension: event
    sql: ${TABLE}.event

  - dimension: initial_referring_domain
    sql: ${TABLE}.initial_referring_domain

  - dimension: initital_referring_domain
    sql: ${TABLE}.initital_referring_domain

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: region
    sql: ${TABLE}.region

  - measure: count
    type: count
    drill_fields: []

  - measure: count_unique_visitors
    type: count_distinct
    sql: ${distinct_id}
