FROM balenalib/raspberrypi3-debian


RUN apt-get update && \
    apt-get install -y unzip gawk wget ca-certificates tini android-tools-adb 

# Expose default ADB port
EXPOSE 5037

# Set up PATH
ENV PATH $PATH:/opt/platform-tools

# Hook up tini as the default init system for proper signal handling
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start the server by default
CMD ["adb", "-a", "-P", "5037", "server", "nodaemon"]
