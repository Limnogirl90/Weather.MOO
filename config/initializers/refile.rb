require 'refile/s3'

aws = {
  access_key_id: ENV['S3_ACCESS_KEY'], # 'xyz',
  secret_access_key: ENV['S3_SECRET_KEY'], # 'abc',
  region: ENV['S3_REGION'], # 'sa-east-1',
  bucket: ENV['S3_BUCKET_NAME'], # 'fish-bucket',
}
Refile.cache = Refile::S3.new(prefix: 'cache', **aws)
Refile.store = Refile::S3.new(prefix: 'store', **aws)
