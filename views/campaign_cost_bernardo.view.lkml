view: campaign_cost_bernardo{

  sql_table_name: `raccoon_training.Dataset_2`;;

  dimension: combo_primary {
    primary_key: yes
    hidden: yes
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

  dimension: cost {
    type: number
    hidden: yes
    sql: ${TABLE}.cost ;;
  }

  measure: total_cost {
    type: sum
    group_label: "Cost"
    sql: ${cost} ;;
  }

  measure: average_cost {
    type: average
    group_label: "Cost"
    sql: ${cost} ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: nested_field {
    type: string
    hidden: yes
    sql: ${TABLE}.nested_field ;;
  }

  dimension: closed_reason {
    type: string
    sql: JSON_EXTRACT(${nested_field}, "$[0].value") ;;
  }

  dimension: closed_reason_id {
    type: string
    sql: JSON_EXTRACT(${nested_field}, "$[0].fieldId") ;;
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
