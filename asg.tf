#Configuracao do launch template

resource "aws_launch_template" "lt_asg" {
  name_prefix   = "launch-template"
  image_id      = aws_ami.ami_app.id 
  instance_type = var.instance_type 
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

}

#Cria o recurso do ASG
resource "aws_autoscaling_group" "asg" {
  name             = "asg"
  min_size         = 2  
  max_size         = 3  
  desired_capacity = 2  
  health_check_type = "ELB"
  vpc_zone_identifier = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_b.id] 


  launch_template {
    id      = aws_launch_template.lt_asg.id
    version = "$Latest"
  }

    tag {
    key                 = "Name"
    value               = "asg-terraform"
    propagate_at_launch = true
  }

}

#Cria uma associação do ASG com o ALB
resource "aws_autoscaling_attachment" "attachment_alb_asg" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.alb_target.arn
}