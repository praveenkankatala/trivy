# custom-rules.rego
# sample
# Custom Trivy/OPA policies for Dockerfile and Kubernetes resources.
# Run with:
#   trivy config --policy ./policies/ --namespaces custom .

package custom.dockerfile.security

# ---------------------------------------------------------------------------
# Rule 1: Forbid the 'latest' tag in FROM instructions
# ---------------------------------------------------------------------------
deny[msg] {
    input.Stages[_].Commands[_].Cmd == "from"
    value := input.Stages[_].Commands[_].Value[0]
    endswith(value, ":latest")
    msg := sprintf(
        "Avoid using the 'latest' tag in FROM: %s. Pin a specific version for reproducibility.",
        [value]
    )
}

# ---------------------------------------------------------------------------
# Rule 2: Require non-root USER
# ---------------------------------------------------------------------------
deny[msg] {
    not has_user_instruction
    msg := "Dockerfile must include a USER instruction to avoid running as root."
}

has_user_instruction {
    input.Stages[_].Commands[_].Cmd == "user"
}

# ---------------------------------------------------------------------------
# Rule 3: Disallow ADD with remote URLs (use COPY or explicit download)
# ---------------------------------------------------------------------------
deny[msg] {
    cmd := input.Stages[_].Commands[_]
    cmd.Cmd == "add"
    startswith(cmd.Value[0], "http")
    msg := sprintf(
        "Avoid ADD with remote URLs: %s. Use RUN curl/wget with checksum verification instead.",
        [cmd.Value[0]]
    )
}

# ---------------------------------------------------------------------------
# Rule 4: Forbid hardcoded secrets in ENV
# ---------------------------------------------------------------------------
deny[msg] {
    cmd := input.Stages[_].Commands[_]
    cmd.Cmd == "env"
    val := cmd.Value[_]
    contains(lower(val), "password=")
    msg := sprintf("Hardcoded password detected in ENV: %s. Use secrets management instead.", [val])
}

deny[msg] {
    cmd := input.Stages[_].Commands[_]
    cmd.Cmd == "env"
    val := cmd.Value[_]
    contains(lower(val), "api_key=")
    msg := sprintf("Hardcoded API key detected in ENV: %s. Use secrets management instead.", [val])
}
