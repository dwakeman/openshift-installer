data "local_file" "create_ec2_resources" {
    filename = "${path.module}/data/create-ec2-resources.json"
}

data "local_file" "create_network_resources" {
    filename = "${path.module}/data/create-network-resources.json"
}

data "local_file" "create_elb_resources" {
    filename = "${path.module}/data/create-elb-resources.json"
}

data "local_file" "iam_resources" {
    filename = "${path.module}/data/iam-resources.json"
}

data "local_file" "create_route53_resources" {
    filename = "${path.module}/data/create-route53-resources.json"
}

data "local_file" "s3_resources" {
    filename = "${path.module}/data/s3-resources.json"
}

data "local_file" "operator_resources" {
    filename = "${path.module}/data/operator-permissions.json"
}

data "local_file" "delete_cluster_resources" {
    filename = "${path.module}/data/delete-cluster-resources.json"
}

data "local_file" "delete_network_resources" {
    filename = "${path.module}/data/delete-network-resources.json"
}

data "local_file" "create_manifests_permissions" {
    filename = "${path.module}/data/create-manifests.json"
}




resource "aws_iam_group" "openshift_installers" {
  name = "openshift-installers"
  path = "/"
}

resource "aws_iam_policy" "openshift_installer_ec2" {
  name        = "OpenShiftInstallEC2Resources"
  path        = "/"
  description = "Required EC2 permissions for installation"
  policy      = data.local_file.create_ec2_resources.content

}


resource "aws_iam_policy" "openshift_installer_create_network" {
  name        = "OpenShiftInstallCreateNetwork"
  path        = "/"
  description = "Required permissions for creating network resources during installation"
  policy      = data.local_file.create_network_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_create_network_attachment" {
  name       = "create-network-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_create_network.arn
}



resource "aws_iam_policy" "openshift_installer_elb" {
  name        = "OpenShiftInstallElasticLoadBalancing"
  path        = "/"
  description = "Required Elasticloadbalancing permissions for installation"
  policy      = data.local_file.create_elb_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_elb_attachment" {
  name       = "elb-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_elb.arn
}





resource "aws_iam_policy" "openshift_installer_iam" {
  name        = "OpenShiftInstallIAM"
  path        = "/"
  description = "Required IAM permissions for installation"
  policy      = data.local_file.iam_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_iam_attachment" {
  name       = "iam-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_iam.arn
}



resource "aws_iam_policy" "openshift_installer_route53" {
  name        = "OpenShiftInstallRoute53"
  path        = "/"
  description = "Required Route53 permissions for installation"
  policy      = data.local_file.create_route53_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_route53_attachment" {
  name       = "route53-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_route53.arn
}



resource "aws_iam_policy" "openshift_installer_S3" {
  name        = "OpenShiftInstallS3"
  path        = "/"
  description = "Required S3 permissions for installation"
  policy      = data.local_file.s3_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_s3_attachment" {
  name       = "s3-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_S3.arn
}



resource "aws_iam_policy" "openshift_installer_operators" {
  name        = "OpenShiftInstallOperators"
  path        = "/"
  description = "S3 permissions that cluster Operators require"
  policy      = data.local_file.operator_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_operators_attachment" {
  name       = "operators-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_operators.arn
}



resource "aws_iam_policy" "openshift_installer_delete_cluster" {
  name        = "OpenShiftInstallDeleteClusterResources"
  path        = "/"
  description = "Required permissions to delete base cluster resources"
  policy      = data.local_file.delete_cluster_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_delete_cluster_attachment" {
  name       = "delete-cluster-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_delete_cluster.arn
}



resource "aws_iam_policy" "openshift_installer_delete_network" {
  name        = "OpenShiftInstallDeleteNetworkResources"
  path        = "/"
  description = "Required permissions to delete network resources"
  policy      = data.local_file.delete_network_resources.content
}

resource "aws_iam_policy_attachment" "openshift_installer_delete_network_attachment" {
  name       = "delete-network-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_delete_network.arn
}



resource "aws_iam_policy" "openshift_installer_create_manifests" {
  name        = "OpenShiftInstallCreateManifests"
  path        = "/"
  description = "Additional IAM and S3 permissions that are required to create manifests"
  policy      = data.local_file.create_manifests_permissions.content
}

resource "aws_iam_policy_attachment" "openshift_installer_create_manifests_attachment" {
  name       = "create-manifests-attachment"
  groups     = [aws_iam_group.openshift_installers.name]
  policy_arn = aws_iam_policy.openshift_installer_create_manifests.arn
}




