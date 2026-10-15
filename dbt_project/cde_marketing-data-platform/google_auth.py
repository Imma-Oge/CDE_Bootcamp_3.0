from pathlib import Path
from google_auth_oauthlib.flow import InstalledAppFlow

# Request read-only access to Google Drive
SCOPES = [
    "https://www.googleapis.com/auth/drive.readonly"
]

# Locate our OAuth client configuration
CLIENT_FILE = Path("credentials/google_oauth_client.json")

# Initialize Google's OAuth authorization flow
flow = InstalledAppFlow.from_client_secrets_file(
    str(CLIENT_FILE),
    scopes=SCOPES
)

# Open a browser for Google authorization
credentials = flow.run_local_server(port=0)

# Save the resulting credentials locally
TOKEN_FILE = Path("credentials/token.json")
TOKEN_FILE.write_text(credentials.to_json())
TOKEN_FILE.chmod(0o600)

print("Google Drive authentication successful!")