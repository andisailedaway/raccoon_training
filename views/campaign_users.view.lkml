
view: campaign_users {

  sql_table_name: `raccoon_training.Dataset_1`;;


  dimension: bounces {
    type: number
    hidden: yes
    sql: ${TABLE}.bounces ;;
  }


  dimension: combo_primary {
    primary_key: yes
    description: "This is only used for a primary key."
    hidden: yes
    type: string
    sql: CONCAT(${year},${month}, ${channel}, ${campaign}) ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: channel {
    description: "Standard channel labels."
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

  dimension: year_month {
    type: string
    sql:  CONCAT(${year}, '-', ${month}) ;;

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

  measure: count {
    type: count
    drill_fields: []
  }

  measure: users {
    type: sum
    sql: ${TABLE}.users ;;
  }

  measure: total_bounces {
    type: sum
    group_label: "Bounces"
    sql: ${bounces} ;;
  }

  measure: average_bounces {
    type: average
    group_label: "Bounces"
    value_format: "#,###.00"
    sql: ${bounces} ;;
  }

  measure: average_bounces_Santos {
    type: average
    description: "Average Bounces only including the city of Santos."
    group_label: "Bounces"
    value_format: "#,###.00"
    sql: ${bounces} ;;
    filters: [city: "Santos"]
  }

  measure: min_bounces {
    type: min
    description: "Minimum bounces."
    group_label: "Bounces"
    sql: ${bounces} ;;
  }

  measure: max_bounces {
    type: max
    description: "Maximum bounces."
    group_label: "Bounces"
    sql: ${bounces} ;;
  }

}
