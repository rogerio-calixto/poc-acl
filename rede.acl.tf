#Publica

resource "aws_network_acl" "acl-pub" {
  vpc_id = module.vpc-acl.aws_vpc_id
  subnet_ids = module.vpc-acl.public-subnet_ids
  tags = {
    Name = "${local.projeto}-pub-${var.ambiente}"
  }
}

resource "aws_network_acl_rule" "acl_pub_allow_ingress_ssh" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 100
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
}

resource "aws_network_acl_rule" "acl_pub_allow_ingress_efemeras" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 150
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "acl_pub_allow_ingress_icmp_test" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 200
    egress = false
    protocol = "icmp"
    rule_action = "allow"
    # cidr_block = "0.0.0.0/0"
    cidr_block = "${local.vpc.cidr_block}"
    from_port = -1
    to_port = -1
    icmp_type = -1
    icmp_code = -1
}

resource "aws_network_acl_rule" "acl_pub_allow_egress_efemeras" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 100
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "acl_pub_allow_egress_http" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 150
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
}

resource "aws_network_acl_rule" "acl_pub_allow_egress_https" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 200
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443
}

resource "aws_network_acl_rule" "acl_pub_allow_egress_ssh" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 250
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
}

resource "aws_network_acl_rule" "acl_pub_allow_egress_icmp_test" {
    network_acl_id = "${aws_network_acl.acl-pub.id}"
    rule_number = 300
    egress = true
    protocol = "icmp"
    rule_action = "allow"
    # cidr_block = "0.0.0.0/0"
    cidr_block = "${local.vpc.cidr_block}"
    from_port = -1
    to_port = -1
    icmp_type = -1
    icmp_code = -1
}

#Privada

resource "aws_default_network_acl" "acl-pvt" {
  default_network_acl_id = module.vpc-acl.aws_vpc_default_network_acl_id

  lifecycle {
    ignore_changes = [subnet_ids, ingress, egress]
  }

  tags = {
    Name = "${local.projeto}-pvt-${var.ambiente}"
  }
}

resource "aws_network_acl_rule" "acl_pvt_allow_ingress_ssh" {
    network_acl_id = "${aws_default_network_acl.acl-pvt.id}"
    rule_number = 100
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
}

resource "aws_network_acl_rule" "acl_pvt_allow_ingress_efemeras" {
    network_acl_id = "${aws_default_network_acl.acl-pvt.id}"
    rule_number = 150
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "acl_pvt_allow_ingress_icmp_test" {
    network_acl_id = "${aws_default_network_acl.acl-pvt.id}"
    rule_number = 200
    egress = false
    protocol = "icmp"
    rule_action = "allow"
    cidr_block = "${local.vpc.cidr_block}"
    from_port = -1
    to_port = -1
    icmp_type = -1
    icmp_code = -1
}

resource "aws_network_acl_rule" "acl_pvt_allow_egress_efemeras" {
    network_acl_id = "${aws_default_network_acl.acl-pvt.id}"
    rule_number = 100
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "acl_pvt_allow_egress_icmp_test" {
    network_acl_id = "${aws_default_network_acl.acl-pvt.id}"
    rule_number = 150
    egress = true
    protocol = "icmp"
    rule_action = "allow"
    cidr_block = "${local.vpc.cidr_block}"
    from_port = -1
    to_port = -1
    icmp_type = -1
    icmp_code = -1
}