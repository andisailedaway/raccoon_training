# The name of this view in Looker is "Dataset 1"
view: campaign_users {
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

  dimension: month_num {
    type: string
    #hidden: yes
    sql:  CASE WHEN ${TABLE}.month = 'Janeiro' THEN '01'
                WHEN ${TABLE}.month = 'Fevereiro' THEN '02'
                WHEN ${TABLE}.month = 'Março' THEN '03'
                WHEN ${TABLE}.month = 'Abril' THEN '04'
                WHEN ${TABLE}.month = 'Maio' THEN '05'
                WHEN ${TABLE}.month = 'Junho' THEN '06'
                WHEN ${TABLE}.month = 'Julho' THEN '07'
                WHEN ${TABLE}.month = 'Agosto' THEN '08'
                WHEN ${TABLE}.month = 'Setembro' THEN '09'
                WHEN ${TABLE}.month = 'Outubro' THEN '10'
                WHEN ${TABLE}.month = 'Novembro' THEN '11'
                WHEN ${TABLE}.month = 'Dezembro' THEN '12'
                ELSE ${TABLE}.month
          END;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension: year_num {
    type: number
    hidden: yes
    sql: ${TABLE}.year ;;
  }

  dimension_group: date {
    type: time
    datatype: yyyymmdd
    timeframes: [year, quarter, month]
    sql: CAST(CONCAT(${year_num}, ${month_num},'01') AS INT) ;;
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
