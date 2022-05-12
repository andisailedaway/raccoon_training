# Lookml Style Guide


This is your organization’s style guide for Looker’s LookML data modeling language. Looker and LookML define our business data model and provide a semantic layer for business intelligence. This style guide is designed to help make your LookML project more maintainable, easier to interpret and more DRY (Don’t Repeat Yourself).

These rules are opinionated, and might imply significant changes to the default view or model creation that has been developed organically. We provide rationales throughout to help understand how these rules will make your LookML and SQL reusable, self-explanatory, and reliable.

Whenever a rule says something “must” be done, there shouldn’t be any exceptions within your project. These are rules that need to be followed consistently since others will rely upon them being followed in their work elsewhere.

Whenever a rule says that something “should” be done, there may be reasons to deviate from these rules, and doing so will not break any assumptions elsewhere. Whenever the rule is not followed, a comment must be used to indicate the rationale to future readers of the code.

### General
DO

Use snake_case when naming all LookML objects: LookML files, explores, views, dimensions, measures, sets, etc.
Use headers to separate different LookML object types within a file (i.e. # DIMENSIONS, # MEASURES)
Use one blank line between each LookML object of the same type
Be verbose with object names (think Python variables), as LookML is a semantic layer which creates business user-facing objects
Don’t hide comments from end users! Clear labels, and descriptions are always a great thing
Define objects ONCE

DON’T

Change LookML object names without checking the content validator before pushing to production
Add new LookML files and objects without conforming to their corresponding styles
Prefixing objects with their type or some acronym (i.e. vw_ for views is not necessary)
Repeat yourself!

### Models

#### Model Parameters

DO

Specify the database connection name at the top of the file
Use include statements for each LookML object type according to its folder location
Include a default datagroup for each model by specifying persist_with a datagroup below the include statements
Include model parameters week_start_day as Sunday, and case_sensitive as No
Place Explores below all the top model parameters and below an “## EXPLORES ## header
Include two blank lines between each Explore
Place Data Tests below all the Explores and below a “## DATA TESTS ##” header
Include one blank line between each Data Test

DON’T

Specify Datagroups in model files, they should be placed in the separate datagroups file under the “shared” folder, such that they can potentially be referenced across models
Specify Access Grants in model files, they should be placed in the separate access_grants file under the “shared” folder, such that they can potentially be referenced across models
Specify Data Test in model files, they should be placed in the separate tests file under the “shared” folder, such that they can potentially be referenced across models

#### Shared Model Objects

DO

Include both a sql_trigger and a max_cache_age for all datagroups
Name datagroups based on both its use case or data source and cadence, i.e. facebook_daily_refresh

DON’T

Include datagroups or access grants within individual model files
Define datagroups with the same SQL trigger and max cache age as another datagroup, reuse the existing one
Define access grants for all departments unless necessary, define only when needed for governance and improved UX

### Explores

DO

Include the Explore-level parameters directly below the Explore name, then a blank line, then the joins
Name explores based on their primary object if a standard explore, or data source of a source-specific explore
Add a description for ALL Explores to help users understand when they should use that Explore
Add group labels to Explores to organize within the Explore dropdown
Name the Explore however you please, then use view_name to specify the actual view representing the base table of the Explore
Do not create new Explores arbitrarily, prefer enriching existing Explores (new Explores are warranted when starting at a different base table is necessary to account for all data in that table)
ALWAYS list the join fields in the same order as the relationship; from the table being joined to to the table currently being joined. This improves the understanding of the view relationships, which must be correct to avoid SQL fanout
Apply sql_always_where or always_filter to very large Explores where filtering should be encouraged (usually on a date field)
Use the fields parameter to hide fields unnecessary for that Explore from the end user
Use required_access_grant to only show certain explores to users who have a use case for it (not meant to hide data from users, more to improve UX for certain users by hiding things that don’t apply to their analytics needs)

DON’T

Forget to include a correctly defined relationship parameter for joins, and QA that relationship!
Add Explores that are in a development phase to the standard suite. Use a required_access_grant to hide it from general use until it is ready and validated
Use full_outer join types unless absolutely necessary, for performance and clarity reasons

#### Data Tests
Tests in Looker allow us to confirm that changes to our model don’t compile queries which return different outputs than the values that we know to be true. They are similar to unit tests in software development.

DO

Make the test name reflect what is being tested, such that the test result report speaks for itself
Build tests off of absolute values that we know to be true
Build tests off of categorical variables that we don’t expect to change
Build uniqueness tests if we expect uniqueness, but the value isn’t a primary key
Define tests in the shared tests LookML file

DON’T

Test based on ranges we expect from new data, which may be subject to change
Use tests as alerts (Looker has dashboard alerts for this)

### Views

#### View Files

DO

All view files MUST specify a primary_key for the dimension (or compound dimension) representing the primary key
View files should follow this order of object specification: SQL table name, parameters, dimensions, measures, sets
View names, if built off the raw Multi Site data, can be named based on its database table name (i.e. account)
View names, if built off another data source, should include the data source and table in its name (i.e. facebook_campaigns)

DON’T

Add views at the top level of the project - add to its appropriate view
Use the default LookML that Looker generates when choosing “Create View From Table”, edit LookML to match styles

#### Dimensions

DO

Name dimensions with real and descriptive names (i.e. campaign_status rather than cmpn_sts)
Add descriptions any time a dimension (physical or logical) is not obvious within the context of its view
Hide foreign keys, there is no analytics use case for them
Hide primary keys in almost every case; there may be a few rare exceptions, default to doing so
Group similar fields together, particularly in larger views, using group_label to improve user experience
Name yesno dimension with a verb best describing its use in the table (i.e. is_active, has_balance)
If repeating business logical for more than one dimension, create a hidden logical dimension that contains the logic, and reference that, such that you don’t need to change the logic in multiple places if it changes
Only reference the table’s column value (${TABLE}.value) ONCE across a view file. Reference its LookML pointer if used elsewhere
so if the column name changse we only need to change it in one place
Add labels any time a dimension can not be converted from snake_case to Title Case, particularly acronyms (i.e. LTV)
Hide dimensions that should only be viewed in aggregate to improve user experience (i.e. hide accrued_amount, build a total and/or average measure for it instead)
Include those hidden dimensions that you are aggregating in drill fields when applicable
Use required_access_grant to only show certain dimensions to users who have a use case for it (not meant to hide data from users, more to improve UX for certain users by hiding things that don’t apply to their analytics needs)

DON’T

Use the word “date” or “time” at the end of a time dimension group. The timeframe will be appended automatically to its name
Delete columns from the view. It is good to know what the table consists of in the LookML. Prefer to hide dimensions, or if never used you can comment out the dimension and include it below the view under an # Unused Fields header

#### Measures

DO

Use standard measure prefixes based on type if type is not number: count_, total_, average_, percent_, median_
Provide descriptions for all measures, unless the measure is trivial and its name describes it completely (i.e. count_accounts)
label KPI acronym measures to preserve appropriate capitalization and include the what the acronym stands for in the description (i.e. total_ltv should have a label of “Total LTV” and a description of at least “The sum of customer Life Time Value”)
Include a value_format_name for all measures
Include drill_fields for all measures unless there is a specific reason not to. Business users should be used to the ability to drill in deeper to enrich analytics
Group measures based on their use case when necessary for organization, similarily to dimensions
Reference the dimensions that are being aggregated upon by their LookML pointer, not the table column
Rename the default count measure to the table’s specific counted object (i.e. count_counselors, or hide the measure if a non-distinct count has no use case for the table
Use array syntax for measure filters ([]), rather than object syntax ({})

DON’T

Use value_format and specify a custom format with the value format syntax; use pre-built value_format_names
Build tons of measures arbitrarily, prefer constructing them when an analytics use case presents itself

#### Sets

DO

Use sets to define groups of fields when drilling, rather than listing them under drill_fields for dimensions and measures directly
Suffix sets with _detail if they are used for drilling
Suffix sets with _fields if grouping fields that are referenced from another table, if used to include or exclude them in Explores
List drill fields based on business user use cases; avoid foreign keys or unnecessary outputs

DON’T

List all dimensions for a detail set if the table is large, as the number of fields may be overwhelming to a user

### Derived Tables & SQL

DO

Derived table views should still follow all best practices of other views, don’t forget the primary key!
If derived tables require Liquid syntax, always keep in Looker
If derived tables do not require Liquid syntax and are non-trivial, move back in pipeline to Keboola for ETL
Prefer SQL that takes up more lines (rather than compacting logic for multiple output columns on the same line) for clarity’s sake
Be consistent with capitalization of SQL statements and operators

DON’T

Hide logic in a derived table; use descriptions to help end users understand built-in logic
Write output SQL as a “blob”, format SQL with the next developer in mind
