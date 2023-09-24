# create output to see name
output "randomly_gen_name" {
  value = random_string.bucket_name.id
}
