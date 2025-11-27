--create table to insert production line status
CREATE TABLE production_line_status (
    production_line_id NVARCHAR(100),
    status NVARCHAR(10),
    timestamp DATETIME
)

-- Note: Import your CSV data into this table using your DWH import methods.
