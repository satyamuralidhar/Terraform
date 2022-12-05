resource "random_id" "rand" {
  byte_length = 2
}
# resource "aws_s3_bucket" "mybucket" {
#   bucket = "mybucket-new-${random_id.rand.dec}"

#   tags = {
#     Name = format("%s-%s", var.env, "bucket")
#   }
# }

# resource "aws_s3_bucket_acl" "myacl" {
#   bucket = aws_s3_bucket.mybucket.id
#   acl    = "private"
# }