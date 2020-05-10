from debian

COPY bootstrapsh /root/
RUN /root/bootstrap.sh

CMD ["/bin/bash"]
