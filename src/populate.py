import psycopg2

def connect_db():
    return psycopg2.connect(
        dbname="example",
        user="postgres",
        password="postgres",
        host="localhost", # 127.0.0.1
        port="5433",
    )

def create_table():
    with connect_db() as conn:
        with conn.cursor() as cur:
            cur.execute("""
                CREATE TABLE IF NOT EXISTS mytable (
                    id SERIAL PRIMARY KEY,
                    data TEXT NOT NULL
                )
            """)
            conn.commit()

def insert_data(data: str):
    with connect_db() as conn:
        with conn.cursor() as cur:
            cur.execute("INSERT INTO mytable (data) VALUES (%s)", (data,))
            conn.commit()

def fetch_data():
    with connect_db() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT id, data FROM mytable")
            rows = cur.fetchall()
            for row in rows:
                print(row)

if __name__ == "__main__":
    create_table()
    insert_data("Some data")
    fetch_data()
