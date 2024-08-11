# Build stage
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY . .
RUN go mod download
RUN env GOOS=js GOARCH=wasm go build -o meteors-in-go.wasm github.com/YhaliWaizman/meteors-in-go
RUN cp $(go env GOROOT)/misc/wasm/wasm_exec.js .

# Deploy stage
FROM nginx:alpine
COPY --from=build /app/meteors-in-go.wasm /usr/share/nginx/html/
COPY --from=build /app/wasm_exec.js /usr/share/nginx/html/
COPY --from=build /app/Web/* /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
