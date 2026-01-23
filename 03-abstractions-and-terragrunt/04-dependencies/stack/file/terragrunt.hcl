terraform {
  source = "../../modules/s3-file"
}

dependency "s3_bucket" {
  config_path = "../bucket"
}

inputs = {
  bucket_name = dependency.s3_bucket.outputs.bucket_name
  key         = "foo.txt"
  content     = "foo bar"
}
