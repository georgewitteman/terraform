output "certificate_arn" {
  description = "ARN of the certificate"
  value       = acm_certificate.this.arn
}
