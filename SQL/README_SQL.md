<h1 style="color:#6C3483; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; text-align:center;">
  SQL Scripts for Production Line Data Analysis
</h1>



<p style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 16px; color:#4A235A; max-width: 700px; margin:auto; line-height: 1.6;">
  This folder contains SQL scripts for creating table and analyzing production line status data based on assessment's questions.
</p>
<p style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 16px; color:#4A235A; max-width: 700px; margin:auto; line-height: 1.6;">
All SQL scripts are written for Microsoft SQL Server (T‑SQL).
</p>

<h2 style="color:#7D3C98; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 700px; margin: 30px auto 10px auto;">Scripts Included</h2>
<ul style="max-width: 700px; margin:auto; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 15px; color: #512E5F; line-height:1.5;">
  <li><strong>00_create_table.sql</strong>: Script to create the production_line_status table, which will be user to import data from given CSV file.</li> 
  <li><strong>01_production_sessions.sql</strong>: Outcome is the production process phases only for the production line 'gr-np-47'</li>
  <li><strong>02_uptime_downtime.sql</strong>: Calculates total uptime and total downtime durations for whole production floor.</li>
  <li><strong>03_most_downtime_line.sql</strong>: Finds the production line with the most downtime and returns the duration.</li>
</ul>

<h2 style="color:#7D3C98; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 700px; margin: 30px auto 10px auto;">
How to Use
</h2>
<ol style="max-width: 700px; margin:auto; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 15px; color: #512E5F; line-height:1.5;">
  <li>Run 00_create_table.sql on your data warehouse to create the necessary table.</li>
  <li>Import your production line CSV data into the production_line_status table.</li>
  <li>Run the analysis queries 01_production_sessions.sql, 02_uptime_downtime.sql, and 03_most_downtime_line.sql to get results on sessions, uptime, downtime, and greatest value of downtime in prod lines.</li>
</ol>

<p style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 16px; color: #4A235A; max-width: 700px; margin: 30px auto;">
Please refer to "DWH_implementation_guide.md" file, so as to check steps how to load the production line data into the SQL Server data warehouse.
</p>
