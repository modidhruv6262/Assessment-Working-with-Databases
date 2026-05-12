import pandas as pd
import numpy as np
from sqlalchemy import create_engine

def clean_and_normalize_zomato(file_path, db_uri):
    print("Extracting data...")
    df = pd.read_csv(file_path)
    engine = create_engine(db_uri)

    df['rate'] = df['rate'].replace(['NEW', '-'], np.nan)
    df['rate'] = df['rate'].astype(str).str.replace('/5', '').str.strip()
    df['rate'] = pd.to_numeric(df['rate'], errors='coerce')
    
    if 'approx_cost(for two people)' in df.columns:
        df['approx_cost'] = df['approx_cost(for two people)'].astype(str).str.replace(',', '')
        df['approx_cost'] = pd.to_numeric(df['approx_cost'], errors='coerce')
    
    df['online_order'] = df['online_order'].map({'Yes': True, 'No': False})
    df['book_table'] = df['book_table'].map({'Yes': True, 'No': False})

    print("Transforming to 3NF and Loading...")
    
    locations = df[['location', 'listed_in(city)']].drop_duplicates().dropna()
    locations.columns = ['location_name', 'listed_in_city']
    locations.to_sql('locations', con=engine, if_exists='append', index=False)
    
    loc_db = pd.read_sql('SELECT location_id, location_name FROM locations', con=engine)
    df = df.merge(loc_db, left_on='location', right_on='location_name', how='left')

    restaurants = df[['name', 'address', 'phone', 'online_order', 'book_table', 'approx_cost', 'location_id']].copy()
    restaurants.columns = ['name', 'address', 'phone', 'online_order', 'book_table', 'approx_cost_for_two', 'location_id']
    restaurants.to_sql('restaurants', con=engine, if_exists='append', index=False)
    
    rest_db = pd.read_sql('SELECT restaurant_id, name, location_id FROM restaurants', con=engine)
    df = df.merge(rest_db, on=['name', 'location_id'], how='left')

    ratings = df[['restaurant_id', 'rate', 'votes']].dropna(subset=['restaurant_id'])
    ratings.to_sql('ratings', con=engine, if_exists='append', index=False)

    print("Pipeline Execution Complete. Data is fully normalized.")

if __name__ == "__main__":
    DB_URI = 'mysql+pymysql://username:password@localhost/food_tech_analytics'
    clean_and_normalize_zomato('zomato.csv', DB_URI)