resource "kubernetes_namespace" "minio-dev" {
  metadata {
    annotations = {
      name = "minio-dev"
    }
    name = "minio-dev"
  }
}
resource "kubernetes_persistent_volume_claim" "minio" {
  metadata {
    name      = "minio"
    namespace = "minio-dev"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "openebs-jiva-csi-sc"
  }
}

resource "kubernetes_deployment" "minio" {
  metadata {
    name      = "minio"
    namespace = "minio-dev"
    labels = {
      app = "minio"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "minio"
      }
    }
    template {
      metadata {
        labels = {
          app = "minio"
        }
      }
      spec {
        volume {
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.minio.metadata.0.name
          }
          name = "minio"
        }
        container {
          image   = "quay.io/minio/minio:latest"
          name    = "minio"
          command = ["/bin/bash", "-c"]
          args    = ["minio server /data --console-address :9001"]
          volume_mount {
            name       = "minio"
            mount_path = "/data"
          }
        }
      }
    }
  }
}

