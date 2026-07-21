provider "aws" {
  region = "us-east-1"
  
}

data "aws_iam_users" "users" {}

data "aws_caller_identity" "current" {}

resource "aws_iam_user" "new"{
    name = "admin-user-${data.aws_caller_identity.current.account_id}"
    path="/system/"
}

output "len_users"{
    value=length(data.aws_iam_users.users.names)
}

output "current"{
    value=data.aws_iam_users.users.names
}



