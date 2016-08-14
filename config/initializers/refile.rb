require 'refile/s3'

#aws = {
#  region:            'us-east-1',
#  access_key_id:     ENV['S3_ACCESS_KEY'],
#  secret_access_key: ENV['S3_SECRET_KEY'],
#  bucket:            ENV['S3_BUCKET_NAME'],
##}
#Refile.cache = Refile::S3.new(prefix: 'cache', **aws)
#Refile.store = Refile::S3.new(prefix: 'store', **aws)

Refile.cache = Refile::Backend::FileSystem.new("tmp/refile/cache")
Refile.store = Refile::Backend::FileSystem.new("tmp/refile/store")
