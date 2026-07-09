output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution default domain name"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket hosting the site"
  value       = aws_s3_bucket.site.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket hosting the site"
  value       = aws_s3_bucket.site.arn
}
