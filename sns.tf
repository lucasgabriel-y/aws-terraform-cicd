# Cria o tópico SNS
resource "aws_sns_topic" "asg_notifications" {
  name = "asg-notifications"
}

# Cria a assinatura do tópico para enviar notificações por e-mail
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.asg_notifications.arn
  protocol  = "email"
  endpoint  = var.sns_endpoint
}

# Configura a política do Auto Scaling Group para enviar notificações para o tópico SNS
resource "aws_autoscaling_notification" "asg_notification" {
  group_names = [aws_autoscaling_group.asg.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
  ]

  topic_arn = aws_sns_topic.asg_notifications.arn
}
