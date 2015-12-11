- connection: default_connection

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: events
  always_filter:
    events.created_at_time: last 3 months
  joins: 
    - join: sessions
      sql_on: |
        (timestamp 'epoch' + events.created_at::int * interval '1 second') >= 
        sessions.session_start_at
        AND
        (timestamp 'epoch' + events.created_at::int * interval '1 second') <
        sessions.next_session_start_at
        AND
        ${events.distinct_id} = ${sessions.distinct_id}
      relationship: many_to_one

