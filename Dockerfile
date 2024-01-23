FROM nginx:latest
COPY system_info.sh /usr/share/nginx/html/system_info.sh
#RUN chmod +x /usr/share/nginx/html/system_info.sh
COPY crontab.txt /etc/cron.d/crontab.txt
RUN chmod +x /usr/share/nginx/html/system_info.sh \
    && chmod 0644 /etc/cron.d/crontab.txt \
    && crontab /etc/cron.d/crontab.txt \
    && touch /var/log/cron.log

RUN /usr/share/nginx/html/system_info.sh
RUN ls -la
#COPY /usr/share/nginx/html/index.html /usr/share/nginx/html/
EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]
CMD cron && nginx -g 'daemon off;'
