MODULES=("retail_pos" "restaurant_pos" "hotel_pms")
DOCKER_COMPOSE_FILE="$BASE_DIR/docker-compose.yml"
LOG_FILE="$BASE_DIR/build.log"
# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
# Function to log output
log() {     echo -e "$1" | tee -a "$LOG_FILE"; }
# Step 1: Clone or pull repositories
log "${GREEN}Step 1: Cloning or Pulling Repositories${NC}"
clone_or_pull_repos() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         REPO_URL="https://github.com/allyelvis/$module.git"  # Replace with actual repo URL
        if [ -d "$MODULE_DIR" ]; then             log "${GREEN}Updating $module...${NC}";             cd "$MODULE_DIR" && git pull;         else             log "${GREEN}Cloning $module...${NC}";             git clone "$REPO_URL" "$MODULE_DIR";         fi;     done;     log "${GREEN}Repositories cloned or updated.${NC}"; }
clone_or_pull_repos
# Step 2: Install dependencies
log "${GREEN}Step 2: Installing Dependencies${NC}"
install_dependencies() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         if [ -f "$MODULE_DIR/package.json" ]; then             log "${GREEN}Installing npm dependencies for $module...${NC}";             cd "$MODULE_DIR" && npm install;         elif [ -f "$MODULE_DIR/requirements.txt" ]; then             log "${GREEN}Installing Python dependencies for $module...${NC}";             cd "$MODULE_DIR" && pip install -r requirements.txt;         elif [ -f "$MODULE_DIR/pom.xml" ]; then             log "${GREEN}Installing Java dependencies for $module...${NC}";             cd "$MODULE_DIR" && mvn clean install;         else             log "${RED}No recognized dependency manager found for $module.${NC}";         fi;     done;     log "${GREEN}Dependencies installed.${NC}"; }
install_dependencies
# Step 3: Build Docker images
log "${GREEN}Step 3: Building Docker Images${NC}"
build_docker_images() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         if [ -f "$MODULE_DIR/Dockerfile" ]; then             log "${GREEN}Building Docker image for $module...${NC}";             cd "$MODULE_DIR" && docker build -t "$module:latest" .;         else             log "${RED}No Dockerfile found for $module.${NC}";         fi;     done;     log "${GREEN}Docker images built.${NC}"; }
build_docker_images
# Step 4: Create Docker Compose configuration
log "${GREEN}Step 4: Creating Docker Compose Configuration${NC}"
create_docker_compose() {
    cat <<EOL > "$DOCKER_COMPOSE_FILE"
version: '3.8'
services:
EOL
      for module in "${MODULES[@]}"; do
        cat <<EOL >> "$DOCKER_COMPOSE_FILE"
  $module:
    image: $module:latest
    build:
      context: ./$module
    ports:
      - "8080:8080"
    volumes:
      - ./$module:/app
    restart: always

EOL
     done;      log "${GREEN}Docker Compose configuration created.${NC}"; }
