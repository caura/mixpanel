- view: sessions
  derived_table:
    sql: |
      WITH lag AS (
        SELECT
          e.distinct_id
          , e.id AS event_id
          , (timestamp 'epoch' + e.created_at::int * interval '1 second') AS created_at
          , DATEDIFF(
            minutes
            , LAG(timestamp 'epoch' + e.created_at::int * interval '1 second') OVER(PARTITION BY e.distinct_id ORDER BY (timestamp 'epoch' + e.created_at::int * interval '1 second') ASC)
            , (timestamp 'epoch' + e.created_at::int * interval '1 second')) 
            AS idle_time
        FROM public.mixpanel_looker_alooma AS e
      )
    
      SELECT 
        lag.event_id AS start_event_id 
        , lag.created_at AS session_start_at
        , lag.idle_time AS idle_time
        , lag.distinct_id
        , lag.distinct_id || ' - ' ||
          ROW_NUMBER() OVER(PARTITION BY lag.distinct_id ORDER BY lag.created_at ASC)
          AS session_id
        , ROW_NUMBER() OVER(PARTITION BY lag.distinct_id ORDER BY lag.created_at ASC)
          AS session_number
        , LAG(lag.created_at) OVER (PARTITION BY lag.distinct_id ORDER BY lag.created_at ASC)
          AS previous_session_start_at
        , LEAD(lag.created_at) OVER (PARTITION BY lag.distinct_id ORDER BY lag.created_at ASC)
          AS next_session_start_at
      --  , FIRST_VALUE(lag.channel) OVER (PARTITION BY lag.distinct_id ORDER BY lag.created_at ASC rows unbounded preceding)
      --    AS channel  
      FROM lag
      WHERE (lag.idle_time > 30 OR lag.idle_time IS NULL) 
    sql_trigger_value: SELECT CURRENT_DATE
    indexes: [session_start_at,next_session_start_at, distinct_id]
    distkey: distinct_id

  fields:
  - measure: count
    type: count
    drill_fields: mixpanel.sessions*
    
  - measure: average_duration
    type: avg
    sql: ${length}
    
  - dimension: session_id
    primary_key: true
    sql: ${TABLE}.session_id   
    
  - dimension: distinct_id

  - dimension: start_event_id
    type: number
    sql: ${TABLE}.start_event_id

  - dimension_group: start
    alias: session_start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_at

  - dimension: idle_time
    sql: ${TABLE}.idle_time

  - dimension: session_number
    type: number
    sql: ${TABLE}.session_number
    
  - dimension: length
    type: int
    sql: DATEDIFF(minutes, ${TABLE}.previous_session_start_at, ${TABLE}.session_start_at) - ${idle_time}

  - dimension: previous_session_start
    type: time
    timeframes: [time, date, week, month]  
    sql: ${TABLE}.previous_session_start_at
    
  - dimension: next_session_start
    type: time
    timeframes: [time, date, week, month]  
    sql: ${TABLE}.next_session_start_at    
    
  sets:
    detail:
      - start_event_id
      - session_start_at
      - idle_time
      - session_id
      - session_number
      - next_session_start