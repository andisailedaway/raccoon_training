# Define the database connection to be used for this model.
connection: "sunlit_descent"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: raccoon_data_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: raccoon_data_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Raccoon Data"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: campaign_users {
  label: "Campaign Data"
  join: campaign_cost {
    type: left_outer
    sql_on: ${campaign_users.year} = ${campaign_cost.year}
            AND ${campaign_users.month} = ${campaign_cost.month}
            AND ${campaign_users.channel} = ${campaign_cost.channel}
            AND ${campaign_users.campaign} = ${campaign_cost.campaign};;
    relationship: many_to_one
  }
  }
