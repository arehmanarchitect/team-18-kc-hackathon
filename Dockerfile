FROM nginx:1.26.2

COPY index.html /usr/share/nginx/html/index.html

# Modify NGINX to always listen on port 8080
RUN sed -i 's/listen 80;/listen 8080;/' /etc/nginx/conf.d/default.conf

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
