variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "playground-s-11-1333cf00"
}
variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "acg-k8s-sandbox-cluster"
}
variable "env_name" {
  description = "The environment for the GKE cluster"
  default     = "test"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "europe-west1"
}
variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "acg-k8s-sandbox-network"
}
variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "acg-k8s-sandbox-acg-subnet"
}
variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}
variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-services"
}
