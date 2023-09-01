# Cria o recurso para a declaração dos IPs
resource "aws_wafv2_ip_set" "ip_set" {
  name               = "conjunto-IPs"
  description        = "Determina um conjunto de IPs"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"

  addresses = [
    "170.82.180.128/32"
  ]
}

# Cria uma ACL para liberar o acesso a partir de IPs autorizados
resource "aws_wafv2_web_acl" "tf_waf" {
  name        = "tf-acl-waf"
  description = "Permite o acesso a partir de um bloco de IPs autorizados"
  scope       = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "ip-rule"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ip_set.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAFMetrics"
      sampled_requests_enabled   = true
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "metric"
    sampled_requests_enabled   = false
  }
}

# Cria uma associação do ALB com o WAF
resource "aws_wafv2_web_acl_association" "waf_alb" {
  resource_arn = aws_lb.tf_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.tf_waf.arn
}