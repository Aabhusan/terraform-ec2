output "tls_private_key_for_ec2" {
  value = "${tls_private_key.ec2.private_key_pem}"
}