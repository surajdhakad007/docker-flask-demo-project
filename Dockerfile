# -------- Stage 1: Build Stage --------
FROM python:3.6 AS builder

WORKDIR /build

# Install dependencies
RUN pip install flask

# Copy application code
COPY app.py .

# -------- Stage 2: Runtime Stage --------
FROM python:3.6-slim

WORKDIR /opt

# Copy only required files from builder stage
COPY --from=builder /usr/local/lib/python3.6/site-packages \
                    /usr/local/lib/python3.6/site-packages

COPY --from=builder /build/app.py .

EXPOSE 8080

ENTRYPOINT ["python", "app.py"]
