provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      TerraformWorkspace = "terraform-modules/aws/network/examples/tgw_switch"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  alias  = "tgw"

  default_tags {
    tags = {
      TerraformWorkspace = "terraform-modules/aws/network/examples/tgw_switch"
    }
  }
}
