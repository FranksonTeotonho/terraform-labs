#---------------------------------
# Route53 Zone
#---------------------------------
data "aws_route53_zone" "selected" {
  name = var.hosted_zone
}

#---------------------------------
# Route53 record
#---------------------------------
resource "aws_route53_record" "my_record" {
  name    = var.cname
  type    = "CNAME"
  ttl     = 5
  zone_id = data.aws_route53_zone.selected.id
  records = [var.dns_name]
}