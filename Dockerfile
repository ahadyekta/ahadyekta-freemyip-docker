# Use a lightweight Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TOKEN=""
ENV DOMAIN=""

# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        curl \
        cron && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add a script to configure the crontab dynamically
RUN echo '#!/bin/bash\n' \
    'if [ -z "$TOKEN" ] || [ -z "$DOMAIN" ]; then\n' \
    '  echo "Error: TOKEN and DOMAIN environment variables must be set!"\n' \
    '  exit 1\n' \
    'fi\n' \
    '(crontab -l 2>/dev/null; echo "*/21 * * * * curl \"https://freemyip.com/update?token=$TOKEN&domain=$DOMAIN.freemyip.com\">/dev/null 2>&1") | crontab -\n' \
    'cron -f' > /usr/local/bin/start-cron.sh && \
    chmod +x /usr/local/bin/start-cron.sh

# Set the default command
CMD ["/usr/local/bin/start-cron.sh"]