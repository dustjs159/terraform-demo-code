resource "aws_instance" "web_instance" {
    ami = "${var.ami_id}"
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = [ "${var.sg_id}" ] # List
    associate_public_ip_address = true
    instance_type = "t3.nano"
    root_block_device {
        volume_size           = "10"
        volume_type           = "gp3"
        delete_on_termination = true
    }
    user_data = <<-EOF
        #!/bin/bash
        apt-get update && apt-get upgrade -y
        apt-get install nginx -y
        echo "<h1> Hello nginx Web Server! Host : $(hostname)" > /var/www/html/index.nginx-debian.html
        nginx_conf="/etc/nginx/nginx.conf"
        uncommented_line="server_tokens off"
        sed -i "s/# $uncommented_line/$uncommented_line/" $nginx_conf
        systemctl restart nginx && systemctl enable nginx
        sleep 10
        EOF
    tags = {
        Name = "prod-web-instance"
    }
}

resource "aws_eip" "web_public_ip" {
    domain   = "vpc"
    instance = aws_instance.web_instance.id
}