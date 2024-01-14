FROM nginx:latest
COPY system_info.sh /usr/share/nginx/html/system_info.sh
RUN chmod +x /usr/share/nginx/html/system_info.sh
#RUN mkdir -p /usr/share/nginx/html
RUN /usr/share/nginx/html/system_info.sh
RUN ls -la
#COPY /usr/share/nginx/html/index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
