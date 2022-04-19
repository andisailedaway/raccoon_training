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

explore: dataset_1 {
  join: dataset_2 {
    type: left_outer
    sql_on: ${dataset_1.year} = ${dataset_2.year}
            AND ${dataset_1.month} = ${dataset_2.month}
            AND ${dataset_1.channel} = ${dataset_2.channel}
            AND ${dataset_1.campaign} = ${dataset_2.campaign};;
    relationship: many_to_one
  }

}

#explore: dataset_2 {}
