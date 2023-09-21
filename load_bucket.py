import os

from google.cloud import storage

# Provide the path to the service account key file
key_path = (
    "/users/sadamov/pyprojects/graphcast/spartan-setting-322712-8814b623085c.json"
)
dest_path = (
    "/scratch/e1000/meteoswiss/scratch/sadamov/pyprojects_data/graphcast/dm_graphcast"
)
storage_client = storage.Client.from_service_account_json(key_path)
bucket = storage_client.get_bucket("dm_graphcast")

blobs = bucket.list_blobs()

for blob in blobs:
    destination_file_name = dest_path + "/" + blob.name
    os.makedirs(os.path.dirname(destination_file_name), exist_ok=True)
    blob.download_to_filename(destination_file_name)
