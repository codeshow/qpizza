# docker build --no-cache --progress=plain -f .gitpod.Dockerfile .
FROM gitpod/workspace-full

RUN bash -c "brew install terraform"

ARG JAVA_SDK="17.0.7-amzn"
RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh \
    && sdk install java $JAVA_SDK \
    && sdk default java $JAVA_SDK \
    && sdk install jbang \
    && sdk install quarkus \
    && sdk install maven \
    "
