FROM nginx:1.26.2

COPY index.html /usr/share/nginx/html/index.html

# Set the default port to 80, but allow it to be overridden
ENV NGINX_PORT=80

# Modify the default Nginx configuration to use the custom port
RUN sed -i 's/listen 80;/listen ${NGINX_PORT};/' /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
