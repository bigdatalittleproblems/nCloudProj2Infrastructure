provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
# resource "kubernetes_namespace" "test" {
#   metadata {
#     name = "nginx"
#   }
# }
# resource "kubernetes_deployment" "test" {
#   metadata {
#     name        = "external-dns"
#   }
#   spec {
#     strategy = {type:"Recreate"}
#     selector {
#       match_labels = {
#         app = "external-dns"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "external-dns"
#         }
#       annotations = {"iam.amazonaws.com/role": aws_iam_role.AllowExternalDNSUpdates_role.arn} 
#       }
#       spec {
#         container {
#           name  = "external-dns"
#           image = "k8s.gcr.io/external-dns/external-dns:v0.7.6"
#           args =[

#           ]
#         }
#       }
#     }
#   }
# }
# resource "kubernetes_service" "test" {
#   metadata {
#     name      = "nginx"
#     namespace = kubernetes_namespace.test.metadata.0.name
#   }
#   spec {
#     selector = {

#       app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
#     }
#     type = "LoadBalancer"
#     port {
#       # node_port   = 30201
#       port        = 80
#       target_port = 80
#     }
#   }
# }