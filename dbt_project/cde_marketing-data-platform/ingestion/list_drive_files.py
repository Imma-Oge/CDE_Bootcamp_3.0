
from pathlib import Path

from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build

# 1. Configuration
TOKEN_FILE = Path("credentials/token.json")
SCOPES = ["https://www.googleapis.com/auth/drive.readonly"]

PARENT_FOLDER_NAME = "dbt_project_sample_data"
SOURCE_FOLDERS = ["facebook", "snapchat"]

# 2. Authenticate
credentials = Credentials.from_authorized_user_file(
    str(TOKEN_FILE),
    scopes=SCOPES
)

service = build("drive", "v3", credentials=credentials)


# 3. Helper function to list all matching items
def list_items(query):
    items = []
    page_token = None

    while True:
        response = service.files().list(
            q=f"trashed = false and {query}",
            pageSize=100,
            pageToken=page_token,
            fields="nextPageToken, files(id, name, mimeType)",
        ).execute()

        items.extend(response.get("files", []))
        page_token = response.get("nextPageToken")

        if not page_token:
            break

    return items


# 4. Find the main folder
parent_folders = list_items(
    f"name = '{PARENT_FOLDER_NAME}' "
    "and mimeType = 'application/vnd.google-apps.folder'"
)

if len(parent_folders) != 1:
    raise RuntimeError(
        f"Expected one folder named {PARENT_FOLDER_NAME}, "
        f"found {len(parent_folders)}."
    )

parent_id = parent_folders[0]["id"]

print(f"Main folder: {PARENT_FOLDER_NAME}")
print(f"Folder ID: {parent_id}\n")


# 5. Discover Facebook and Snapchat files
total_csv_files = 0

for source_name in SOURCE_FOLDERS:

    folders = list_items(
        f"'{parent_id}' in parents "
        f"and name = '{source_name}' "
        "and mimeType = 'application/vnd.google-apps.folder'"
    )

    if len(folders) != 1:
        print(f"Expected one {source_name} folder, found {len(folders)}.")
        continue

    folder_id = folders[0]["id"]

    files = list_items(
        f"'{folder_id}' in parents"
    )

    csv_files = [
        file for file in files
        if file["name"].lower().endswith(".csv")
    ]

    print(f"\nSOURCE: {source_name.upper()}")
    print(f"CSV files found: {len(csv_files)}")
    print("-" * 45)

    for file in sorted(csv_files, key=lambda x: x["name"]):
        print(f"Name: {file['name']}")
        print(f"ID: {file['id']}")
        print("-" * 45)

    total_csv_files += len(csv_files)


# 6. Summary
print("\nINGESTION SOURCE DISCOVERY SUMMARY")
print(f"Total CSV files discovered: {total_csv_files}")

if total_csv_files == 9:
    print("Checkpoint passed: all 9 expected CSV files found.")
else:
    print("Checkpoint requires review: expected 9 CSV files.")
