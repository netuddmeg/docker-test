# Use the standard Nginx image from Docker Hub
FROM nginx

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:80 || exit 1

# Start Nginx when the container has provisioned.
CMD ["nginx", "-g", "daemon off;"]
