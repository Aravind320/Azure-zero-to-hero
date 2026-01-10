# AKS vs. Self-Managed Kubernetes Clusters

This repository provides a comprehensive comparison between **Azure Kubernetes Service (AKS)** and **Self-Managed Kubernetes Clusters** (on-premises or on Cloud VMs). This guide is designed for DevOps engineers to use as revision notes or architectural decision-making documentation.

---

## 🚀 Deployment Architectures

There are three primary ways to architect a Kubernetes environment:

1. **On-Premises Self-Managed:** Full ownership of physical hardware. Built using virtualization (like OpenStack). Best for high-security, air-gapped environments.
2. **Azure VM Self-Managed (Kubeadm/Terraform):** Manual installation of the Control Plane on standard Azure VMs. You handle the "plumbing" but leverage cloud infrastructure.
3. **Azure Kubernetes Service (AKS):** A managed service where Azure handles the Control Plane (API Server, etcd) for you, and you manage only the worker nodes.



---

## 📊 Feature Comparison Table

| Feature | Self-Managed (On-Prem/VMs) | Azure Managed (AKS) |
| :--- | :--- | :--- |
| **Control Plane** | Managed by you (High overhead) | Managed by Azure (Zero overhead) |
| **Maintenance** | Manual OS & K8s patching | Automated patch & minor version upgrades |
| **Scaling** | Manual VM provisioning | Auto-scaling via VM Scale Sets (VMSS) |
| **Integrations** | Manual setup for LB & Storage | Native Entra ID, Key Vault, & Azure Monitor |
| **Flexibility** | 100% (Full access to Master nodes) | Limited (Master nodes are abstracted) |
| **Cost** | High (Pay for all nodes + Ops time) | Efficient (Pay only for worker nodes) |

---

## 🔍 Deep Dive Analysis

### 🛠 Maintenance & Upgrades
* **Self-Managed:** You are responsible for the entire lifecycle. This includes upgrading the Kubernetes version (Patch, Minor, and Major streams) and patching the underlying Linux OS for security vulnerabilities (CVEs).
* **AKS:** Provides **Automatic Upgrade Channels**. You can schedule maintenance windows where Azure automatically applies patches to keep the cluster secure without manual intervention.

### 📈 Scaling & High Availability
* **Self-Managed:** Achieving High Availability (HA) requires manually setting up at least 3 Master nodes and configuring external load balancers.
* **AKS:** HA is built-in. By using **Virtual Machine Scale Sets (VMSS)**, the cluster can automatically scale the number of worker nodes up or down based on real-time CPU and Memory demand.



### 🔗 Ecosystem Integration
* **Self-Managed:** Integrations are difficult. Setting up a "Load Balancer" service on-premises is complex because the Cloud Controller Manager doesn't have a native provider (often requires tools like MetalLB).
* **AKS:** Features "Out-of-the-Box" integration with Azure-native tools:
    * **Azure Entra ID:** For RBAC and Identity.
    * **Azure Monitor:** For container insights and logging.
    * **CSI Drivers:** For automated mounting of Azure Disks and Files.

---

## 💡 Decision Matrix: Which to choose?

* **Choose AKS if:** You are a startup or a team that wants to focus on **building applications** rather than managing infrastructure. It significantly reduces the "Human Ops" cost and simplifies day-2 operations.
* **Choose Self-Managed if:** You require deep customization of the Kubernetes internal components (e.g., custom API Server flags) or have strict regulatory requirements that forbid the use of public managed cloud services.

---
*Based on the Azure 0 to Hero series by Abhishek Veeramalla.*
