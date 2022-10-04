# syntax=docker/dockerfile:1


FROM registry.access.redhat.com/rhscl/devtoolset-4-toolchain-rhel7

ENV HTTP_PROXY="http://proxy-dmz.intel.com:911/" \
	HTTPS_PROXY="http://proxy-dmz.intel.com:911/" \
	FTP_PROXY="http://proxy-dmz.intel.com:911/" \
	NO_PROXY=".intel.com,.intel.com,10.0.0.0/8,192.168.0.0/16,localhost,::1,.local,127.0.0.0/8,134.134.0.0/16,172.16.0.0/12"

USER root

# Copy entitlements
COPY ./etc-pki-entitlement /etc/pki/entitlement
# Copy subscription manager configurations
COPY ./rhsm-conf /etc/rhsm
COPY ./rhsm-ca /etc/rhsm/ca
# Delete /etc/rhsm-host to use entitlements from the build container
RUN rm /etc/rhsm-host && \
    yum repolist --disablerepo=* && \
    #subscription-manager repos --enable <enabled-repo> && \
    yum -y update 
#    #yum -y install <rpms> && \
#    # Remove entitlements and Subscription Manager configs
#    #rm -rf /etc/pki/entitlement && \
#    #rm -rf /etc/rhsm
#
#ENTRYPOINT ["/bin/bash"]
