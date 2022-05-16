# The name of this view in Looker is "campaign_cost"
view: campaign_cost_gustavo {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `raccoon_training.Dataset_2`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Campaign" in Explore.

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

  dimension: channel_case {
    type: string
    sql:
      CASE
        WHEN REGEXP_CONTAINS(${TABLE}.channel,r'Google') THEN "Google"
        ELSE "Outros"
      END
    ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
  }

  measure: average_cost {
    type: average
    sql: ${cost} ;;
  }

  measure: campaign_filtered_total_cost {
    type: sum
    sql: ${cost} ;;
    filters: [campaign: "[RAC][INST] São Paulo"]
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: nested_field {
    type: string
    sql: ${TABLE}.nested_field ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
