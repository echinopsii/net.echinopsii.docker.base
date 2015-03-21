from cassandra.cluster import Cluster
import uuid

cluster = Cluster(['192.168.33.22'])
session = cluster.connect()

session.execute("CREATE KEYSPACE BOHistory WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 2 };")
session.execute("CREATE TABLE bohistory.deals (dealid varchar primary key,client varchar,product varchar,quantity int,price double);")

for i in range(1000):
  session.execute(
    """
    INSERT INTO bohistory.deals (dealid,client,product,quantity,price)
    VALUES (%(dealid)s,%(client)s,%(product)s,%(quantity)s,%(price)s)
    """,
    {'dealid': str(uuid.uuid1()),'client':'Ffrench', 'product': 'beer', 'quantity': 42, 'price':89.43}
  )
