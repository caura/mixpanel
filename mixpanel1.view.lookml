- view: mixpanel1
  sql_table_name: public.mixpanel1
  fields:

  - dimension: city
    sql: ${TABLE}.city

  - dimension: created_at
    type: number
    sql: ${TABLE}.created_at

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

