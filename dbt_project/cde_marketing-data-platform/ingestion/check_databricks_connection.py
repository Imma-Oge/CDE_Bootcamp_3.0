from databricks.sdk import WorkspaceClient

PROFILE_NAME = "cde-marketing"

try:
    workspace = WorkspaceClient(profile=PROFILE_NAME)

    current_user = workspace.current_user.me()

    print("Databricks connection successful!")
    print(f"Authenticated user: {current_user.user_name}")
    print(f"Profile used: {PROFILE_NAME}")

except Exception as error:
    print("Databricks connection failed.")
    print(f"Error type: {type(error).__name__}")
    print(f"Error details: {error}")
