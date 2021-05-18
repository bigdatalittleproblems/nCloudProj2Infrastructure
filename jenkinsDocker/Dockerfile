FROM jenkins/jenkins:lts
USER root
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG=/etc/casc

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

RUN curl -o docker.sh https://get.docker.com/ && \ 
    sh docker.sh
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin && \
    kubectl version --short --client
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

COPY groovy/*.groovy                    /usr/share/jenkins/ref/init.groovy.d/
COPY casc                               /etc/casc

USER jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]