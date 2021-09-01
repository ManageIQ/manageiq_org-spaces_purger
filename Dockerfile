FROM registry.access.redhat.com/ubi8/ubi:8.3

MAINTAINER ManageIQ https://manageiq.org

RUN dnf -y --disableplugin=subscription-manager install \
      http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/centos-stream-repos-8-2.el8.noarch.rpm \
      http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/centos-gpg-keys-8-2.el8.noarch.rpm \
      https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    dnf -y --disableplugin=subscription-manager module enable ruby:2.6 && \
    dnf config-manager --setopt=ubi-8-*.exclude=net-snmp*,redhat-release* --save && \
    dnf -y --disableplugin=subscription-manager --setopt=tsflags=nodocs install ruby && \
    dnf clean all

COPY . /opt/manageiq_org-spaces_purger/

WORKDIR /opt/manageiq_org-spaces_purger/

RUN gem install bundler && \
    bundle install

CMD ["bin/digital_ocean_spaces_cleanup.rb"]
