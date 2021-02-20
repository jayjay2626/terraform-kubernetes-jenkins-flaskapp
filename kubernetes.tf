terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

# variable "host" {
#   type = string
# }

# variable "client_certificate" {
#   type = string
# }

# variable "client_key" {
#   type = string
# }

# variable "cluster_ca_certificate" {
#   type = string
# }

provider "kubernetes" {
  // I added this line because of TLS failed error. 
  // Then, comment out the rest of those 4 lines
  config_path = "~/.kube/config"

  # host = var.host

  # client_certificate     = var.client_certificate
  # client_key             = var.client_key
  # cluster_ca_certificate = var.cluster_ca_certificate
}
resource "kubernetes_deployment" "flaskapp" {
  metadata {
    name = "scalable-flaskapp-example"
    labels = {
      App = "ScalableFlaskAppExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableFlaskAppExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableFlaskAppExample"
        }
      }
      spec {
        container {
          image = "rangeley826/flask-docker-app-jenkins:latest"
          name  = "flaskapp"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "flaskapp" {
  metadata {
    name = "flaskapp-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.flaskapp.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
