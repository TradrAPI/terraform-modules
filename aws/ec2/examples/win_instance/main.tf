provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "default" {
  default = true
}

module "instance" {
  source = "../.."

  vpc_id = data.aws_vpc.default.id

  os_type = "windows"

  ami_filter = {
    owner = "amazon"
    name  = "Windows_Server-2019-English-Full-Base-2022.03.09"
  }

  win_admin_user = {
    name     = "WinAdmin"
    password = "@dmin01!"
  }

  key_pair = {
    name       = "win_test_instance"
    public_key = file("./files/testkey.pub")
  }

  user_data = <<-EOF
  # allow web server port traffic
  New-NetFirewallRule -DisplayName "ALLOW TCP PORT 8080" -Direction inbound -Profile Any -Action Allow -LocalPort 8080 -Protocol TCP

  # start web server
  $listener = New-Object System.Net.HttpListener
  $listener.Prefixes.Add('http://+:8080/')
  $listener.Start()

  try
  {
    while ($listener.IsListening) {  
      # process received request
      $context = $listener.GetContext()
      $Response = $context.Response
     
      # is there HTML content for this URL?
      $html = '<html><body>Hello world!</body></html>'
      # return the HTML to the caller
      $buffer = [Text.Encoding]::UTF8.GetBytes($html)
      $Response.ContentLength64 = $buffer.length
      $Response.OutputStream.Write($buffer, 0, $buffer.length)
      
      $Response.Close()
    }
  }
  finally
  {
    $listener.Stop()
  }
  EOF

  resources_prefix            = "test-instance"
  name                        = "test-instance"
  type                        = "t3.micro"
  associate_public_ip_address = true
  root_volume_size            = 50
  root_volume_type            = "gp2"

  tags = {
    Environment = "Testing"
  }
}


resource "aws_security_group_rule" "ingress_8080" {
  security_group_id = module.instance.sg.id

  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_rdp" {
  security_group_id = module.instance.sg.id

  type      = "ingress"
  from_port = 3389
  to_port   = 3389
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

output "this" {
  value = module.instance
}
