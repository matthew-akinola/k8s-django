# # The entire section create a certiface, public zone, and validate the certificate using DNS method

# # Create the certificate using a wildcard for all the domains created in matthewtolu.tk
# resource "aws_acm_certificate" "matthew" {
#   domain_name       = "*.matthewtolu.tk"
#   validation_method = "DNS"
# }


# # validate the certificate through DNS method
# resource "aws_acm_certificate_validation" "matthewtolu" {
#   certificate_arn         = aws_acm_certificate.matthew.arn
#   validation_record_fqdns = [for record in aws_route53_record.matthewtolu : record.fqdn]
# }

# # selecting validation method
# resource "aws_route53_record" "matthewtolu" {
#   for_each = {
#     for dvo in aws_acm_certificate.matthew.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.matthew.zone_id
# }



# # create records for tooling
# resource "aws_route53_record" "tooling" {
#   zone_id = data.aws_route53_zone.matthew.zone_id
#   name    = "tooling.matthewtolu.tk"
#   type    = "A"

#   alias {
#     name                   = aws_lb.ingress.dns_name
#     zone_id                = aws_lb.ingress.zone_id
#     evaluate_target_health = true
#   }
# }

# # calling the hosted zone
# data "aws_route53_zone" "matthew" {
#   name         = "matthewtolu.tk"
#   private_zone = false
# }
