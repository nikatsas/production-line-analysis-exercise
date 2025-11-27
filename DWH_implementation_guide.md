<h1 style="font-family: Arial, sans-serif; color:#2C3E50;">
  Implementation Guide: SQL Solution for Production Line Analysis
</h1>

<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  This guide describes the steps to implement the SQL production line analysis solution into the DWH.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Overview</h2>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  The solution ingests production line status events from a CSV file, stores them in a fact table, and provides SQL queries to analyze production sessions, uptime/downtime, and identify prod lines with the most downtime.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Step 1: Prepare the Database Schema</h2>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>Identify or create a schema in the DWH for production monitoring data.</li>
  <li>Ensure DE team have permissions to use/alter tables in this schema.</li>
</ul>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Step 2: Create the Core Fact Table</h2>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  Execute the 00_create_table.sql</code> script in the DWH environment to create the production_line_status</code> table.
</p>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  Table includes:
</p>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>production_line_id</code> (NVARCHAR): Unique identifier for each production line.</li>
  <li>status</code> (NVARCHAR): Status code (START, STOP, ON, OFF).</li>
  <li>timestamp</code> (DATETIME): Event timestamp when status was recorded.</li>
</ul>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  Consider adding indexes on production_line_id</code> and timestamp</code> columns to optimize query performance if needed.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Step 3: Load CSV Data into the Table</h2>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>Place the source CSV file (dataset.csv</code>) in the DWH staging area.</li>
  <li>Use the DWH's load utility to import data. For example:
    <ul>
      <li>SQL Server: BULK INSERT</code> or SSIS.</li>
      <li>Azure Synapse: COPY INTO</code> command.</li>
      <li>Snowflake: COPY INTO</code> from stage.</li>
    </ul>
  </li>
  <li>Ensure the CSV delimiter (";" in our dataset) is specified correctly during import.</li>
  <li>Validate data load success by checking row counts.</li>
</ul>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Step 4: Data Quality and Standardization</h2>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  After initial load, run validation checks:
</p>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>Ensure no null values in production_line_id</code> or timestamp</code>.</li>
  <li>Verify status</code> accept specific values (START, STOP, ON, OFF).</li>
  <li>Check for duplicates in production line (concerning timestamps).</li>
</ul>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Step 5: Deploy Analytical SQL Objects</h2>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  Deploy 3 analysis queries as reusable database objects.
</p>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">Option A: Create Views</h3>
<pre style="background-color:#F4F6F6; padding:10px; border-radius:4px; font-family: Consolas, 'Courier New', monospace; font-size: 13px;">
-- View for production sessions
CREATE VIEW v_production_sessions AS
SELECT ... FROM production_line_status ... ;

-- View for total uptime/downtime
CREATE VIEW v_uptime_downtime AS
SELECT ... FROM production_line_status ... ;

-- View for line with most downtime
CREATE VIEW v_most_downtime_line AS
SELECT ... FROM production_line_status ... ;
</pre>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  Views are better because of easy access for BI tools and maintain a single source of logic.
</p>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">Option B: Create Stored Procedures</h3>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  If parameterization is needed (e.g. filter by date range or specific line), insert scripts in stored procedures that accept parameters and return results.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Step 6: Integrate with BI and Reporting Tools</h2>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6%;">
  <li>Connect your BI platform (Qlik Sense, Power BI, Tableau etc.) to the DWH and expose the newly created views or procedures.</li>
  <li>Create dashboards or reports showing.</li>
  <li>Schedule reports refresh to be aligned with data load frequency.</li>
</ul>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">Step 7: Documentation</h2>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6%;">
  <li>Document the table schema, views, and their business logic purpose in the DWH data catalog.</li>
  <li>Link this implementation guide and the SQL scripts in the internal documentation (e.g. Confluence DE team’s Space).</li>
</ul>
