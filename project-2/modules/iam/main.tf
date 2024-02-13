resource "aws_iam_role" "web_role" {
    name = "web-instance-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            },
        ]
    })
    managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", 
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]
}