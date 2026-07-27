# Phoenix CI environment variables

# Log directory
export PHOENIX_LOG_DIR="${PHOENIX_LOG_ARTIFACTS}"

# S3

## Artifacts
export PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE='/opt/celenity/celenity-artifacts-s3-access-key.txt'
export PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE='/opt/celenity/celenity-artifacts-s3-bucket-name.txt'
export PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE='/opt/celenity/celenity-artifacts-s3-endpoint.txt'
export PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE='/opt/celenity/celenity-artifacts-s3-secret-key.txt'

## Releases
export PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE='/opt/celenity/celenity-releases-s3-access-key.txt'
export PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE='/opt/celenity/celenity-releases-s3-bucket-name.txt'
export PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE='/opt/celenity/celenity-releases-s3-endpoint.txt'
export PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE='/opt/celenity/celenity-releases-s3-secret-key.txt'
