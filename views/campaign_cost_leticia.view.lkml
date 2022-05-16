view: campaign_cost_leticia {

  sql_table_name:  `raccon_training.Dataset_2`;;

  dimension: campaign {
    type:  string
    sql:  ${TABLE}.campaign ;;
  }

  dimension: cost {
    type: number
    hidden:  yes
    sql:  ${TABLE}.cost ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: month {
    type:  string
    sql:  ${TABLE}.month ;;
  }

  dimension: year {
    type:  number
    sql: ${TABLE}.year ;;
  }

  dimension:  combo_primary {
    primary_key:  yes
    hidden:  yes
    type:  string
    sql:  CONCAT(${year},${month}, ${channel}, ${campaign}) ;;
  }

  measure: count {
    type:  count
    drill_fields: []
  }

  measure : total_cost {
    type:  sum
    group_label: "Cost"
    sql:  ${cost} ;;
  }

  measure: average_cost {
    type: average
    group_label: "Cost"
    sql: ${cost} ;;
  }

  measure: campaign_filtered_total_cost {
    type: sum
    sql: ${cost} ;;
    filters: [campaign: "[RAC] [DISC] Ribeirão Preto"]
  }

  dimension: nested_field {
    type: string
    sql: ${TABLE}.nested_field ;;
  }


  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: campaign_cost_leticia {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
