
import json
from pathlib import Path

TOKEN_FILE = Path("credentials/token.json")

with TOKEN_FILE.open("r", encoding="utf-8") as file:
    token_data = json.load(file)

required_fields = [
    "token",
    "refresh_token",
    "token_uri",
    "client_id",
    "client_secret",
    "scopes",
]

print("GOOGLE OAUTH CREDENTIAL CHECK")
print("-" * 40)

for field in required_fields:
    value = token_data.get(field)
    status = "PRESENT" if value else "MISSING"
    print(f"{field}: {status}")

print("-" * 40)

if all(token_data.get(field) for field in required_fields):
    print("Credential structure check passed.")
else:
    print("Credential structure incomplete. Review required.")

import json
from pathlib import Path

TOKEN_FILE = Path("credentials/token.json")

with TOKEN_FILE.open("r", encoding="utf-8") as file:
    token_data = json.load(file)

required_fields = [
    "token",
    "refresh_token",
    "token_uri",
    "client_id",
    "client_secret",
    "scopes",
]

print("GOOGLE OAUTH CREDENTIAL CHECK")
print("-" * 40)

for field in required_fields:
    value = token_data.get(field)
    status = "PRESENT" if value else "MISSING"
    print(f"{field}: {status}")

print("-" * 40)

if all(token_data.get(field) for field in required_fields):
    print("Credential structure check passed.")
else:
    print("Credential structure incomplete. Review required.")
