FROM balenalib/raspberrypi3-debian

# Set up insecure default key
RUN mkdir -m 0750 /root/.android
ADD files/insecure_shared_adbkey /root/.android/adbkey
ADD files/insecure_shared_adbkey.pub /root/.android/adbkey.pub
ADD files/update-platform-tools.sh /usr/local/bin/update-platform-tools.sh

RUN apt-get update && \
    apt-get install -y unzip gawk wget ca-certificates tini && \
    /usr/local/bin/update-platform-tools.sh

# Expose default ADB port
EXPOSE 5037

# Set up PATH
ENV PATH $PATH:/opt/platform-tools

# Hook up tini as the default init system for proper signal handling
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start the server by default
CMD ["adb", "-a", "-P", "5037", "server", "nodaemon"]
