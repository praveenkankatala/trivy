# examples/Dockerfile
#
# A minimal sample Dockerfile for testing Trivy scans.
# Demonstrates best practices: small base image, non-root user,
# multi-stage build, and explicit version pinning.

# ---------------------------------------------------------------------------
# Build stage
# ---------------------------------------------------------------------------
FROM python:3.12-slim AS builder

WORKDIR /build

# Upgrade pip to patch any known issues in the base image
RUN pip install --no-cache-dir --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# ---------------------------------------------------------------------------
# Runtime stage
# ---------------------------------------------------------------------------
FROM python:3.12-slim

# Create a non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

# Copy dependencies from the builder stage
COPY --from=builder /root/.local /home/appuser/.local
COPY --chown=appuser:appuser app.py .

# Switch to non-root user
USER appuser
ENV PATH=/home/appuser/.local/bin:$PATH

EXPOSE 8000
CMD ["python", "app.py"]
