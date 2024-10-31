FROM swift:5.8 as builder
WORKDIR /app
COPY . .
RUN swift build -c release

FROM swift:5.8-slim
WORKDIR /run
COPY --from=builder /app/.build/release /run
CMD ["./Run"]
