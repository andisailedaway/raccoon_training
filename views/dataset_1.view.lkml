# The name of this view in Looker is "Dataset 1"
view: dataset_1 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `raccoon_training.Dataset_1`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Bounces" in Explore.

  dimension: bounces {
    type: number
    sql: ${TABLE}.bounces ;;
  }

  dimension: combo_primary {
    primary_key: yes
    type: string
    sql: CONCAT(${year},${month}, ${channel}, ${campaign}) ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: leads {
    type: number
    sql: ${TABLE}.leads ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_bounces {
    type: sum
    sql: ${bounces} ;;
  }

  measure: average_bounces {
    type: average
    sql: ${bounces} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: users {
    type: sum
    sql: ${TABLE}.users ;;
  }
}
