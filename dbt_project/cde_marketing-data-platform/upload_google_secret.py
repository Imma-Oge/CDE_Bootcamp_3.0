
import json
from pathlib import Path

from databricks.sdk import WorkspaceClient

# Databricks authentication configuration
PROFILE_NAME = "cde-marketing"
SECRET_SCOPE = "cde-marketing-ingestion"
SECRET_KEY = "google-drive-oauth-token"

# Existing local Google OAuth token
TOKEN_PATH = Path("credentials/token.json")

def main():
    # Read the local OAuth credentials
    with TOKEN_PATH.open("r", encoding="utf-8") as file:
        token_data = json.load(file)

    # Validate the credentials without printing secrets
    required_fields = [
        "token",
        "refresh_token",
        "token_uri",
        "client_id",
        "client_secret",
        "scopes",
    ]

    missing_fields = [
        field for field in required_fields
        if not token_data.get(field)
    ]

    if missing_fields:
        raise ValueError(
            f"Missing OAuth credential fields: {missing_fields}"
        )

    # Authenticate to Databricks using the CLI profile
    workspace = WorkspaceClient(profile=PROFILE_NAME)

    # Store the complete token JSON securely
    workspace.secrets.put_secret(
        scope=SECRET_SCOPE,
        key=SECRET_KEY,
        string_value=json.dumps(token_data),
    )

    print("Google OAuth credentials uploaded successfully!")
    print(f"Secret scope: {SECRET_SCOPE}")
    print(f"Secret key: {SECRET_KEY}")
    print("Credential values were not displayed.")

if __name__ == "__main__":
    main()
