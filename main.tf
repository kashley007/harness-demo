module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  name = "hello-world-sample-app"
  # Launch configuration
  lc_name = "example-lc"
  image_id        = "ami-06b263d6ceff0b3dd"
  instance_type   = "t2.micro"
  security_groups = ["sg-7dbdd301"]
  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]
  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]
  # Auto scaling group
  asg_name                  = "hello-world-asg"
  vpc_zone_identifier       = ["subnet-0057306ea704c21c7", "subnet-0057306ea704c21c7"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  user_data_base64 = "echo 'hello world'"
  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]
  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
