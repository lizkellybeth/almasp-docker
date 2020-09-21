FROM plone:5.1.6

COPY site.cfg /plone/instance/
RUN buildout -c site.cfg \
 && find /data  -not -user plone -exec chown plone:plone {} \+ \
 && find /plone -not -user plone -exec chown plone:plone {} \+

RUN mkdir -p /plone/instance/parts/instance/import
COPY xfer3.zexp /plone/instance/parts/instance/import/
RUN chown -R plone:plone /plone/instance/parts/instance/import

# Tell the docker runtime that we expect the /data/ folder to be an external volume.
# Existence prevents the creation of a new docker image from the running container,
# VOLUME /data/

# Tell the docker runtime what process we expect to run when a container is started.
#CMD [ "/plone/bin/instance", "console" ]
