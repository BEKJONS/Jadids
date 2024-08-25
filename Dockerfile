# Stage 1: Build stage
FROM golang:1.23 AS builder

WORKDIR /app

# Copy and download dependencies
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the rest of the application
COPY . .

# Optionally copy the .env file if needed
COPY .env .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -C ./cmd -a -installsuffix cgo -o ./myapp .
RUN chmod +x ./myapp

# Stage 2: Final stage
FROM alpine:latest

WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /app/myapp .

# Optionally copy the .env file
COPY --from=builder /app/.env .

# Expose port 8081
EXPOSE 8080

# Command to run the executable
CMD ["./myapp"]
