resource "kubernetes_service" "minio" {
  metadata {
    name      = "minio"
    namespace = kubernetes_namespace.minio-dev.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.minio.metadata.0.labels.app
    }
    port {
      port        = 9001
      target_port = 9001
    }
    type = "ClusterIP"
  }
  provisioner "local-exec" {
    command = "kubectl create -f minio-in.yml"
  }
}

