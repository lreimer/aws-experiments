# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "jee_log_group" {
  name = "/ecs/jee-app"
  retention_in_days = 30

  tags = {
    Name = "jee-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "jee_log_stream" {
  name = "jee-log-stream"
  log_group_name = aws_cloudwatch_log_group.jee_log_group.name
}
