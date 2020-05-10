from debian

RUN apt-get update && apt-get -y upgrade && apt-get -y install git-core sudo
RUN git clone https://github.com/thesheff17/chromebookBootstrapNode.git && cd chromebookBootstrapNode && sudo ./bootstrap.sh

CMD ["/bin/bash"]
