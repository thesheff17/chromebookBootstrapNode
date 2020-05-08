from debian

COPY bootstrap.sh /root/
RUN /root/bootstrap.sh

CMD ["/bin/bash"]
