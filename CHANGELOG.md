# Changelog

## v1.0.1

- Read the backend config region from `aws_s3_bucket.region` instead of `data.aws_region.current.name`. This removes the deprecation warning on AWS provider v6 and still works on v5.
- Remove the `aws_region.current` data source.

## v1.0.0

- First tagged release. It matches commit `beb5192`: S3 native state locking (`use_lockfile`), with no DynamoDB table.
