import pandas as pd
from sqlalchemy import create_engine
df = pd.read_csv("trains.csv")
df = df.replace(" ' "," ", regex=True)
print(df.head())
# Remove duplicate rows (based on all columns)
df = df.drop_duplicates()
# fill the blank details with zero
df = df.fillna(0)
# Save the cleaned Excel file
df.to_csv("cleaned_trains.csv", index=False)
print("Updated CSV file saved successfully!")
username = "root"
password = "root"
host = "localhost"
port = "3306"
database = "trains"
engine = create_engine("mysql+pymysql://root:root@localhost:3306/trains")
df = pd.read_csv("cleaned_trains.csv")
table_name = "trains_data"
df.to_sql(table_name, con=engine, if_exists="replace", index=False)
print("CSV file successfully imported into the SQL database!")

