<h1 style="font-family: Arial, sans-serif; color:#2C3E50;">
  Production Line Analysis – Technical Documentation
</h1>

<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  This document describes the technical design and implementation of the production line analysis solution, covering both Python notebook and SQL scripts.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">1. Problem Overview</h2>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  The goal is to analyze production line status events recorded over time in order to return production sessions (start–stop periods) for each line, calculate total uptime and downtime, and identify the production line with the highest downtime.
</p>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  The input is a CSV file containing records per production line.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">2. Data Model</h2>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">2.1 Source data</h3>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  The source file dataset.csv</code> contains:
</p>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>production_line_id</code>: Identifier of the production line.</li>
  <li>status</code>: Status at the given timestamp (START, STOP, ON).</li>
  <li>timestamp</code>: Time when the status was recorded.</li>
</ul>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">2.2 DWH table</h3>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  In the DWH, data is stored in the table production_line_status</code> with the same fields:
</p>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>production_line_id</code> (NVARCHAR)</li>
  <li>status</code> (NVARCHAR)</li>
  <li>timestamp</code> (DATETIME)</li>
</ul>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  Indexes on production_line_id</code> and timestamp</code> can be added to speed up time‑based analysis.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">3. Python Solution (folder: python/</code>)</h2>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">3.1 Purpose</h3>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  The notebook production_sessions.ipynb</code> provides a Python implementation of the business logic given the CSV file. It is used for analysis, validation of the logic, and to demonstrate the steps clearly.
</p>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">3.2 Main functionality</h3>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>Loads dataset.csv</code> using pandas</code>.</li>
  <li>Cleans and sorts events by production_line_id</code> and timestamp</code>.</li>
  <li>Iterates through events to:
    <ul>
      <li>Build production sessions (START → STOP) with calculated duration.</li>
      <li>Accumulate uptime and downtime based on status changes.</li>
      <li>Aggregate downtime per production line and find the line with the highest downtime.</li>
    </ul>
  </li>
</ul>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  The functions are written to be readable and easy to port into a production ETL or DWH environment if needed.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">4. SQL Solution (folder: sql/</code>)</h2>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">4.1 Table creation</h3>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  00_create_table.sql</code> creates the production_line_status</code> table used as the core fact table for analysis.
</p>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">4.2 Analysis queries</h3>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  The following scripts answer the business questions using SQL:
</p>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li><strong>01_production_sessions.sql</code></strong>: For a given production line, pairs each START event with the next STOP event and returns session start, stop, and duration.</li>
  <li><strong>02_uptime_downtime.sql</code></strong>: Joins each status event to the next event for the same line and sums the time differences to compute total uptime (status = 'ON') and downtime (status &lt;&gt; 'ON').</li>
  <li><strong>03_most_downtime_line.sql</code></strong>: Calculating downtime per line and returns the line with the highest total downtime.</li>
</ul>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">4.3 Implementation guide</h3>
<p style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  DWH_implementation_guide.md describes how to create the schema and table in the DWH, load the CSV into production_line_status</code>, deploy views (or stored procedures) based on the analysis queries, and integrate the results into BI tools.
</p>

<h2 style="font-family: Arial, sans-serif; color:#1F618D;">5. How to Run</h2>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">5.1 Python</h3>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6;">
  <li>Open the python</code> folder in your preferred environment (PyCharm, VS Code, Jupyter).</li>
  <li>Ensure Python and pandas</code> are installed.</li>
  <li>Open production_sessions.ipynb</code> and run the cells from top to bottom; the notebook reads dataset.csv</code> from the same folder.</li>
</ul>

<h3 style="font-family: Arial, sans-serif; color:#2874A6;">5.2 SQL</h3>
<ul style="font-family: Arial, sans-serif; font-size: 15px; color:#34495E; line-height:1.6%;">
  <li>Execute 00_create_table.sql</code> in your DWH.</li>
  <li>Load dataset.csv</code> into production_line_status</code>.</li>
  <li>Run 01_production_sessions.sql</code>, 02_uptime_downtime.sql</code>, and 03_most_downtime_line.sql</code> to reproduce the analysis.</li>
</ul>


