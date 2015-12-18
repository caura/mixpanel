- dashboard: welcome
  title: Welcome
  layout: tile
  tile_size: 100

#  filters:

  elements:

  - name: add_a_unique_name_1450476438608
    title: "Event Funnel"
    type: looker_column
    model: mixpanel
    explore: events
    dimensions: [events.event]
    measures: [events.count]
    filters:
      events.created_at_time: 3 months
    sorts: [events.count desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_dropoff: true
    width: 6
    
  - name: add_a_unique_name_1450476629162
    title: 'Top 10 Refers'
    type: table
    model: mixpanel
    explore: events
    dimensions: [events.referrer]
    measures: [events.count]
    filters:
      events.created_at_time: ''
    sorts: [events.count desc]
    limit: 10
    show_view_names: true
    show_row_numbers: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    show_dropoff: true
    
  - name: add_a_unique_name_1449796710824
    title: "Events by Region in the U.S.A"
    type: looker_geo_choropleth
    model: mixpanel
    explore: events
    dimensions: [events.region]
    measures: [events.count]
    filters:
      events.created_at_time: ''
    sorts: [events.count desc]
    limit: 500
    map: usa
    show_view_names: true
    width: 6    
    
  - name: add_a_unique_name_1449797209146
    title: 'Visitors by Hour and Month-Over-Month Percent Change'
    type: looker_column
    model: mixpanel
    explore: events
    dimensions: [events.created_at_month]
    measures: [events.count_unique_visitors]
    dynamic_fields:
    - table_calculation: pct_change_month_over_month_positive
      label: Pct Change Month over Month - Positive
      expression: if(round(100.0*${events.count_unique_visitors}/offset(${events.count_unique_visitors},-1)-100.0,2)>=0,round(100.0*${events.count_unique_visitors}/offset(${events.count_unique_visitors},-1)-100.0,2),null)
      value_format: 0.00\%
    - table_calculation: pct_change_month_over_month_negative
      label: Pct Change Month over Month - Negative
      expression: if(round(100.0*${events.count_unique_visitors}/offset(${events.count_unique_visitors},-1)-100.0,2)<0,round(100.0*${events.count_unique_visitors}/offset(${events.count_unique_visitors},-1)-100.0,2),null)
      value_format: 0.00\%
    filters:
      events.created_at_time: ''
    sorts: [events.created_at_month]
    limit: 500
    query_timezone: America/Los_Angeles
    colors: [grey, green, red]
    label_density: 25
    legend_position: center
    series_types:
      events.unique_visitors: line
      __FILE: mixpanel/welcome.dashboard.lookml
      __LINE_NUM: 144
    show_y_axis_labels: true
    y_axis_labels: [Unique Visitors, Day-over-Day Percent Change, (Negative)]
    y_axis_tick_density: default
    show_x_axis_label: true
    x_axis_label: Visits by Hour, Past 4 Days
    x_axis_scale: auto
    y_axis_orientation: [left, right, right]
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_ticks: true
    y_axis_tick_density_custom: 5
    show_x_axis_ticks: true
    ordering: none
    show_null_labels: false
    width: 6
    
  - name: add_a_unique_name_1449798010680
    title: 'Session Dynamics: Average Duration and Unique Visitors'
    type: looker_line
    model: mixpanel
    explore: events
    dimensions: [sessions.session_number]
    measures: [sessions.average_duration, events.count_unique_visitors]
    filters:
      events.created_at_time: ''
    sorts: [sessions.session_number]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    hidden_series: [sessions.max_duration]
    width: 12