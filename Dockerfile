# Use the official Nginx image based on Alpine
FROM nginx:alpine

# Install `envsubst` to replace environment variables in configuration files
RUN apk add --no-cache gettext

# Copy the custom Nginx configuration template into the container
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# Set environment variables (optional: can be overridden at runtime)
ENV PORT=80
ENV REMOTE_HOST=localhost

# Replace environment variables in the Nginx configuration template and create the final config
CMD /bin/sh -c "envsubst '\$PORT \$REMOTE_HOST' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