create_docker_compose
# Step 5: Run Docker containers
log "${GREEN}Step 5: Running Docker Containers${NC}"
run_docker_containers() {     cd "$BASE_DIR";     docker-compose up -d --build;     log "${GREEN}Docker containers are running.${NC}"; }
run_docker_containers
# Step 6: Generate Build Artifacts
log "${GREEN}Step 6: Generating Build Artifacts${NC}"
generate_build_artifacts() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         OUTPUT_DIR="$BASE_DIR/artifacts/$module";         mkdir -p "$OUTPUT_DIR";         if [ -f "$MODULE_DIR/package.json" ]; then             log "${GREEN}Generating build artifact for $module (npm)...${NC}";             cd "$MODULE_DIR" && npm run build && cp -r dist/* "$OUTPUT_DIR/";         elif [ -f "$MODULE_DIR/pom.xml" ]; then             log "${GREEN}Generating build artifact for $module (Maven)...${NC}";             cd "$MODULE_DIR" && mvn package && cp target/*.jar "$OUTPUT_DIR/";         else             log "${RED}No recognized build system found for $module.${NC}";         fi;     done;     log "${GREEN}Build artifacts generated in $BASE_DIR/artifacts.${NC}"; }
generate_build_artifacts
# Final Step: Verify and Finish
log "${GREEN}Build and generation process completed successfully# Final Step: Verify and Finish{NC}"
log "${GREEN}Artifacts are available in $BASE_DIR/artifacts.${NC}"
cd
#!/bin/bash
# Aenzbi Suite Build and Generate Script
# Author: Ally Elvis Nzeyimana
# Date: 13/12/2024
# Define variables
BASE_DIR="$HOME/aenzbi_suite"
MODULES=("retail_pos" "restaurant_pos" "hotel_pms")
DOCKER_COMPOSE_FILE="$BASE_DIR/docker-compose.yml"
LOG_FILE="$BASE_DIR/build.log"
# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
# Function to log output
log() {     echo -e "$1" | tee -a "$LOG_FILE"; }
# Step 1: Clone or pull repositories
log "${GREEN}Step 1: Cloning or Pulling Repositories${NC}"
clone_or_pull_repos() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         REPO_URL="https://github.com/allyelvis/$module.git"  # Replace with actual repo URL
        if [ -d "$MODULE_DIR" ]; then             log "${GREEN}Updating $module...${NC}";             cd "$MODULE_DIR" && git pull;         else             log "${GREEN}Cloning $module...${NC}";             git clone "$REPO_URL" "$MODULE_DIR";         fi;     done;     log "${GREEN}Repositories cloned or updated.${NC}"; }
clone_or_pull_repos
# Step 2: Install dependencies
log "${GREEN}Step 2: Installing Dependencies${NC}"
install_dependencies() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         if [ -f "$MODULE_DIR/package.json" ]; then             log "${GREEN}Installing npm dependencies for $module...${NC}";             cd "$MODULE_DIR" && npm install;         elif [ -f "$MODULE_DIR/requirements.txt" ]; then             log "${GREEN}Installing Python dependencies for $module...${NC}";             cd "$MODULE_DIR" && pip install -r requirements.txt;         elif [ -f "$MODULE_DIR/pom.xml" ]; then             log "${GREEN}Installing Java dependencies for $module...${NC}";             cd "$MODULE_DIR" && mvn clean install;         else             log "${RED}No recognized dependency manager found for $module.${NC}";         fi;     done;     log "${GREEN}Dependencies installed.${NC}"; }
install_dependencies
# Step 3: Build Docker images
log "${GREEN}Step 3: Building Docker Images${NC}"
build_docker_images() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         if [ -f "$MODULE_DIR/Dockerfile" ]; then             log "${GREEN}Building Docker image for $module...${NC}";             cd "$MODULE_DIR" && docker build -t "$module:latest" .;         else             log "${RED}No Dockerfile found for $module.${NC}";         fi;     done;     log "${GREEN}Docker images built.${NC}"; }
build_docker_images
# Step 4: Create Docker Compose configuration
log "${GREEN}Step 4: Creating Docker Compose Configuration${NC}"
create_docker_compose() {
    cat <<EOL > "$DOCKER_COMPOSE_FILE"
version: '3.8'
services:
EOL
      for module in "${MODULES[@]}"; do
        cat <<EOL >> "$DOCKER_COMPOSE_FILE"
  $module:
    image: $module:latest
    build:
      context: ./$module
    ports:
      - "8080:8080"
    volumes:
      - ./$module:/app
    restart: always

EOL
     done;      log "${GREEN}Docker Compose configuration created.${NC}"; }
create_docker_compose
# Step 5: Run Docker containers
log "${GREEN}Step 5: Running Docker Containers${NC}"
run_docker_containers() {     cd "$BASE_DIR";     docker-compose up -d --build;     log "${GREEN}Docker containers are running.${NC}"; }
run_docker_containers
# Step 6: Generate Build Artifacts
log "${GREEN}Step 6: Generating Build Artifacts${NC}"
generate_build_artifacts() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         OUTPUT_DIR="$BASE_DIR/artifacts/$module";         mkdir -p "$OUTPUT_DIR";         if [ -f "$MODULE_DIR/package.json" ]; then             log "${GREEN}Generating build artifact for $module (npm)...${NC}";             cd "$MODULE_DIR" && npm run build && cp -r dist/* "$OUTPUT_DIR/";         elif [ -f "$MODULE_DIR/pom.xml" ]; then             log "${GREEN}Generating build artifact for $module (Maven)...${NC}";             cd "$MODULE_DIR" && mvn package && cp target/*.jar "$OUTPUT_DIR/";         else             log "${RED}No recognized build system found for $module.${NC}";         fi;     done;     log "${GREEN}Build artifacts generated in $BASE_DIR/artifacts.${NC}"; }
generate_build_artifacts
# Final Step: Verify and Finish
log "${GREEN}Build and generation process completed successfully# Final Step: Verify and Finish{NC}"
log "${GREEN}Artifacts are available in $BASE_DIR/artifacts.${NC}"
#!/bin/bash
# Aenzbi Suite Build and Generate Script
# Author: Ally Elvis Nzeyimana
# Date: 13/12/2024
# Define variables
BASE_DIR="$HOME/aenzbi_suite"
MODULES=("retail_pos" "restaurant_pos" "hotel_pms")
DOCKER_COMPOSE_FILE="$BASE_DIR/docker-compose.yml"
LOG_FILE="$BASE_DIR/build.log"
# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
# Function to log output
log() {     echo -e "$1" | tee -a "$LOG_FILE"; }
# Step 1: Clone or pull repositories
log "${GREEN}Step 1: Cloning or Pulling Repositories${NC}"
clone_or_pull_repos() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         REPO_URL="https://github.com/allyelvis/$module.git"  # Replace with actual repo URL
        if [ -d "$MODULE_DIR" ]; then             log "${GREEN}Updating $module...${NC}";             cd "$MODULE_DIR" && git pull;         else             log "${GREEN}Cloning $module...${NC}";             git clone "$REPO_URL" "$MODULE_DIR";         fi;     done;     log "${GREEN}Repositories cloned or updated.${NC}"; }
clone_or_pull_repos
# Step 2: Install dependencies
log "${GREEN}Step 2: Installing Dependencies${NC}"
install_dependencies() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         if [ -f "$MODULE_DIR/package.json" ]; then             log "${GREEN}Installing npm dependencies for $module...${NC}";             cd "$MODULE_DIR" && npm install;         elif [ -f "$MODULE_DIR/requirements.txt" ]; then             log "${GREEN}Installing Python dependencies for $module...${NC}";             cd "$MODULE_DIR" && pip install -r requirements.txt;         elif [ -f "$MODULE_DIR/pom.xml" ]; then             log "${GREEN}Installing Java dependencies for $module...${NC}";             cd "$MODULE_DIR" && mvn clean install;         else             log "${RED}No recognized dependency manager found for $module.${NC}";         fi;     done;     log "${GREEN}Dependencies installed.${NC}"; }
install_dependencies
# Step 3: Build Docker images
log "${GREEN}Step 3: Building Docker Images${NC}"
build_docker_images() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         if [ -f "$MODULE_DIR/Dockerfile" ]; then             log "${GREEN}Building Docker image for $module...${NC}";             cd "$MODULE_DIR" && docker build -t "$module:latest" .;         else             log "${RED}No Dockerfile found for $module.${NC}";         fi;     done;     log "${GREEN}Docker images built.${NC}"; }
build_docker_images
# Step 4: Create Docker Compose configuration
log "${GREEN}Step 4: Creating Docker Compose Configuration${NC}"
create_docker_compose() {
    cat <<EOL > "$DOCKER_COMPOSE_FILE"
version: '3.8'
services:
EOL
      for module in "${MODULES[@]}"; do
        cat <<EOL >> "$DOCKER_COMPOSE_FILE"
  $module:
    image: $module:latest
    build:
      context: ./$module
    ports:
      - "8080:8080"
    volumes:
      - ./$module:/app
    restart: always

EOL
     done;      log "${GREEN}Docker Compose configuration created.${NC}"; }
create_docker_compose
# Step 5: Run Docker containers
log "${GREEN}Step 5: Running Docker Containers${NC}"
run_docker_containers() {     cd "$BASE_DIR";     docker-compose up -d --build;     log "${GREEN}Docker containers are running.${NC}"; }
run_docker_containers
# Step 6: Generate Build Artifacts
log "${GREEN}Step 6: Generating Build Artifacts${NC}"
generate_build_artifacts() {     for module in "${MODULES[@]}"; do         MODULE_DIR="$BASE_DIR/$module";         OUTPUT_DIR="$BASE_DIR/artifacts/$module";         mkdir -p "$OUTPUT_DIR";         if [ -f "$MODULE_DIR/package.json" ]; then             log "${GREEN}Generating build artifact for $module (npm)...${NC}";             cd "$MODULE_DIR" && npm run build && cp -r dist/* "$OUTPUT_DIR/";         elif [ -f "$MODULE_DIR/pom.xml" ]; then             log "${GREEN}Generating build artifact for $module (Maven)...${NC}";             cd "$MODULE_DIR" && mvn package && cp target/*.jar "$OUTPUT_DIR/";         else             log "${RED}No recognized build system found for $module.${NC}";         fi;     done;     log "${GREEN}Build artifacts generated in $BASE_DIR/artifacts.${NC}"; }
generate_build_artifacts
# Final Step: Verify and Finish
log "${GREEN}Build and generation process completed successfully# Final Step: Verify and Finish{NC}"
log "${GREEN}Artifacts are available in $BASE_DIR/artifacts.${NC}"
cd
Step
#!/bin/bash
# Exit script on any error
set -e
# Define variables
DOCKER_IMAGE_NAME="tflite-android"
DOCKER_CONTAINER_NAME="tflite-container"
TENSORFLOW_REPO="https://github.com/tensorflow/tensorflow.git"
TENSORFLOW_DIR="tensorflow"
# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then   echo "Error: Docker is not installed. Please install Docker first." >&2;   exit 1; fi
# Create the Dockerfile
echo "Creating Dockerfile..."
cat <<EOF > Dockerfile
# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/sdk
ENV PATH=\$PATH:\$ANDROID_HOME/emulator:\$ANDROID_HOME/tools:\$ANDROID_HOME/tools/bin:\$ANDROID_HOME/platform-tools

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \\
    curl \\
    git \\
    unzip \\
    openjdk-11-jdk \\
    build-essential \\
    cmake \\
    ninja-build \\
    python3 \\
    python3-pip \\
    && apt-get clean

# Install Android SDK command line tools
RUN mkdir -p \$ANDROID_HOME && \\
    curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && \\
    unzip sdk-tools.zip -d \$ANDROID_HOME && \\
    rm sdk-tools.zip

# Accept Android licenses and install build tools
RUN yes | sdkmanager --licenses && \\
    sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;25.2.9519653" "cmake;3.18.1"

# Install TensorFlow Lite dependencies
RUN python3 -m pip install --upgrade pip && \\
    pip install tensorflow

# Clone TensorFlow repository and set up workspace
RUN git clone --depth 1 $TENSORFLOW_REPO /tensorflow && \\
    cd /tensorflow && \\
    ./configure

# Set the working directory for your project
WORKDIR /app

# Define default command (you can override this)
CMD ["/bin/bash"]
EOF

# Build the Docker image
echo "Building Docker image..."
docker build -t $DOCKER_IMAGE_NAME .
cd ..
#!/bin/bash
# Exit script on any error
set -e
# Define variables
DOCKER_IMAGE_NAME="tflite-android"
DOCKER_CONTAINER_NAME="tflite-container"
TENSORFLOW_REPO="https://github.com/tensorflow/tensorflow.git"
TENSORFLOW_DIR="tensorflow"
# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then   echo "Error: Docker is not installed. Please install Docker first." >&2;   exit 1; fi
# Create the Dockerfile
echo "Creating Dockerfile..."
cat <<EOF > Dockerfile
# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/sdk
ENV PATH=\$PATH:\$ANDROID_HOME/emulator:\$ANDROID_HOME/tools:\$ANDROID_HOME/tools/bin:\$ANDROID_HOME/platform-tools

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \\
    curl \\
    git \\
    unzip \\
    openjdk-11-jdk \\
    build-essential \\
    cmake \\
    ninja-build \\
    python3 \\
    python3-pip \\
    && apt-get clean

# Install Android SDK command line tools
RUN mkdir -p \$ANDROID_HOME && \\
    curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && \\
    unzip sdk-tools.zip -d \$ANDROID_HOME && \\
    rm sdk-tools.zip

# Accept Android licenses and install build tools
RUN yes | sdkmanager --licenses && \\
    sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;25.2.9519653" "cmake;3.18.1"

# Install TensorFlow Lite dependencies
RUN python3 -m pip install --upgrade pip && \\
    pip install tensorflow

# Clone TensorFlow repository and set up workspace
RUN git clone --depth 1 $TENSORFLOW_REPO /tensorflow && \\
    cd /tensorflow && \\
    ./configure

# Set the working directory for your project
WORKDIR /app

# Define default command (you can override this)
CMD ["/bin/bash"]
EOF

# Build the Docker image
echo "Building Docker image..."
docker build -t $DOCKER_IMAGE_NAME .
#!/bin/bash
# Exit script on any error
set -e
# Define variables
DOCKER_IMAGE_NAME="tflite-android"
DOCKER_CONTAINER_NAME="tflite-container"
TENSORFLOW_REPO="https://github.com/tensorflow/tensorflow.git"
TENSORFLOW_DIR="tensorflow"
# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then   echo "Error: Docker is not installed. Please install Docker first." >&2;   exit 1; fi
# Create the Dockerfile
echo "Creating Dockerfile..."
cat <<EOF > Dockerfile
# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/sdk
ENV PATH=\$PATH:\$ANDROID_HOME/emulator:\$ANDROID_HOME/tools:\$ANDROID_HOME/tools/bin:\$ANDROID_HOME/platform-tools

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \\
    curl \\
    git \\
    unzip \\
    openjdk-11-jdk \\
    build-essential \\
    cmake \\
    ninja-build \\
    python3 \\
    python3-pip \\
    && apt-get clean

# Install Android SDK command line tools
RUN mkdir -p \$ANDROID_HOME && \\
    curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && \\
    unzip sdk-tools.zip -d \$ANDROID_HOME && \\
    rm sdk-tools.zip

# Accept Android licenses and install build tools
RUN yes | sdkmanager --licenses && \\
    sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;25.2.9519653" "cmake;3.18.1"

# Install TensorFlow Lite dependencies
RUN python3 -m pip install --upgrade pip && \\
    pip install tensorflow

# Clone TensorFlow repository and set up workspace
RUN git clone --depth 1 $TENSORFLOW_REPO /tensorflow && \\
    cd /tensorflow && \\
    ./configure

# Set the working directory for your project
WORKDIR /app

# Define default command (you can override this)
CMD ["/bin/bash"]
EOF

# Build the Docker image
echo "Building Docker image..."
docker build -t $DOCKER_IMAGE_NAME .
cd d
cd
cd 
#!/bin/bash
# Firebase Auth Automation Script
# Email: allyelvis6569@gmail.com
# This script handles Firebase OOB actions like verifyEmail, resetPassword, etc.
# Configuration
FIREBASE_API_URL="https://identitytoolkit.googleapis.com/v1/accounts"
API_KEY="your_firebase_project_api_key" # Replace with your Firebase Web API Key
EMAIL="allyelvis6569@gmail.com"
# Function to handle OOB codes
handle_oob_code() {     local oobCode="$1";     local mode="$2";      echo "Processing mode: $mode, OOB Code: $oobCode";      case $mode in         verifyEmail)             echo "Verifying email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:update?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         resetPassword)             echo "Resetting password for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         recoverEmail)             echo "Recovering email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Function to initiate an action
initiate_action() {     local mode="$1";      echo "Initiating $mode for $EMAIL...";      case $mode in         verifyEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"VERIFY_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         resetPassword)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"PASSWORD_RESET\",\"email\":\"$EMAIL\"}" | jq;             ;;         recoverEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"RECOVER_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Main Menu
echo "Firebase Auth Automation Script"
echo "Email: $EMAIL"
echo "1. Verify Email"
echo "2. Reset Password"
echo "3. Recover Email"
echo "4. Handle OOB Code"
echo "Choose an option (1-4):"
read -r option
case $option in     1)         initiate_action "verifyEmail";         ;;     2)         initiate_action "resetPassword";         ;;     3)         initiate_action "recoverEmail";         ;;     4)         echo "Enter the OOB Code:";         read -r oobCode;         echo "Enter the mode (verifyEmail, resetPassword, recoverEmail):";         read -r mode;         handle_oob_code "$oobCode" "$mode";         ;;     *)         echo "Invalid option.";         ;; esac
#!/bin/bash
# Firebase Auth Automation Script
# Email: allyelvis6569@gmail.com
# This script handles Firebase OOB actions like verifyEmail, resetPassword, etc.
# Configuration
FIREBASE_API_URL="https://identitytoolkit.googleapis.com/v1/accounts"
API_KEY="your_firebase_project_api_key" # Replace with your Firebase Web API Key
EMAIL="allyelvis6569@gmail.com"
# Function to handle OOB codes
handle_oob_code() {     local oobCode="$1";     local mode="$2";      echo "Processing mode: $mode, OOB Code: $oobCode";      case $mode in         verifyEmail)             echo "Verifying email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:update?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         resetPassword)             echo "Resetting password for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         recoverEmail)             echo "Recovering email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Function to initiate an action
initiate_action() {     local mode="$1";      echo "Initiating $mode for $EMAIL...";      case $mode in         verifyEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"VERIFY_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         resetPassword)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"PASSWORD_RESET\",\"email\":\"$EMAIL\"}" | jq;             ;;         recoverEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"RECOVER_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Main Menu
echo "Firebase Auth Automation Script"
echo "Email: $EMAIL"
echo "1. Verify Email"
echo "2. Reset Password"
echo "3. Recover Email"
echo "4. Handle OOB Code"
echo "Choose an option (1-4):"
read -r option
case $option in     1)         initiate_action "verifyEmail";         ;;     2)         initiate_action "resetPassword";         ;;     3)         initiate_action "recoverEmail";         ;;     4)         echo "Enter the OOB Code:";         read -r oobCode;         echo "Enter the mode (verifyEmail, resetPassword, recoverEmail):";         read -r mode;         handle_oob_code "$oobCode" "$mode";         ;;     *)         echo "Invalid option.";         ;; esac
#!/bin/bash
# Firebase Auth Automation Script
# Email: allyelvis6569@gmail.com
# This script handles Firebase OOB actions like verifyEmail, resetPassword, etc.
# Configuration
FIREBASE_API_URL="https://identitytoolkit.googleapis.com/v1/accounts"
API_KEY="your_firebase_project_api_key" # Replace with your Firebase Web API Key
EMAIL="allyelvis6569@gmail.com"
# Function to handle OOB codes
handle_oob_code() {     local oobCode="$1";     local mode="$2";      echo "Processing mode: $mode, OOB Code: $oobCode";      case $mode in         verifyEmail)             echo "Verifying email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:update?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         resetPassword)             echo "Resetting password for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         recoverEmail)             echo "Recovering email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Function to initiate an action
initiate_action() {     local mode="$1";      echo "Initiating $mode for $EMAIL...";      case $mode in         verifyEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"VERIFY_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         resetPassword)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"PASSWORD_RESET\",\"email\":\"$EMAIL\"}" | jq;             ;;         recoverEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"RECOVER_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Main Menu
echo "Firebase Auth Automation Script"
echo "Email: $EMAIL"
echo "1. Verify Email"
echo "2. Reset Password"
echo "3. Recover Email"
echo "4. Handle OOB Code"
echo "Choose an option (1-4):"
read -r option
case $option in     1)         initiate_action "verifyEmail";         ;;     2)         initiate_action "resetPassword";         ;;     3)         initiate_action "recoverEmail";         ;;     4)         echo "Enter the OOB Code:";         read -r oobCode;         echo "Enter the mode (verifyEmail, resetPassword, recoverEmail):";         read -r mode;         handle_oob_code "$oobCode" "$mode";         ;;     *)         echo "Invalid option.";         ;;
FIREBASE_API_URL="https://identitytoolkit.googleapis.com/v1/accounts"
API_KEY="your_firebase_project_api_key" # Replace with your Firebase Web API Key
EMAIL="allyelvis6569@gmail.com"
# Function to handle OOB codes
handle_oob_code() {     local oobCode="$1";     local mode="$2";      echo "Processing mode: $mode, OOB Code: $oobCode";      case $mode in         verifyEmail)             echo "Verifying email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:update?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         resetPassword)             echo "Resetting password for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         recoverEmail)             echo "Recovering email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Function to initiate an action
initiate_action() {     local mode="$1";      echo "Initiating $mode for $EMAIL...";      case $mode in         verifyEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"VERIFY_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         resetPassword)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"PASSWORD_RESET\",\"email\":\"$EMAIL\"}" | jq;             ;;         recoverEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"RECOVER_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Main Menu
echo "Firebase Auth Automation Script"
echo "Email: $EMAIL"
echo "1. Verify Email"
echo "2. Reset Password"
echo "3. Recover Email"
echo "4. Handle OOB Code"
echo "Choose an option (1-4):"
read -r option
case $option in     1)         initiate_action "verifyEmail";         ;;     2)         initiate_action "resetPassword";         ;;     3)         initiate_action "recoverEmail";         ;;     4)         echo "Enter the OOB Code:";         read -r oobCode;         echo "Enter the mode (verifyEmail, resetPassword, recoverEmail):";         read -r mode;         handle_oob_code "$oobCode" "$mode";         ;;     *)         echo "Invalid option.";         ;; esac
#!/bin/bash
# Firebase Auth Automation Script
# Email: allyelvis6569@gmail.com
# This script handles Firebase OOB actions like verifyEmail, resetPassword, etc.
# Configuration
FIREBASE_API_URL="https://identitytoolkit.googleapis.com/v1/accounts"
API_KEY="your_firebase_project_api_key" # Replace with your Firebase Web API Key
EMAIL="allyelvis6569@gmail.com"
# Function to handle OOB codes
handle_oob_code() {     local oobCode="$1";     local mode="$2";      echo "Processing mode: $mode, OOB Code: $oobCode";      case $mode in         verifyEmail)             echo "Verifying email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:update?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         resetPassword)             echo "Resetting password for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         recoverEmail)             echo "Recovering email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Function to initiate an action
initiate_action() {     local mode="$1";      echo "Initiating $mode for $EMAIL...";      case $mode in         verifyEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"VERIFY_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         resetPassword)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"PASSWORD_RESET\",\"email\":\"$EMAIL\"}" | jq;             ;;         recoverEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"RECOVER_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Main Menu
echo "Firebase Auth Automation Script"
echo "Email: $EMAIL"
echo "1. Verify Email"
echo "2. Reset Password"
echo "3. Recover Email"
echo "4. Handle OOB Code"
echo "Choose an option (1-4):"
read -r option
case $option in     1)         initiate_action "verifyEmail";         ;;     2)         initiate_action "resetPassword";         ;;     3)         initiate_action "recoverEmail";         ;;     4)         echo "Enter the OOB Code:";         read -r oobCode;         echo "Enter the mode (verifyEmail, resetPassword, recoverEmail):";         read -r mode;         handle_oob_code "$oobCode" "$mode";         ;;     *)         echo "Invalid option.";         ;; esac
#!/bin/bash
# Firebase Auth Automation Script
# Email: allyelvis6569@gmail.com
# This script handles Firebase OOB actions like verifyEmail, resetPassword, etc.
# Configuration
FIREBASE_API_URL="https://identitytoolkit.googleapis.com/v1/accounts"
API_KEY="AIzaSyDloF8BhJTvAV8LZAlEplSX42cPP_LwIsw" # Replace with your Firebase Web API Key
EMAIL="allyelvis6569@gmail.com"
# Function to handle OOB codes
handle_oob_code() {     local oobCode="$1";     local mode="$2";      echo "Processing mode: $mode, OOB Code: $oobCode";      case $mode in         verifyEmail)             echo "Verifying email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:update?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         resetPassword)             echo "Resetting password for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         recoverEmail)             echo "Recovering email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Function to initiate an action
initiate_action() {     local mode="$1";      echo "Initiating $mode for $EMAIL...";      case $mode in         verifyEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"VERIFY_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         resetPassword)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"PASSWORD_RESET\",\"email\":\"$EMAIL\"}" | jq;             ;;         recoverEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"RECOVER_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Main Menu
echo "Firebase Auth Automation Script"
echo "Email: $EMAIL"
echo "1. Verify Email"
echo "2. Reset Password"
echo "3. Recover Email"
echo "4. Handle OOB Code"
echo "Choose an option (1-4):"
read -r option
case $option in     1)         initiate_action "verifyEmail";         ;;     2)         initiate_action "resetPassword";         ;;     3)         initiate_action "recoverEmail";         ;;     4)         echo "Enter the OOB Code:";         read -r oobCode;         echo "Enter the mode (verifyEmail, resetPassword, recoverEmail):";         read -r mode;         handle_oob_code "$oobCode" "$mode";         ;;     *)         echo "Invalid option.";         ;; esac
#!/bin/bash
# Firebase Auth Automation Script
# Email: allyelvis6569@gmail.com
# This script handles Firebase OOB actions like verifyEmail, resetPassword, etc.
# Configuration
FIREBASE_API_URL="https://identitytoolkit.googleapis.com/v1/accounts"
API_KEY="AIzaSyDloF8BhJTvAV8LZAlEplSX42cPP_LwIsw" # Replace with your Firebase Web API Key
EMAIL="allyelvis6569@gmail.com"
# Function to handle OOB codes
handle_oob_code() {     local oobCode="$1";     local mode="$2";      echo "Processing mode: $mode, OOB Code: $oobCode";      case $mode in         verifyEmail)             echo "Verifying email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:update?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         resetPassword)             echo "Resetting password for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         recoverEmail)             echo "Recovering email for $EMAIL...";             curl -s -X POST "${FIREBASE_API_URL}:resetPassword?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"oobCode\":\"$oobCode\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Function to initiate an action
initiate_action() {     local mode="$1";      echo "Initiating $mode for $EMAIL...";      case $mode in         verifyEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"VERIFY_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         resetPassword)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"PASSWORD_RESET\",\"email\":\"$EMAIL\"}" | jq;             ;;         recoverEmail)             curl -s -X POST "${FIREBASE_API_URL}:sendOobCode?key=${API_KEY}"                 -H "Content-Type: application/json"                 -d "{\"requestType\":\"RECOVER_EMAIL\",\"email\":\"$EMAIL\"}" | jq;             ;;         *)             echo "Unknown mode: $mode";             ;;     esac; }
# Main Menu
echo "Firebase Auth Automation Script"
echo "Email: $EMAIL"
echo "1. Verify Email"
echo "2. Reset Password"
echo "3. Recover Email"
echo "4. Handle OOB Code"
echo "Choose an option (1-4):"
read -r option
case $option in     1)         initiate_action "verifyEmail";         ;;     2)         initiate_action "resetPassword";         ;;     3)         initiate_action "recoverEmail";         ;;     4)         echo "Enter the OOB Code:";         read -r oobCode;         echo "Enter the mode (verifyEmail, resetPassword, recoverEmail):";         read -r mode;         handle_oob_code "$oobCode" "$mode";         ;;     *)         echo "Invalid option.";         ;; esac
