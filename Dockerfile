FROM centos:7
MAINTAINER jaspeen

ADD assets /assets

RUN chmod -R 755 /assets
RUN chmod +x /assets/*.sh

EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/assets/setup.sh", "/assets/entrypoint.sh"]
