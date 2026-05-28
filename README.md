# 🛡️ Trivy — The Complete Practical Guide

> An end-to-end guide to container, filesystem, repository, cloud, and Kubernetes security scanning with [Trivy](https://github.com/aquasecurity/trivy).

[![Trivy](https://img.shields.io/badge/Powered%20by-Trivy-1904DA?logo=aqua&logoColor=white)](https://github.com/aquasecurity/trivy)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![DevSecOps](https://img.shields.io/badge/DevSecOps-Ready-blue)]()

---

## 📖 About

This repository is a **complete, hands-on guide** to using Trivy for security scanning across the entire DevSecOps lifecycle — from your laptop to your cloud account, from a single Dockerfile to a multi-tenant Kubernetes cluster.

It is written for engineers who want to **actually use Trivy**, not just read about it. Every concept is paired with a runnable command, and every chapter includes the *why* before the *how*.

---

## ✨ What's Inside

- 🐳 **Container image scanning** — Docker, OCI, ECR, GCR, private registries
- 📁 **Filesystem & repository scanning** — local folders and remote GitHub repos
- ☸️ **Kubernetes cluster scanning** — live clusters and continuous coverage with Trivy Operator
- ☁️ **Cloud account scanning** — AWS services like S3, IAM, EC2
- 💻 **VM image scanning** — AMI, VMDK, OVA formats
- 🔐 **Secrets detection** — API keys, tokens, passwords, private keys
- 📜 **SBOM generation** — CycloneDX and SPDX formats
- ✅ **Compliance scanning** — CIS, NSA, PCI-DSS, HIPAA benchmarks
- ⚖️ **License scanning** — open-source license auditing
- 🛠️ **Misconfiguration scanning** — Terraform, Kubernetes, Dockerfile, CloudFormation
- 🚀 **CI/CD integrations** — Jenkins, GitHub Actions, GitLab CI, Azure DevOps
- 🎯 **IDE integration** — VS Code extension setup
- 🏢 **Enterprise features** — server mode, air-gapped deployments, performance tuning

---

## 🚀 Quick Start

### Install Trivy

<details>
<summary><b>Linux (Ubuntu / Debian)</b></summary>

```bash
sudo apt-get install -y wget gnupg

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
  | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg

echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] \
  https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
  | sudo tee /etc/apt/sources.list.d/trivy.list

sudo apt-get update
sudo apt-get install -y trivy
```
</details>

<details>
<summary><b>macOS</b></summary>

```bash
brew install trivy
```
</details>

<details>
<summary><b>Windows</b></summary>

```bash
choco install trivy
```
</details>

### Verify

```bash
trivy --version
```

### Your First Scan

```bash
# Scan a public Docker image
trivy image python:3.10

# Focus on what matters: High/Critical issues with available fixes
trivy image --severity HIGH,CRITICAL --ignore-unfixed python:3.10
```

---

## 📚 Table of Contents

| # | Chapter | Topic |
|---|---------|-------|
| 1 | What Is Trivy? | Introduction and overview |
| 2 | Installation | Linux, macOS, Windows setup |
| 3 | How Trivy Works | Architecture, data pipeline, CVSS |
| 4 | Basic Image Scanning | Public and private images |
| 5 | Essential Flags | `--severity`, `--vuln-type`, `--exit-code`, `--ignore-unfixed` |
| 6 | Local Docker Workflow | End-to-end shift-left example |
| 7 | HTML Reports | Polished output for stakeholders |
| 8 | Secrets Scanning | Detecting leaked credentials |
| 9 | Repository Scanning | Local and remote Git repos |
| 10 | SBOMs | CycloneDX and SPDX generation |
| 11 | Kubernetes Scanning | `trivy k8s` + Trivy Operator |
| 12 | AWS Cloud Scanning | `trivy aws` for cloud misconfigs |
| 13 | VM Image Scanning | AMI, VMDK, OVA |
| 14 | Configuration & Control | `.trivyignore`, `trivy.yaml`, Rego policies |
| 15 | Database Management | Air-gapped, offline, Java DB |
| 16 | Shell Script Automation | Reusable scan wrappers |
| 17 | Pre-commit Hooks | Catch secrets before commit |
| 18 | Jenkins Integration | Full pipeline example |
| 19 | GitHub Actions | Native SARIF integration |
| 20 | GitLab CI | Container scanning reports |
| 21 | Azure DevOps | Pipeline integration |
| 22 | VS Code Extension | IDE-level scanning |
| 23 | Compliance Scanning | CIS, NSA, PCI-DSS |
| 24 | Reporting Formats | SARIF, JUnit, JSON |
| 25 | License Scanning | Open-source license audits |
| 26 | Misconfiguration Scanning | IaC security |
| 27 | Server Mode | Enterprise centralized scanning |
| 28 | Tool Comparison | Trivy vs Grype vs Docker Scout |
| 29 | Best Practices | Daily habits and hygiene |
| 30 | Cheat Sheet | Common commands reference |
| 31 | Glossary | Key terminology |

📄 **[Read the full guide →](./Trivy_Complete_Practical_Guide.pdf)**

---

## ⚡ Cheat Sheet

```bash
# Scan a container image
trivy image python:3.10

# Production-grade scan (only fixable critical issues, fail build)
trivy image --severity HIGH,CRITICAL --ignore-unfixed --exit-code 1 myapp:latest

# Scan a local folder
trivy fs .

# Scan for secrets only
trivy fs --scanners secret .

# Scan a Kubernetes cluster
trivy k8s --report summary

# Scan an AWS account
trivy aws --region us-east-1

# Generate an HTML report
trivy image --format template --template @html.tpl -o report.html myapp:latest

# Generate a CycloneDX SBOM
trivy fs --format cyclonedx --output sbom.json .

# Run a compliance check (Docker CIS)
trivy image --compliance docker-cis-1.6.0 myapp:latest

# SARIF output (for GitHub Security tab)
trivy image --format sarif -o trivy.sarif myapp:latest
```

---

## 🏗️ Repository Structure

```
.
├── README.md                              # You are here
├── Trivy_Complete_Practical_Guide.docx    # Full Word document guide
├── scripts/
│   └── scan.sh                            # Reusable scan wrapper script
├── ci/
│   ├── Jenkinsfile                        # Jenkins pipeline example
│   ├── github-actions.yml                 # GitHub Actions workflow
│   ├── .gitlab-ci.yml                     # GitLab CI pipeline
│   └── azure-pipelines.yml                # Azure DevOps pipeline
├── policies/
│   └── custom-rules.rego                  # Example Rego policy
├── templates/
│   └── html.tpl                           # HTML report template
└── examples/
    ├── Dockerfile                         # Sample app for scanning
    ├── trivy.yaml                         # Sample config file
    └── .trivyignore                       # Sample ignore file
```

---

## 🎯 Who This Is For

- **DevOps engineers** integrating security into pipelines
- **DevSecOps practitioners** standardizing scanning across teams
- **Platform engineers** rolling out Trivy at organization scale
- **Developers** wanting to shift security left into their daily workflow
- **Security teams** evaluating Trivy against alternatives
- **Anyone** who has installed Trivy and wondered "now what?"

---

## 🌟 Why Trivy?

| Feature | Why It Matters |
|---------|---------------|
| 🚀 **Single binary** | No account, no login, no paid plan |
| ⚡ **Fast scans** | Local cached database, results in seconds |
| 🎯 **Versatile** | One tool for images, code, IaC, cloud, K8s |
| 🌐 **Active community** | Backed by Aqua Security, updated daily |
| 🆓 **Free & open source** | Apache 2.0 license, no vendor lock-in |
| 📊 **Many formats** | Table, JSON, SARIF, JUnit, CycloneDX, SPDX, HTML |

---

## 🛠️ Common Workflows

### Local Developer Workflow

```bash
# Before pushing your code
trivy fs --scanners secret .
trivy image --severity HIGH,CRITICAL --ignore-unfixed myapp:dev
```

### CI/CD Pipeline

```bash
trivy image \
  --severity HIGH,CRITICAL \
  --ignore-unfixed \
  --exit-code 1 \
  --format sarif \
  --output trivy.sarif \
  myapp:${BUILD_ID}
```

### Air-Gapped Environment

```bash
# On internet-connected machine
trivy image --download-db-only
trivy image --download-java-db-only

# Transfer ~/.cache/trivy/ to air-gapped host, then:
trivy image --offline-scan myapp:latest
```

---

## 🤝 Contributing

Contributions are welcome! Whether it's a typo, a clearer explanation, a new CI example, or a missing feature — feel free to open a PR.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/awesome-improvement`)
3. Commit your changes (`git commit -m 'Add awesome improvement'`)
4. Push to the branch (`git push origin feature/awesome-improvement`)
5. Open a Pull Request

---

## 📜 License

This guide is released under the [MIT License](LICENSE).

Trivy itself is maintained by [Aqua Security](https://www.aquasec.com/) under the Apache 2.0 license.

---

## 🔗 Useful Links

- 📘 [Official Trivy Documentation](https://aquasecurity.github.io/trivy/)
- 🐙 [Trivy on GitHub](https://github.com/aquasecurity/trivy)
- 🔒 [Aqua Vulnerability Database](https://avd.aquasec.com/)
- ☸️ [Trivy Operator](https://github.com/aquasecurity/trivy-operator)
- 💬 [Trivy Slack Community](https://slack.aquasec.com/)

---

## ⭐ Show Your Support

If this guide helped you, give it a ⭐ — it helps others find it too.

---

<div align="center">

**Built with ❤️ for the DevSecOps community**

*Security isn't a feature, it's a habit.*

</div>
